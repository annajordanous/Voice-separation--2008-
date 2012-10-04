function [voices, nmat8, probRecords] = toFirstMarker(nmat8, ...
                firstMarker, noOfVoices, startPoint, HMMdata, probRecords)
% [voices, nmat8, probRecords] = toFirstMarker(nmat8, ...
%                firstMarker, noOfVoices, endPoint, HMMdata, probRecords)
%
% Using the HMM probabilities, allocate voices to the notes in the first 
% section: from the first marker, backwards, to the start


currentPoint = firstMarker;
while currentPoint > (startPoint+1)
    currentPoint = currentPoint - 1;   % Look at the previous note in the nmat
    currentNote = nmat8(currentPoint, 4);  % Get the current pitch
    for i = 1:noOfVoices
        
        % Work out probability of this note being in voice i
        HMMprob = getHMMprobBackwards(nmat8, i, currentNote, currentPoint, firstMarker, cell2mat(HMMdata(i)));    
        prob(i, :) = [i HMMprob];  % Record this probability
    end
    
    % Allocate the note to a voice according to which voice has the highest
    % corresponding probability
    prob = sortrows(prob, -2);
    nmat8(currentPoint, 3) = prob(1,1);
    
    % For information purposes only: record the max probability value
    nmat8(currentPoint, 7) = prob(1,2);
    probRecords(currentPoint,:) = {prob};
end

voices = nmat8(:, 1:7);