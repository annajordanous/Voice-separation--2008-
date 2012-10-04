function [modified_fugue, key] = modify_fugue(fugue)
% [fugue_with_relative_pitches_and_note_lengths_added, key] =
% modify_fugue(fugue)
% 
% For a fugue in MIDI toolbox format (7th column), return a matrix which 
% has the MIDI information about the fugue, as well as two extra columns:
% 8th column: The last beat that the note sounds on before it stops
% sounding
% This is done by using the function add_last_column
% 9th column: The note pitch relative to the key it is in. 
% So the function last_root is used to estimate the key of the fugue
% Then for each note, the 9th column represents the note's position in that
% key

modified_fugue(:, 1:8) = add_last_column(fugue);
modified_fugue(:, 9) = repmat(0, length(fugue), 1);

% set key note to be the 1st tonic note in the MIDI range 0 - 127
key = last_root(fugue);

for i = 1:length(modified_fugue)
    modified_fugue(i, 9) = modified_fugue(i, 4) - key;
end
