function nmat = unNormalisePitches(nmat, key)
% normalisedPitches = normalisePitches(nmat, key)
%
% Transpose pitches in the given notematrix from the specified key to C
% The key must be specified in single quote marks 
% and be from the following list: 
%
% [C, C#, Db, D, D#, Eb, E, F, F#, Gb, G, G#, Ab, A, A#, Bb, B]
%
% (case sensitive)

switch key
    case {'C'}
        transpose = 0;
    case {'C#', 'Db'}
        transpose = 1;
    case {'D'}
        transpose = 2;
    case {'D#', 'Eb'}
        transpose = 3;
    case {'E'}
        transpose = 4;
    case {'F'}
        transpose = 5;
    case {'F#', 'Gb'}
        transpose = 6;
    case {'G'}
        transpose = -5;
    case {'G#', 'Ab'}
        transpose = -4;
    case {'A'}
        transpose = -3;
    case {'A#', 'Bb'}
        transpose = -2;
    case {'B'}
        transpose = -1;

end
nmat(:, 4) = nmat(:, 4) + transpose;
