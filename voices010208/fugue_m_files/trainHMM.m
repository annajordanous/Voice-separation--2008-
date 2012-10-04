function [noOfStates, noOfObservations, transitionsProb, observationsProb] = trainHMM(HMMdata, noOfVoices)
% [noOfStates, noOfObservations, transitionsProb, observationsProb] =
%               trainHMM(HMMdata, noOfVoices)
%
% Train HMM settings according to the given data

noOfStates = noOfVoices; % Each HMM state represents a different voice
noOfObservations = 256; % largest interval there can be (there are 128 midi notes)

p = 1/noOfVoices;
q = 1/noOfObservations;

% Estimate HMM settings
% priorProb = repmat(p, 1, noOfVoices);  % Equal Probability

transitionsProb = repmat(p, noOfStates, noOfStates); % Equal probability

observationsProb = repmat(q, noOfVoices, noOfObservations); % Equal prob

trainingSeq = cell(noOfVoices);
trainingStates = cell(noOfVoices);

for i = 1:noOfVoices-1

    % Extract each voice from the training data
    voice = getmidich(HMMdata, i);
    voiceSeq = voice(:, 4) + 128;
    voiceSeq = voiceSeq';
    
    % Generate list of states for each voice
    states = repmat(i, 1, size(voiceSeq, 2));

    
end

%    [transitionsProb, observationsProb] = hmmestimate(voiceSeq, states);
    


