function probs = getProbs(voice)
% probs = getProbs(voice)
%
% From a given sequence of notes forming a Bach fugue voice 
% given in the format [pitch1    pitch2    ...    pitchN]
% extract the probabilities of going from one note to another
%
% NB There are 128 possible MIDI notes from 0 to 127. I will ignore MIDI
% notes 0 as it is not playable on a piano or harpsichord that Bach would
% have written for (or indeed a modern piano)



% Set up the matrix 'probs' as an array of 127*127 notes, with the row
% index representing the note the sequence interval is moving from, and the
% column index representing the note the sequence interval is moving to. 
% For now, initialise each probability to be equally distributed, with the
% columns and rows summing up to 1 (this small constant acts as a smoothing
% constant when normalising the probability array later).

probs = repmat((1/127), 127, 127);


for i=1:(size(voice, 2)-1)
    rowNo = voice(i);
    colNo = voice(i+1);
    probs(rowNo, colNo) = probs(rowNo, colNo) + 1;
end


% Normalise the probability array so that each row sums to 1 (as use of a
% Markov Model requires this)

probs = mk_stochastic(probs);