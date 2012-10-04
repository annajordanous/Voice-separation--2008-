function trainingData = extractTrainingData(varargin)
%  HMMdata = extractTrainingProbsTESTING
%
% Get probabilities of note transitions from training data fugue1tag and
% fugue2tag

% % Normalise both training data note matrices so that they are both in a
% % comparable key (C)
% fugue1tag = normalisePitches(fugue1tag, fugue1key);
% fugue2tag = normalisePitches(fugue2tag, fugue2key);
% 
% 
% % Extract individual voices by using the channel (voice 1 == channel 1 etc)
% fugue1V1 = getmidich(fugue1tag, 1);
% fugue1V2 = getmidich(fugue1tag, 2);
% fugue1V3 = getmidich(fugue1tag, 3);
% fugue2V1 = getmidich(fugue2tag, 1);
% fugue2V2 = getmidich(fugue2tag, 2);
% fugue2V3 = getmidich(fugue2tag, 3);
% 
% % Convert the MIDI data into a 1 row vector of pitches
% fugue1V1 = transpose(fugue1V1(:, 4));
% fugue1V2 = transpose(fugue1V2(:, 4));
% fugue1V3 = transpose(fugue1V3(:, 4));
% fugue2V1 = transpose(fugue2V1(:, 4));
% fugue2V2 = transpose(fugue2V2(:, 4));
% fugue2V3 = transpose(fugue2V3(:, 4));
% 
% % Get probability matrix corresponding to each voice, of transitions
% % between each pair of sequential notes in the voice
% 
% probsfugue1V1 = getProbs(fugue1V1);
% probsfugue1V2 = getProbs(fugue1V2);
% probsfugue1V3 = getProbs(fugue1V3);
% probsfugue2V1 = getProbs(fugue2V1);
% probsfugue2V2 = getProbs(fugue2V2);
% probsfugue2V3 = getProbs(fugue2V3);
% 
% % Get probability matrix corresponding to each voice, of the probability
% % with which a particular pitch appears in a voice
% 
% probsNotef1V1 = getNoteProbs(fugue1V1);
% probsNotef1V2 = getNoteProbs(fugue1V2);
% probsNotef1V3 = getNoteProbs(fugue1V3);
% probsNotef2V1 = getNoteProbs(fugue2V1);
% probsNotef2V2 = getNoteProbs(fugue2V2);
% probsNotef2V3 = getNoteProbs(fugue2V3);
% 
% % Average out the probability matrices for each voice V1, V2, V3
% 
% probsV1 = (probsfugue1V1+probsfugue2V1)/2;
% probsV2 = (probsfugue1V2+probsfugue2V2)/2;
% probsV3 = (probsfugue1V3+probsfugue2V3)/2;
% 
% probsNoteV1 = (probsNotef1V1+probsNotef2V1)/2;
% probsNoteV2 = (probsNotef1V2+probsNotef2V2)/2;
% probsNoteV3 = (probsNotef1V3+probsNotef2V3)/2;
% 
% HMMdata = {probsV1, probsV2, probsV3 probsNoteV1 probsNoteV2 probsNoteV3};
for i = 1:length(varargin)
    HMMdata(i) = varargin{i};
end
size(varargin)
HMMdata