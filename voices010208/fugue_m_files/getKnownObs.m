function obs = getKnownObs(nmat8, currentVoice, currentPoint, counter)
% obs = getKnownObs(nmat8, currentVoice, currentPoint, counter);
%
% Returns an array containing a number of most recent observations from prior 
% to the current point (this number is specified by the counter parameter).
% NB The current point is the point in the MIDI notematrix which is being
% allocated to a voice, hence a voice has not yet been allocated to this
% voice and it cannot be included in the list of observations.

obs = [];

while counter>0 && currentPoint > 1
    currentPoint = currentPoint - 1;
    if nmat8(currentPoint, 3) == currentVoice
        obs(counter, :) = nmat8(currentPoint, 4);
        counter = counter - 1;
    end
end
