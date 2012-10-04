function currentNotes = strip999s(notes)
% currentNotes = strip999s(notes)

for i = 1:size(notes, 2)
    if notes(1, i) ~= 999
        newNotes(i) = notes(1, i);
    end
end

currentNotes = newNotes;