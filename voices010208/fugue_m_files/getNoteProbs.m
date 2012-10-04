function probs = getNoteProbs(voice)
% probs = getNoteProbs(voice)
%
% From a given sequence of notes forming a Bach fugue voice 
% given in the format [pitch1    pitch2    ...    pitchN]
% extract the probabilities of each pitch occurring in that voice
%
% NB There are 128 possible MIDI notes from 0 to 127. I will ignore MIDI
% notes 0 as it is not playable on a piano or harpsichord that Bach would
% have written for (or indeed a modern piano)



% Set up the vector 'probs' as an array of 127 notes, 
% For now, initialise each probability to be equally distributed, with the
% columns and rows summing up to 1 (this small constant acts as a smoothing
% constant when normalising the probability array later).

probs = repmat((1/127), 1, 127);


for i=1:size(voice, 2)
    index = voice(i);
    probs(index) = probs(index) + 1;
end


% Normalise the probability array so that each row sums to 1 (as use of a
% Markov Model requires this)

probs = mk_stochastic(probs);