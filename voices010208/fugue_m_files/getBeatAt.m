function beatAtIndexI = getBeatAt(i)
% beatAtIndexI = getBeatAt(i)
%
% This relates to nmat = a matrix representing the notes that are
% playing at time t, where t*8 = i (the matrix index i = 0.125 t (1/8 t)
% So for example the notes being played at beats 2.5 are at the index 2.5*8
% = 20
% Returns the beat no. corresponding to the specified nmat index i

beatAtIndexI = i/8;