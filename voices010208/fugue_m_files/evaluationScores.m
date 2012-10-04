function results = evaluationScores(voiceTags, testSet)
% results = evaluationScores(voiceTags{j}, testSet{j})
%
% Compare the results of using getVoices to allocate voices to a piece of 
% music against the actual allocation it should have been.
%
% results = {TP, FP, TN, FN, precision, recall, F} :
%
%   TP(v) = the number of true positive identifications in voice v
%       i.e. notes in voice v that were successfully allocated to voice v
%
%   FP(v) = the number of false positive identifications in voice v
%       i.e. notes in voice v that were falsely allocated to voice v
%
%   TN(v) = the number of true negative identifications in voice v
%       i.e. notes in voice v that were correctly not allocated to voice v
%
%   FN(v) = the number of false negative identifications in voice v
%       i.e. notes in voice v that were not allocated to voice v but that
%       did actually belong to voice v
%
%
%   precision(v) = how accurate the allocations were for voice v
%      precision = TP / (FP + TP)
%
%   recall(v) = how much of voice v was successfully allocated to voice v
%      recall = TP / (TP + FN)
%
%   F(v) = a measure of the overall success of the performance of getVoices
%      F = (2 * precision * recall) / (precision + recall) 

results = [];