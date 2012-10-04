function markers = reformatMarkers(markers, noOfVoices)
% markers = reformatMarkers(markers, noOfVoices)
%
% Transform the markers matrix from 
%  [index1 index2 ... indexN note1 note2 ... noteN]
% to
%  [ index1
%    index2
%     ...
%    indexN ]


markers2 = markers(:, 1:noOfVoices);
markers = [];
for i=1:size(markers2, 1)
    markers = [markers; transpose(markers2(i,:))];
end
    
markers = unique(markers);