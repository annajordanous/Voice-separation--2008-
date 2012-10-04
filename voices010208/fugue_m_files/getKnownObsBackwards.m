function obs = getKnownObsBackwards(nmat8, currentVoice, currentPoint, counter)
% obs = getKnownObs(nmat8, currentVoice, currentPoint, counter);
%
% Returns an array containing a number (counter) of the most recent 
% observations after the current point.
% NB The current point is the point in the MIDI notematrix which is being
% allocated to a voice, hence a voice has not yet been allocated to this
% voice and it cannot be included in the list of observations.

obs = [];
i = 1;
while i<=counter  && currentPoint < size(nmat8, 1)
    currentPoint = currentPoint + 1;
    if nmat8(currentPoint, 3) == currentVoice
        obs(i, :) = nmat8(currentPoint, 4);
        i = i + 1;
    end
end
