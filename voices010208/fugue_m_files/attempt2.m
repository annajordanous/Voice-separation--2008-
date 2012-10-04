% Attempt 2 to split up a fugue into three voices.
%
% An extended version of attempt 1 which was:
%   The range of the notes in the fugue is split into
%   three regions according to pitch, each corresponding to either the
%   lower voice, middle voice or upper voice in the fugue.
%
% For Attempt 2: Only allow the lower and upper parts to be monophonic. 
% If at any point these voices have more than one note allocated to them,
% move extra note(s)to the middle voice (so keep the lowest note for the 
% lower voice and move the other note(s) to the middle voice, etc).
%
% NB At this point, the middle voice is not guaranteed to be monophonic
% after this has finished processing - just the upper and lower voices
% will be monophonic.
%
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


% NEW content (the extension from Attempt 1)

% This currently makes the assumption that there are only two notes on the
% same beat. I need to extend this to allow for the possibility that there
% may be more than two notes sounding on the same beat.

for i = 1:(length(fugue)-1)
    % if there are two notes on the same beat [1] and in the same voice [3] 
    if (fugue(i,1) == fugue(i+1, 1) && fugue(i,3) == fugue(i+1, 3))
        % if these two notes are in the lower voice
        if fugue(i,3) == 4
            if fugue(i,4) < fugue(i+1,4) 
                fugue(i+1,3) = 5;
            else fugue(i,3) = 5;
            end
        % else if these two notes are in the upper voice
        else if fugue(i,3) == 6
                if fugue(i,4) > fugue(i+1,4)
                    fugue(i+1,3) = 5;
                else fugue(i, 3) = 5;
                end
            end
        end
    end
end


% END of NEW content

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
