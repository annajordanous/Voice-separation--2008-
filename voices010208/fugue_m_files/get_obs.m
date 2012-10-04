function obsmat = get_obs(nmat, no_of_states, no_of_obs)
% obsmat = get_obs(notematrix, no_of_states, no_of_obs)
%
% Estimate a probability distribution of notes in a bach fugue
% given an annotated notematrix such that the channel represents which
% voice each note belongs to (1 = top voice, 2 = second highest voice, etc)


obsmat = repmat(0,no_of_states, no_of_obs);

for i = 1:length(nmat)
    current_state = nmat(i, 3);
    current_obs   = nmat(i, 9)+75;
    obsmat(current_state, current_obs) = obsmat(current_state, current_obs)+1;
end

obsmat = smooth_and_normalise(obsmat);