function [voices, nmat8, probRecords] = getVoices(nmat, key, noOfVoices, HMMdata)
% function voices = getVoices(notematrix, key, noOfVoices, HMMdata)
%
% Run this function to separate a notematrix (MIDI file of a bach fugue)
% into the individual voices that make up the fugue


% Prior to any processing, translate the notematrix into the 'normalised'
% key of C major so that the training data is not affected by different
% fugues being in different keys

nmat = normalisePitches(nmat, key);

% -----------------------------------------------------------------------
% STEP 1: Find marker points - where the voices are positioned far apart
% from each other to a degree such that they can be assumed to be separable
% into each voice using their relative pitch positions. Mark these points
% in the notematrix using the channel column
% -----------------------------------------------------------------------

% Find the highest and lowest note in the fugue
highestNote = max(pitch(nmat));
lowestNote  = min(pitch(nmat));


% Make sure the nmat is sorted in order of ascending beat and then by pitch
nmat = sortrows(nmat, [1,4]);


% Annotate the notematrix with an 8th column which marks, for each note,
% the beat at which the note stops sounding
nmat8 = add_last_column(nmat);

% Initialise the nmat8 with dummy values for the channel column (which
% indicates the voice) and the 7th column which will be used later to 
% record the probability of the voice allocation being correct

nmat8(:, 3) = 0.0;
nmat8(:, 7) = 0.0;

% Find the number of MIDI notes listed in the notematrix
noOfNotesInNmat = size(nmat8, 1);


% Convert the notematrix into a matrix representing the notes that are
% playing at time t, where t*8 = i (the matrix index i = 0.125 t (1/8 t)
% So for example the notes being played at beats 2.5 are at the index 2.5*8
% = 20
% nmatByTime = nmat2time(nmat8, noOfVoices, lastBeat, 999);

% Use the MIDI channel column to mark which voice each  note belongs to

nmat8(:,3) = 0; % Initialise the channel setting to a dummy value of 0

% Set up record of probabilities for each point (for info)
probRecords = [{}];

% Works out points in a fugue for which it is relatively likely that there
% is no crossover in the voices in the fugue
%
% Here the assumption is made that if all voices are sounding, and the
% sounding notes are positioned far apart from each other in pitch, then it
% is probable that the notes can be allocated to voices depending on the
% pitch order they occur in.
%
% markers format is:
%      [nmatIndex     voice1pitch   voice2pitch    ...   voiceNpitch]

markers = findLikely(nmat8, noOfVoices, highestNote, lowestNote);


% Mark up these points in the notematrix

[voices, nmat8, probRecords] = addMarkers(nmat8, markers, noOfVoices, probRecords);



% -----------------------------------------------------------------------
% STEP 2: Given the marker points identified so far, allocate the remaining
% notes to a voice depending on HMM probabilities concerning their pitch
% relative to the other notes
% -----------------------------------------------------------------------

% Set up HMM settings
% [priorProb, transitionsProb, observationsProb] = trainHMM(HMMdata,...
% highestNote, lowestNote);



% Do first section from first marker, backwards, to the end

[voices, nmat8, probRecords] = toFirstMarker(nmat8, markers(1), noOfVoices, 0, HMMdata, probRecords);

% Do each section from marker to marker, until the last marker is reached
for i=1:(size(markers, 1)-1)
    [voices, nmat8, probRecords] = marker2marker(...
        nmat8, markers(i), noOfVoices, (markers(i+1)-1), HMMdata, probRecords);
end

% Do last section from last marker, forwards, to the end

[voices, nmat8, probRecords] = marker2marker(...
    nmat8, markers(size(markers, 1)), noOfVoices, ...
    noOfNotesInNmat, HMMdata, probRecords);




% POST-PROCESSING
% Translate the fugue back into its original key (i.e. reverse the
% normalisation process that was done at the beginning of this function)
voices = unNormalisePitches(voices, key);
nmat8  = unNormalisePitches(nmat8, key);