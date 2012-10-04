function currently_sounding = currentNotesByVoice(current_beat, fugue, noOfVoices)
% currently_sounding = currentNotesByVoice(current_beat, fugue, noOfVoices)
%
% returns a vector of all the notes currently sounding at the given beat
% This vector contains, for each note:
%   [pitch of note j in the fugue, j, duration of note j in the fugue]

% NB This is quite inefficient at the mo - could do with making more 
% efficient e.g. by sorting the notematrix before searching

currently_sounding = repmat(999, 1, noOfVoices);
for j=1:size(fugue, 1)
    if fugue(j,8) > current_beat && fugue(j,1) <= current_beat
        currently_sounding(fugue(j, 3)) = fugue(j,4);
    end
end

