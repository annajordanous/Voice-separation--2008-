function transmat = get_transitions(nmat, no_of_states)
% transmat = get_transitions(notematrix, no_of_states)
%
% This function extracts the probability of all state transitions in a given
% notematrix (which has been sorted and annotated)

% Initialise return matrix so that all probabilities are initially 0
transmat = repmat(0, no_of_states, no_of_states);

% Extract the probabilities of each transition from the training notematrix
for i = 1:(size(nmat,1)-1)
    first_state = nmat(i,3);
    second_state = nmat((i+1),3);    
    transmat(first_state, second_state) = transmat(first_state, second_state)+1;
end

transmat = smooth_and_normalise(transmat);