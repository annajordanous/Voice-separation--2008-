% Using the ability to work out which notes occur at the same time to 
% allocate voices to each note
% ----------------------------------------------------------------------

fugue = readmidi('fugue.midi');

% Extract bars 10(beat 1) to 19 (up to beat 1)
%
% beat_no = [ (bar_no - 1) x 1.5 ] + 0.5

start_point  = ((10-1)*1.5) + 0.5;
end_point    = ((19-1)*1.5) + 0.5;

counter = 0;
for i=1:length(fugue)
    if (onset(fugue(i),'beat') >= start_point) && (onset(fugue(i),'beat') <= end_point)
        counter = counter + 1;
        fugueExtract(counter,:) = [fugue(i,:) 0]; % null value set in 8th column for now
        fugueExtract(counter,3) = 2;              % default channel is 2 (for middle voice)
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



% Work out what notes are sounding at a given time


% NEW FROM HERE
% Go through file note by note and allocate channels
% This current method is VERY INEFFICIENT - N*N

for current_beat=onset(fugueExtract(1,:)):0.25:onset(fugueExtract(length(fugueExtract),:))
    currently_sounding = [];
    for j=1:length(fugueExtract)
        if fugueExtract(j,8) > current_beat && onset(fugueExtract(j,:)) <= current_beat
            currently_sounding = [currently_sounding;pitch(fugueExtract(j,:)) j];
        end
    end
    switch (max(currently_sounding(:,1)))   % assume max of three different notes sounding
        case {currently_sounding(1,1)}
            fugueExtract(currently_sounding(1,2),3) = 1;
        case {currently_sounding(2,1)}
            fugueExtract(currently_sounding(2,2),3) = 1;
        case {currently_sounding(3,1)}
            fugueExtract(currently_sounding(3,2),3) = 1;
    end
    switch (min(currently_sounding(:,1)))   % assume max of three different notes sounding
        case {currently_sounding(1,1)}
            fugueExtract(currently_sounding(1,2),3) = 3;
        case {currently_sounding(2,1)}
            fugueExtract(currently_sounding(2,2),3) = 3;
        case {currently_sounding(3,1)}
            fugueExtract(currently_sounding(3,2),3) = 3;
    end
%current_beat
%currently_sounding
%fugueExtract(currently_sounding(1,2):currently_sounding(3,2),:)

end

% remove non-MIDI column
finalFugueExtract = fugueExtract(:, 1:7);


% separate into voices according to the channel allocated
fugueL = getmidich(finalFugueExtract, 3);
fugueM = getmidich(finalFugueExtract, 2);
fugueU = getmidich(finalFugueExtract, 1);    