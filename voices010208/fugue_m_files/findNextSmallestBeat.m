function currentBeat = findNextSmallestBeat(nmat, beat)
% currentBeat = findNextSmallestBeat(nmat, beat)
%
% Finds the beat immediately prior to the specified current beat, for which
% some new MIDI note is sounding


% This relies on the notematrix nmat being sorted in order of ascending
% beat
nmat = sortrows(nmat, 1);


currentPoint = 1;
while nmat(currentPoint, 1) ~= beat
    currentPoint = currentPoint + 1;
    if currentPoint > size(nmat, 1)
        currentPoint = -1;
        break;
    end
    
end

if currentPoint <= 1 
    currentBeat = -1;
else
    currentPoint = currentPoint - 1;
    currentBeat = nmat(currentPoint, 1);
    while currentBeat == beat && currentPoint > 0
        currentPoint = currentPoint - 1;
        currentBeat = nmat(currentPoint, 1);
    end
end