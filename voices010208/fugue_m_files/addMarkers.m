function [voices, nmat8, probRecords] = addMarkers(nmat8, markers, noOfVoices, probRecords)
% [voices, nmat8, probRecords] = addMarkers(nmat8, markers, noOfVoices,
%                                                           probRecords)
%
% The parameter markers contains a list of beats for which the voice 
% allocations have been determined, in the format:
%
% [nmatIndex     voice1pitch   voice2pitch    ...   voiceNpitch]
%
% This function marks up these points in the notematrix and returns a MIDI
% notematrix (7 columns) voices with the channel representing which voice
% each MIDI note belongs to

voices = nmat8(:, 1:7);

for i = 1:size(markers, 1)
    
     pitches = markers(i,(noOfVoices+1):size(markers,2));
     
     for j = 1:noOfVoices
         for v = 1:noOfVoices
             if nmat8(markers(i, j), 4) == pitches(v)
         
             voices(markers(i,j),3) = v;
             nmat8(markers(i,j), 3) = v;
             
             % Record probability information
             nmat8(markers(i, j), 7) = 1;
             probRecords(markers(i, j), v) = 1;
             break
             end
         end
         
% probRecords(markers(i, j), noOfVoices+1) = 13;
     end
     
end

voices = nmat8(:, 1:7);
        