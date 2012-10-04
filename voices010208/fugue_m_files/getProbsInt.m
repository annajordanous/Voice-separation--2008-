function probs = getProbsInt(voice)
% probs = getProbsInt(voice)
%
% From a given sequence of notes forming a Bach fugue voice 
% given in the format 
%   [pitchInterval1    pitchInterval2    ...    pitchIntervalN]
% extract the probabilities of going from one note to another
%
% NB There are 128 possible MIDI notes from 0 to 127. So the range of
% intervals possible is up to 127 in either direction, + 127 or - 127,
% giving a total of 255 possibilities. In the probability array, I use a
% normalisation constant of adding 127, so a movement upwards of 2 MIDI
% notes is +2 + 127 = 129


% Set up the matrix 'probs' as an array of 255 poss intervals, with the row
% index representing the first interval of 2 sequential intervals, and the
% column index representing the second interval of the two. 

% For now, initialise each probability to be equally distributed, with the
% columns and rows summing up to 1 (this small constant acts as a smoothing
% constant when normalising the probability array later).

probs = repmat((1/255), 255, 255);


for i=1:(size(voice, 2)-1)
    rowNo = voice(i);
    colNo = voice(i+1);
    probs(rowNo, colNo) = probs(rowNo, colNo) + 1;
end


% Normalise the probability array so that each row sums to 1 (as use of a
% Markov Model requires this)

probs = mk_stochastic(probs);