fugue = readmidi('work/fugue.midi');
[subject, next_voice_entry_beat, marked_fugue] = get_subject(fugue);
[answer, marked_fugue2] = find_answer(marked_fugue, subject, next_voice_entry_beat);

voice8SUBJECT = getmidich(marked_fugue2, 8)
voice7ANSWER  = getmidich(marked_fugue2, 7)

