function voices = getVoices(nmat, key, noOfVoices, probData)
% function voices = getVoices(notematrix, key, noOfVoices, probData)
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


% Set up record of probabilities for each point (for info)
probRecords = [];

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

% Format the markers matrix so that one line corresponds to one nmat index
markers = reformatMarkers(markers, noOfVoices);

% -----------------------------------------------------------------------
% STEP 2: Given the marker points identified so far, allocate the remaining
% notes to a voice depending on HMM probabilities concerning their pitch
% relative to the other notes
% -----------------------------------------------------------------------
if size(markers, 1) > 2
    for i=2:(size(markers, 1) - 1)
        previousMarker = markers(i-1);
        currentMarker  = markers(i);
        nextMarker     = markers(i+1);

        if (currentMarker - previousMarker) > 1
            windowStart = floor(median([previousMarker currentMarker]));
             [voices, nmat8, probRecords] = marker2markerBackwards(nmat8, ...
                 currentMarker, noOfVoices, windowStart, probData, probRecords);
        end
        
        if (nextMarker - currentMarker) > 1
            windowEnd = floor(median([currentMarker nextMarker]));
            [voices, nmat8, probRecords] = marker2markerForwards(nmat8, ...
                currentMarker, noOfVoices, windowEnd, probData, probRecords);
        end
            
    end
end

% Do first section from first marker, backwards, to the end

[voices, nmat8, probRecords] = marker2markerBackwards(nmat8, ...
                markers(1), noOfVoices, 0, probData, probRecords);

% % Do each section from marker to marker, until the last marker is reached
% for i=1:(size(markers, 1)-1)
%     [voices, nmat8, probRecords] = marker2marker(...
%         nmat8, markers(i), noOfVoices, (markers(i+1)-1), probData, probRecords);
% end

% Do last section from last marker, forwards, to the end

[voices, nmat8, probRecords] = marker2markerForwards(...
    nmat8, markers(size(markers, 1)), noOfVoices, ...
    noOfNotesInNmat, probData, probRecords);




% POST-PROCESSING
% Translate the fugue back into its original key (i.e. reverse the
% normalisation process that was done at the beginning of this function)
voices = unNormalisePitches(voices, key);
nmat8  = unNormalisePitches(nmat8, key);