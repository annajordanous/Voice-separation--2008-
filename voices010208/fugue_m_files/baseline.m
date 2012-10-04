function [initialised, fugue] = baseline(fugue)
% INIT Calculate a rough allocation of notes to each voice in the fugue
% [initialised, 8colFugue] = baseline(fugue)
%
% Using the ability to work out which notes occur at the same time to 
% allocate voices to each note
% This is done purely by seeing what pitch order notes are in.
% ----------------------------------------------------------------------

% Sort the fugue in ascending beat order
sortrows(fugue, 1);

% Add a column to fugue that represents the last beat that a note
% is sounding on
for i=1:length(fugue)
    end_beat = onset(fugue(i,:),'beat') + dur(fugue(i,:),'beat');
    fugue(i,8) = end_beat;
end


% Work out what notes are sounding at a given time

% Go through file note by note and allocate channels
% This current method is INEFFICIENT - N*N+M
current_beat=onset(fugue(1,:));
while current_beat<=onset(fugue(length(fugue),:))
    currently_sounding = [];
    for j=1:length(fugue)
        if fugue(j,8) > current_beat && onset(fugue(j,:)) <= current_beat
            currently_sounding = [currently_sounding;pitch(fugue(j,:)) j];
        end
    end
    currently_sounding_sorted = sortrows(currently_sounding, -1);
    for k=1:size(currently_sounding,1)
        fugue(currently_sounding_sorted(k,2),3) = k;
    end
    if current_beat<onset(fugue(length(fugue),:))
        current_beat = onset(fugue((max(currently_sounding(:, 2))+1), :));
    else current_beat = onset(fugue(length(fugue),:))+1;
        break;
    end
end

% remove non-MIDI column
initialised = fugue(:, 1:7);

% beat_no = [ (bar_no - 1) x beats_in_bar ] + 0.5