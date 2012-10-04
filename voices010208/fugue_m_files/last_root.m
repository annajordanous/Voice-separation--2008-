function key = last_root(fugue)
% key = last_root(fugue)
%
% Estimate the key of the bach fugue by seeing what the root note of the
% last chord is. 
% Returns key as a number 0, 1, ... 10, 11, representing C, C#, D etc
% respectively.

% Add a column representing, for each MIDI note, the last beat that 
% that note is sounding on
fugue = add_last_column(fugue);

% Find all notes that are sounding at the last beat
last_beat = max(fugue(:,8));
currently_sounding = current_notes(last_beat, fugue);

% Sort these notes into a vector of notes in descending order
currently_sounding = sortrows(currently_sounding, -1);

% The bass note is the key estimate. To work out the bass note, 
% take the last note in the currently_sounding vector and take the modulus
% 12 of this note.

bass_note = currently_sounding(length(currently_sounding));

key = mod(bass_note, 12);
        
