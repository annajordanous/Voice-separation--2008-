function trainingData3voices = extractTrainingData3voices(varargin)
% trainingData3voices = extractTrainingData3voices(varargin)
%
% Get probabilities of note pitches and transitions from the given 
% training data, which should be one or more 3-voice Bach fugues, as:
%
%   trainingData = extractTrainingData(fugue1, 'fugue1key', fugue2,
%   'fugue2key, ... fugueN, 'fugueNkey')
% 
% If not supplied in this format, this function will not work
% The key of the fugue should be enclosed in single quotes and be one of:
%
% [C, C#, Db, D, D#, Eb, E, F, F#, Gb, G, G#, Ab, A, A#, Bb, B]
%
% (case sensitive)

% Initialise variables
numFugues = size(varargin, 2) / 2;

probPitchV1 = 0;
probPitchV2 = 0;
probPitchV3 = 0;

probIntV1 = 0;
probIntV2 = 0;
probIntV3 = 0;


% NB: when referencing the paramaters, remember
% varargin{odd_numbers}  = fugue data
% varargin{even_numbers} = key data

for i=1:2:size(varargin, 2)
    fugue = varargin{i};
    key   = varargin{i+1};
    
    % Normalise training data so that it is in a neutral key (C)
    fugue = normalisePitches(fugue, key);     
    
    % Extract individual voices by using the channel (voice 1 == channel 1 etc)
    fugueV1 = getmidich(fugue, 1);
    fugueV2 = getmidich(fugue, 2);
    fugueV3 = getmidich(fugue, 3);
    
    % Convert the MIDI data into a 1 row vector of pitches
    fugueV1 = transpose(fugueV1(:, 4));
    fugueV2 = transpose(fugueV2(:, 4));
    fugueV3 = transpose(fugueV3(:, 4));     

    % Get probability matrix corresponding to each voice, of the probability
    % with which a particular pitch appears in a voice     
    probPitchV1 = probPitchV1 + getNoteProbs(fugueV1);
    probPitchV2 = probPitchV2 + getNoteProbs(fugueV2);
    probPitchV3 = probPitchV3 + getNoteProbs(fugueV3);
    
    % Get probability matrix corresponding to each voice, of transitions
    % between each pair of sequential notes in the voice
    probIntV1 = probIntV1 + getProbs(fugueV1);
    probIntV2 = probIntV2 + getProbs(fugueV2);
    probIntV3 = probIntV3 + getProbs(fugueV3);
     
end

% When all data has been examined, convert the output parameters into
% probabilities

probPitchV1 = probPitchV1/numFugues;
probPitchV2 = probPitchV2/numFugues;
probPitchV3 = probPitchV3/numFugues;
 
probIntV1 = probIntV1/numFugues;
probIntV2 = probIntV2/numFugues;
probIntV3 = probIntV3/numFugues;
 
trainingData3voices = {probIntV1 probIntV2 probIntV3 ... 
                        probPitchV1 probPitchV2 probPitchV3};
