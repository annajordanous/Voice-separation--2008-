% Attempt 1: very simple attempt to split up a fugue into three voices.
% The range of the notes in the fugue is split into
% three regions according to pitch, each corresponding to either the
% lower voice, middle voice or upper voice in the fugue.

% ----------------------------------------------------------------------
fugue = readmidi('fugue.midi');

% Calculate the range of notes in the fugue
lowestMIDI  = min(fugue(:,4));
highestMIDI = max(fugue(:,4));

MIDIvoice_range = (highestMIDI - lowestMIDI) / 3; % For a three-part fugue

% Set range of notes for each voice by marking the lowest
% MIDI note in each range
lower  = lowestMIDI;
middle = lower  + MIDIvoice_range;
upper  = middle + MIDIvoice_range;

% Allocate each note in the fugue to either the lower (4), 
% middle (5) or upper (6) voice depending on the note's pitch
for i = 1:length(fugue)
    if fugue(i,4) < middle
         fugue(i,3) = 4;        % lower voice
    elseif fugue(i,4) < upper
         fugue(i,3) = 5;        % middle voice
    else fugue(i,3) = 6;         % upper voice
    end
end

% Separate the three voices into three separate matrices
counterL = 0;
counterM = 0;
counterU = 0;
counterOther = 0;

for i = 1:length(fugue)
    if fugue(i, 3) == 4         % lower voice
        counterL = counterL + 1;
        fugueL(counterL, :) = fugue(i, :);
    elseif fugue(i, 3) == 5     % middle voice
        counterM = counterM + 1;
        fugueM(counterM, :) = fugue(i, :);
    elseif fugue(i, 3) == 6     % upper voice
        counterU = counterU + 1;
        fugueU(counterU, :) = fugue(i, :);
    else counterOther = counterOther + 1;
        fugueOther(counterOther, :) = fugue(i, :);
    end
end