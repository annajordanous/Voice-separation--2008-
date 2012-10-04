function [notesAtTimeT, index] = getNotesAt(nmat,t)
% [notesAtTimeT, index] = getNotesAt(nmat,t)
%
% Take nmat = a matrix representing the notes that are
% playing at time t, where t*8 = i (the matrix index i = 0.125 t (1/8 t)
% So for example the notes being played at beats 2.5 are at the index 2.5*8
% = 20
% Returns the notes playing at the specified time t

index = t*8;
if index > size(nmat, 1) | index < 1
    notesAtTimeT = [];
else notesAtTimeT = nmat(index, :);
end