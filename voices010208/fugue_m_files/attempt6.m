% Using the ability to work out which notes occur at the same time to 
% allocate voices to each note. Now it can take into account the fact that
% parts can include rests
% ----------------------------------------------------------------------

fugue = readmidi('fugue.midi');


fugue = trim(fugue);

% Add a column to fugue that represents the last beat that a note
% is sounding on
for i=1:length(fugue)
    end_beat = onset(fugue(i,:),'beat') + dur(fugue(i,:),'beat');
    fugue(i,8) = end_beat;
end

% Calculate the range of notes in the fugue
lowestMIDI  = min(fugue(:,4));
highestMIDI = max(fugue(:,4));

MIDIvoice_range = (highestMIDI - lowestMIDI) / 3; % For a three-part fugue

% Set range of notes for each voice by marking the lowest
% MIDI note in each range
lower  = lowestMIDI;
middle = lower  + MIDIvoice_range;
upper  = middle + MIDIvoice_range;


% Work out what notes are sounding at a given time

% Go through file note by note and allocate channels
% This current method is VERY INEFFICIENT - N*N

for current_beat=onset(fugue(1,:)):0.25:onset(fugue(length(fugue),:))
    currently_sounding = [];
    for j=1:length(fugue)
        if fugue(j,8) > current_beat && onset(fugue(j,:)) <= current_beat
            currently_sounding = [currently_sounding;pitch(fugue(j,:)) j];
        end
    end
    switch (size(currently_sounding,1))
        case {3}     % All three parts' currently sounding
        switch (max(currently_sounding(:,1)))   % assume max of three different notes sounding
            case {currently_sounding(1,1)}
                fugue(currently_sounding(1,2),3) = 1;
            case {currently_sounding(2,1)}
                fugue(currently_sounding(2,2),3) = 1;
            case {currently_sounding(3,1)}
                fugue(currently_sounding(3,2),3) = 1;
        end
        switch (min(currently_sounding(:,1)))   % assume max of three different notes sounding
            case {currently_sounding(1,1)}
                fugue(currently_sounding(1,2),3) = 3;
            case {currently_sounding(2,1)}
                fugue(currently_sounding(2,2),3) = 3;
            case {currently_sounding(3,1)}
                fugue(currently_sounding(3,2),3) = 3;
        end
        case {1}     % Only one part currently sounding
            % Allocate each note currently sounding to either the lower (3), 
            % middle (2) or upper (1) voice depending on the note's pitch
            if currently_sounding(1,1) < middle
                     fugue(currently_sounding(1,2),3) = 3;        % lower voice
                elseif currently_sounding(1,1) < upper
                     fugue(currently_sounding(1,2),3) = 2;        % middle voice
                else fugue(currently_sounding(1,2),3) = 1;        % upper voice
            end
        case {2}     % Two of the three parts currently sounding
            for k=1:2
                if currently_sounding(k,1) < middle
                    fugue(currently_sounding(k,2),3) = 3;        % lower voice
                elseif currently_sounding(k,1) < upper
                    fugue(currently_sounding(k,2),3) = 2;        % middle voice
                else fugue(currently_sounding(k,2),3) = 1;        % upper voice
                end
            end
            if fugue(currently_sounding(1,2),3) == fugue(currently_sounding(2,2),3)
                if currently_sounding(1,1) > currently_sounding(2,1)
                    if fugue(currently_sounding(2,2),3) ~= 3
                    fugue(currently_sounding(2,2),3) = fugue(currently_sounding(2,2),3) + 1;
                    else fugue(currently_sounding(1,2),3) = 2;
                    end
                else 
                    if fugue(currently_sounding(2,2),3) ~= 1
                    fugue(currently_sounding(2,2),3) = fugue(currently_sounding(2,2),3) - 1;
                    else fugue(currently_sounding(1,2),3) = 2;
                    end
                end
            end
    end
end



% remove non-MIDI column
finalfugue = fugue(:, 1:7);


% separate into voices according to the channel allocated
fugueL = getmidich(finalfugue, 3);
fugueM = getmidich(finalfugue, 2);
fugueU = getmidich(finalfugue, 1);    