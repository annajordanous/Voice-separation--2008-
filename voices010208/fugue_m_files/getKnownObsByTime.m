function obs = getKnownObsByTime(nmat8, currentVoice, currentPoint, counter)
% obs = getKnownObsByTime(nmat8, currentVoice, currentPoint, counter);
%
% Returns an array containing a number of most recent observations from prior 
% to the current point (this number is specified by the counter parameter).
% NB The current point is the point in the MIDI notematrix which is being
% allocated to a voice, hence a voice has not yet been allocated to this
% voice and it cannot be included in the list of observations.

obs = [];
noOfVoices = max(nmat8(:, 3));
currentPoint = currentPoint - 1;
currentBeat = nmat8(currentPoint, 1);


while counter>0 && currentBeat >= 0
    if currentPoint > 0
        currentNotes = currentNotesByVoice(currentBeat, nmat8, noOfVoices);
        obs(counter, :) = currentNotes(currentVoice);
        currentBeat = currentBeat - nmat8(currentPoint, 2);
    else obs(counter, :) = 999;
        currentBeat = findNextSmallestBeat(nmat8, currentBeat);
    end
    counter = counter - 1;
    currentPoint = findCurrentPoint(nmat8, currentBeat, currentVoice);
    
end



%{

% Alternative solution

obs = [];
noOfVoices = max(nmat8(:, 3));

currentBeat = nmat8(currentPoint, 1);
nextBeat = currentBeat;

while counter>0 && currentPoint > 1
    while currentBeat>= nextBeat
        currentPoint = currentPoint - 1;
        currentBeat = nmat8(currentPoint, 1);
    end
    currentNotes = currentNotesByVoice(currentBeat, nmat8, noOfVoices);
    
    
    obs(counter, :) = currentNotes(currentVoice);
    counter = counter - 1;
    nextBeat = currentBeat;
end
%}


