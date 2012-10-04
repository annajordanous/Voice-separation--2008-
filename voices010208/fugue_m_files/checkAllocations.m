function nmat8 = checkAllocations(nmat8, probRecords, currentBeat, currentVoice)
% nmat8 = checkAllocations(nmat8, probRecords, currentBeat, currentVoice)
%
% Find other voices already allocated at that beat and amend voice
% allocations according to associated probabilities, 
% so that only one note is allocated to a voice at any one time


% Find all notes allocated to currentVoice at currentBeat in the notematrix
allocationPoints = findOtherAllocations(nmat8, currentBeat, currentVoice);
 
% If more than one note is allocated to the currentVoice...
noOfAllocations = size(allocationPoints, 1);
 
if noOfAllocations > 1
 
    % Notes that started on a beat previous to the current beat have
    % priority over notes starting on the current beat
    allocationPoints = sortrows(allocationPoints, 2);
    if allocationPoints(1, 2) < currentBeat
        pointToBeReallocated = allocationPoints(2, 1);
    else
        % Find out which voice has the highest probability by sorting the
        % allocationPoints matrix in order of descending probability
        allocationPoints = sortrows(allocationPoints, -3);
        pointToBeReallocated = allocationPoints(2, 1);
    end
    
    
    currentBeat  = nmat8(pointToBeReallocated, 1);

    % Change the probability allocation to the current Voice to be 0 so
    % that this note can never be allocated to that current Voice
    % (because another note has already been allocated to it)
    probRecords(pointToBeReallocated, currentVoice) = 0;


    % Find the next most probable allocation
    prob = probRecords(pointToBeReallocated, :);
    [currentProb, currentVoice] = max(prob);

    % If there are no more probable notes (This will be the case when there
    % are more notes than voices, as sometimes happens in the last few bars
    % of a fugue), then the probability array prob will be filled with '0'
    if currentProb == 0  % i.e. the highest probability is 0
        
        % Assign this note to channel 0 (i.e. it is ignored)
        nmat8(pointToBeReallocated, 3) = 0;
        
        % Record that this note has no probability of being in any voice
        nmat8(pointToBeReallocated, 7) = 0;
        
    else
    
        % Apply this voice allocation in nmat8
        nmat8(pointToBeReallocated, 3) = currentVoice;

        % Record the max probability value in nmat8
        nmat8(pointToBeReallocated, 7) = currentProb;

        % Check this allocation is not duplicated
        nmat8 = checkAllocations(nmat8, probRecords, currentBeat, currentVoice);
    end
end
     
