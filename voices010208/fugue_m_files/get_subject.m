function [subject, next_voice_entry_beat, marked_fugue] = get_subject(fugue)
% [subject, next_voice_entry_beat, marked_fugue] = get_subject(fugue)
% 
% Works out an _approximate_ subject of the Fugue (i.e. the introductory
% theme of the fugue) by looking at the beginning of the MIDI file
% ('fugue'). Returns an annotated subject notematrix (9 columns long)
%
% Also returns the beat at which the fugue becomes polyphonic (i.e. where
% other voices become active)
%
% It is assumed that the first few bars of the fugue will be monophonic - 
% this is where the first voice introduces the subject of the fugue. 
% By taking this note pattern we can isolate the subject.

% Sort the MIDI file by beat onset column
fugue = sortrows(fugue, 1);
fugue(:,3) = repmat(1, 1, size(fugue,1));

% Add extra column to the MIDI file representing the last beat that this
% note is sounding on
fugue = add_last_column(fugue);

% Find the point in the MIDI file at which there is more than one voice
% active (i.e. more than one note sounding at the same time)

% NB This assumes that at the start of the fugue there is at most one voice
% sounding (this should be the case for all fugues? Check)
for i = 1:length(fugue)
    current_beat = onset(fugue(i));
    currently_sounding = current_notes(current_beat, fugue);
    if size(currently_sounding,1) > 1
        break;
    end
end


subject = fugue(1:(i-1), 1:7);
fugue(1:i, 3) = repmat(8, 1, i); 
marked_fugue = fugue;
next_voice_entry_beat = onset(fugue(i+1));