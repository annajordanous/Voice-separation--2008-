function key = getKey(music)
% key = getKey(music)
%
% Uses the MIDI toolbox implementation of the Krumhansl-Kessler key-finding 
% algorithm to identify the key of a piece and convert the key to a format
% which can be used in the getVoices program for identifying voices in
% voice-led music.
%
%  
%   Reference:
%  	Krumhansl, C. L. (1990). Cognitive Foundations of Musical Pitch.
%  	New York: Oxford University Press.
%   
%   kkkey: MIDI Toolbox function
%     Author		Date
%   P. Toiviainen	8.8.2002
% © MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland

keyNo = kkkey(music);
key = keyname(keyNo);