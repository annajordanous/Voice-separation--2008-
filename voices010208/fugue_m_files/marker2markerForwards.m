function [voices, nmat8, probRecords] = marker2markerForwards(nmat8, ...
                marker, noOfVoices, endPoint, HMMdata, probRecords)
% [voices, nmat8, probRecords] = marker2markerForwards(nmat8, ...
%                marker, noOfVoices, endPoint, HMMdata, probRecords)
%
% Using the HMM probabilities, allocate voices to the notes from the given 
% marker, forwards to the endPoint 
% (which is the last point that gets allocated a voice)


currentPoint = marker;
while currentPoint < endPoint && currentPoint < size(nmat8, 1) 
    currentPoint = currentPoint + 1;   % Look at the next note in the nmat
    currentNote = nmat8(currentPoint, 4);  % Get the current pitch
    for i = 1:noOfVoices
        
        % Work out probability of this note being in voice i
        HMMprob = getHMMprob(nmat8, i, currentNote, currentPoint, cell2mat(HMMdata(i)), cell2mat(HMMdata(i+noOfVoices)));    
        prob(i, :) = [i HMMprob];  % Record this probability
        probRecords(currentPoint, i) = HMMprob;
    end
    
% probRecords(currentPoint, noOfVoices+1) = 6;

% Record the probabilities of the note being in each voice
    % probRecords(currentPoint,:) = transpose(prob(:, 2));
    
    % Allocate the note to a voice according to which voice has the highest
    % corresponding probability
    prob = sortrows(prob, -2);
    nmat8(currentPoint, 3) = prob(1,1);
    
    % record the max probability value in nmat8
    nmat8(currentPoint, 7) = prob(1,2);    
    
    % Check that each voice is still monophonic (i.e. one note happening at
    % a time. If it is not, then re-adjust voice allocations according to
    % probabilities
    
    currentBeat  = nmat8(currentPoint, 1);
    currentVoice = prob(1,1);
    
    nmat8 = checkAllocations(nmat8, probRecords, currentBeat, currentVoice);
    

    % record the max probability value
    nmat8(currentPoint, 7) = prob(1,2);
end

voices = nmat8(:, 1:7);