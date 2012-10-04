function results = nFoldCrossValidation(dataset, keys, n, noOfVoices)
% results = nFoldCrossValidation(dataset, keys, n, noOfVoices)
%
% Perform n-fold cross validation on the training datasets provided, for
% the evaluation of the program getVoices.m
%
% e.g. results = nFoldCrossValidation(
%                           {fugues{2}, fugues{3}}, ['C', 'Csh'], 1, 3)


results        = [];
resultsCounter = 1;

% Divide the training data up into n sets
[partitionData, partitionKeys] = partitionDataset(dataset, keys, n)

% Carry out the following cross-validation steps n times
for i = 1:n
    
    % Assign the first dataset partition to be the test data
    testSet = partitionData{1};
    testKey = partitionKeys(1);
    
    % Assign the remaining (n-1) dataset partitions to be the training data
    for j = 2:n
        trainingSet{(j-1)} = partitionData{j}
        trainingKey((j-1)) = partitionKeys(j)
    end
    
    % Put the training data and keys in the right format
    trainingParameters = {};
    for j = 1:size(trainingSet, 2)
        trainingParameters{((2*j)-1)} = trainingSet{j};
        trainingParameters{(2*j)}     = trainingKey(j);
    end

    % Extract training probabilities from the training data:
    switch noOfVoices
        case 2
            probs = extractTrainingData2voices(trainingParameters);
        case 3
            probs = extractTrainingData3voices(trainingParameters);
        case 4
            probs = extractTrainingData4voices(trainingParameters);
        case 5
            probs = extractTrainingData5voices(trainingParameters);
    end
    
    % Go through each piece of music in the training set
    for j = 1:size(testSet, 2)
        
        % Use getVoices to work out voice allocations for this music
        voiceTags{j} = getVoices(testSet{j}, testKey{j}, noOfVoices, probs);
    
        % Extract performance ratings on how well voice allocation was done
        results{resultsCounter} = evaluationScores(voiceTags{j}, testSet{j});
        resultsCounter = resultsCounter + 1;
    end
    
    % Update trainingdataset for the next iteration of cross-validation
    s = size(trainingSet, 2);
    for j = 1:s
        partitionData{j} = trainingSet{j};
        partitionKeys{j} = trainingKey{j};
    end
    for j = 1:size(testSet, 2)
        partitionData{j+s} = testSet{j};
        partitionKeys{j+s} = testKey{j};
    end

end
    