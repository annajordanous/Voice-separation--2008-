function finalFugue = drop_last_column(modifiedFugue)
% finalFugue = drop_last_column(modifiedFugue)
% 
% Removes non-MIDI column from the 8 - column MIDI format used
% when analysing fugues
finalFugue = modifiedFugue(:, 1:7);