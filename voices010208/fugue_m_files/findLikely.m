 function markers = findLikely(nmat8, noOfVoices, highestNote, lowestNote)
% markers = findLikely(nmat8, noOfVoices, highestNote, lowestNote)
% 
% Works out points in a fugue for which it is relatively likely that there
% is no crossover in the voices in the fugue
%
% Here the assumption is made that if all voices are sounding, and the
% sounding notes are positioned far apart from each other in pitch, then it
% is probable that the notes can be allocated to voices depending on the
% pitch order they occur in.

% First find all points where all voices are sounding - store in P
% (Here be wary of points for which more than one note is sounding in a
% voice - however this is very rare and shall be ignored till later)
% Secondly work out (from the highest and the lowest note in the
% notematrix) the distribution of notes from each voice



% initialise parameters
markers = [];


% Calculate the note ranges which each voice will approximately fall into
noteSpread = highestNote - lowestNote + 1;
voiceSpread = floor(noteSpread/noOfVoices);
halfway = voiceSpread/4;
    
% current = highestNote;
% for i = 1:noOfVoices
%     region(i) = current;
%     current = current - voiceSpread;
% end
% region(noOfVoices+1) = lowestNote;
    

% Initialise counter variable
counter = 1;


for i = 1:size(nmat8,1)
    currentBeat = nmat8(i,1);
    
    % currentNotes is a list of note pitches sounding at that time,
    % sorted from highest pitch to lowest pitch

    [currentNotes, indices] = current_notes(currentBeat, nmat8);
    currentNotes = sort(currentNotes, 'descend');
    if size(currentNotes,1) == noOfVoices
        
        % Check that voices are well spread apart
        pitchDifferences = -1 * diff(currentNotes);
        if min(pitchDifferences) >= halfway
            
            % Check top voice is in upper end of top region
            % if currentNotes(1) >= (region(1) - halfway)
                % Check bottom voice is in bottom end of bottom region
                % if currentNotes(noOfVoices) <= region(noOfVoices+1)+halfway
                    
                    % If all these conditions are satisfied then a
                    % marker point has been found
                    markers(counter, :) = [indices' currentNotes' ];
                    counter = counter + 1;
                    % end
            %end
            
        end
    end
end

% Make sure the markers array only contains unique entries ( to avoid 
% duplication of effort) is sorted in ascending index order
markers = unique(markers, 'rows');



