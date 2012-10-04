function [partitionData, partitionKeys] = partitionDataset(dataset, keys, n)
% [partitionData, partitionKeys] = partitionDataset(dataset, keys, n);
%
% Partition the dataset and keys matrices into n folds, for n-fold cross
% validation
%
% N.B. |dataset| == |keys|


index(1) = 1;
noOfDatapoints = size(dataset, 2);
partitionData = {};

% If the dataset divides into n equal partitions, then partition the data
% this way
if rem(noOfDatapoints, n) == 0
    sizePartitions = noOfDatapoints/n;
else sizePartitions = floor(noOfDatapoints/n) - 1;
end

for i = 2:n
    index(i) = index(i-1) + sizePartitions;
end

index(n+1) = noOfDatapoints+1;

for p = 1:n
    offset = index(p);
    i = 0;
    while (i+offset)<index(p+1)
        partitionData{p}(i+1) = dataset(i+offset); 
        partitionKeys{p}(i+1) = keys(i+offset); 
        i = i+1;
    end
end