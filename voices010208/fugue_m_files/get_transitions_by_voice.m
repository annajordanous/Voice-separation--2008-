function transmat = get_transitions_by_voice(nmat)
% transmat = get_transitions_by_voice(notematrix)
%
% This function extracts the probability of all note transitions in a given
% notematrix

% Initialise return matrix so that all probabilities are initially 0
transmat = repmat(0, length(nmat), length(nmat));

% Extract the probabilities of each transition from the training notematrix
for i = 1:(size(nmat,1)-1)
    first_note = nmat(i,9)+75;
    
    % Find next note in this voice (using the annotations in the channel column)
    second_note = 999;     % dummy value
    for j = 1:size(nmat,1)-i
        if nmat(j, 3) == nmat(i, 3)
            second_note = nmat(j, 9) + 75;
            break;
        end
    end
    switch (second_note)
        case {999}       % This means that the last note in that voice has been found
        otherwise
        transmat(first_note, second_note) = transmat(first_note, second_note)+1;
    end
end

transmat = smooth_and_normalise(transmat);
plot(transmat);