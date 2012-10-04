function voiceData = getNumVoices(fugues)
% voiceData = getNumVoices(fugues)
%
% Given a cell of data containing one or more fugues, return an array with
% the number of voices in each fugue (indexed the same as the fugues cell)


noOfFugues = size(fugues, 2);

for i=1:noOfFugues
    fugue = fugues{i};
    voiceData(i, :) = [i max(fugue(:, 3))];
end
