function probs = smooth_and_normalise(counts)
% probs = smooth_and_normalise(counts)
%
% % add some smoothing so that all notes have some probability, even if it is
% minute. 
% Two ways of doing this - either add a small constant or add some Gaussian
% weighting. For simplicity I'll just do the small constant for now. Size
% of constant was chosen at random

counts = counts + 0.05;

probs = mk_stochastic(counts);