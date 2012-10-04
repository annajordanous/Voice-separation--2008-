% Attempt 3 to split up a fugue into three voices.
%
% This attempt just looks at a section which has three voices, and 
% divides them up into lower, middle and upper depending on their pitch
% relative to each other
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
    if (fugue(i,1) >= start_point) && (fugue(i,1) <= end_point)
        counter = counter + 1;
        fugueExtract(counter,:) = fugue(i,:);
        fugueExtract(counter,3) = 2;
    end
end

% Normalise the extracted bars so that they start at the start of the file
% rather than 10 bars into the file (so remove the first 10 bars of
% silence)

trim(fugueExtract);

% Compare each note for a particular beat. Assign the lowest note channel
% 3, the middle note channel 2 and the upper note channel 1
% Assumption is that there are always three notes sounding in a beat


counter = 1;
while counter+2 <= length(fugueExtract)
    c = fugueExtract(counter, 4);
    c1 = fugueExtract(counter+1, 4);
    c2 = fugueExtract(counter+2, 4);
    switch (min([c c1 c2]))
        case {c}
            fugueExtract(counter, 3) = 3;
        case {c1} 
            fugueExtract(counter+1, 3) = 3; 
        case {c2}
            fugueExtract(counter+2, 3) = 3;
    end
    switch (max([c c1 c2]))
        case {c}
            fugueExtract(counter, 3) = 1;
        case {c1} 
            fugueExtract(counter+1, 3) = 1;
        case {c2}
            fugueExtract(counter+2, 3) = 1;
    end
    counter = counter + 3;
end

% Extract each voice into a separate matrix

fugueL = getmidich(fugueExtract, 3);
fugueM = getmidich(fugueExtract, 2);
fugueU = getmidich(fugueExtract, 1);