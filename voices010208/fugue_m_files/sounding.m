% Finding which notes occur at the same time
%
% ----------------------------------------------------------------------


fugue = readmidi('work/fugue.midi');

% Extract bars 10(beat 1) to 19 (up to beat 1)
%
% beat_no = [ (bar_no - 1) x 1.5 ] + 0.5

start_point  = ((10-1)*1.5) + 0.5;
end_point    = ((19-1)*1.5) + 0.5;

counter = 0;
for i=1:length(fugue)
    if (onset(fugue(i),'beat') >= start_point) && (onset(fugue(i),'beat') <= end_point)
        counter = counter + 1;
        fugueExtract(counter,:) = [fugue(i,:) 0];       % null value set in 8th column for now
        fugueExtract(counter,3) = 2;
    end
end

% Trim the leading silence
fugueExtract = trim(fugueExtract);

% Add a column to fugueExtract that represents the last beat that a note
% is sounding on
for i=1:length(fugueExtract)
    end_beat = onset(fugueExtract(i,:),'beat') + dur(fugueExtract(i,:),'beat');
    fugueExtract(i,8) = end_beat;
end


% NEW FROM HERE

% Work out what notes are sounding at a given time

% Here I want to know what notes are sounding at 3.5
current_beat = 4.5;

currently_sounding = [];

for i=1:length(fugueExtract)
    if fugueExtract(i,8) > current_beat && onset(fugueExtract(i,:)) <= current_beat
        currently_sounding = [currently_sounding;pitch(fugueExtract(i,:)) i];
    end
end



