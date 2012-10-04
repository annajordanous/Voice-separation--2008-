function [answer, marked_fugue] = find_answer(marked_fugue, subject, next_voice_entry_beat)
% [answer, marked_fugue2] = find_answer(marked_fugue, subject, next_voice_entry_beat)
%
% Uses the next_voice_entry_beat information and the notematrix containing
% the subject: to find an approximation of the real or tonal answer to the
% subject in the second voice of the given fugue


% At beat = next_voice_entry_beat, there should be two voices playing -
% double check?

% At beat = next_voice_entry_beat, if only one of the two voices playing is
% of the same length as the first note in the subject, then we can guess
% that this is the start of the second voice.


next_beat = next_voice_entry_beat;
end_marker = size(subject, 1) + 1;
ambiguous_beats = [];

for subject_index = 1:size(subject,1)
    notes_at_new_entry = current_notes(next_beat, marked_fugue);

    if subject(subject_index, 2) == notes_at_new_entry(1, 3) && subject(subject_index, 2) == notes_at_new_entry(2, 3)
        answer(subject_index, :) = marked_fugue(notes_at_new_entry(1, 2), 1:7);
        answer(end_marker, :)    = marked_fugue(notes_at_new_entry(2, 2), 1:7);
        answer(subject_index, 5) = 0;    % Don't know which one it is yet
        answer(end_marker, 5)    = 0;    % So mark both as silent (velocity = 0) for now
        end_marker = end_marker+1;       % size of answer is temporarily 1 larger
        ambiguous_beats = [ambiguous_beats; next_beat];
    elseif subject(subject_index, 2) == notes_at_new_entry(1, 3)
        answer(subject_index, :) = marked_fugue(notes_at_new_entry(1, 2), 1:7);
        marked_fugue(notes_at_new_entry(1, 2), 3) = 7;
    elseif subject(subject_index, 2) == notes_at_new_entry(2, 3)
        answer(subject_index, :) = marked_fugue(notes_at_new_entry(2, 2), 1:7);
        marked_fugue(notes_at_new_entry(2, 2), 3) = 7;
    end
    next_beat = next_beat + subject(subject_index, 2);       
end

if end_marker > (size(subject, 1) + 1)   % This means that there is at least one ambiguous note in the answer
    answer = sortrows(answer, 1);  % Sort the notematrix into order of beat number (ascending)
    [marked_fugue, answer] = choose_notes(marked_fugue, subject, answer, ambiguous_beats);
end


