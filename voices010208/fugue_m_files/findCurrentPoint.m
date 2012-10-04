function currentPoint = findCurrentPoint(nmat, beat, voice)
% currentPoint = findCurrentPoint(nmat, beat, voice)
%
% Returns the point in the notematrix where the onset beat = beat and the
% voice is the specified voice.

currentPoint = 1;
while (nmat(currentPoint, 1) ~= beat) || (nmat(currentPoint, 3) ~= voice)
    currentPoint = currentPoint + 1;
    if currentPoint > size(nmat, 1)
        currentPoint = -1;
        break;
    end
    
end

