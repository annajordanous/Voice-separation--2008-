function nmatByTime = nmat2time(nmat, noOfVoices, lastBeat, fillerNo)
% nmatByTime = nmat2time(nmat, noOfVoices, lastBeat, fillerNo)
%
% Transform a MIDI notematrix into a matrix representing the notes that are
% playing at time t, where t*8 = i (the matrix index i = 0.125 t (1/8 t)
% So for example the notes being played at beats 2.5 are at the index 2.5*8
% = 20
%
% NB The parameter 'fillerNo' is used to fill up empty positions in the
% matrix

for i = 1:((lastBeat*8)-1)
    currentBeat = i/8;
    currentNotes  = current_notes(currentBeat, nmat)';
    if noOfVoices >= size(currentNotes, 2)
        filler = repmat(fillerNo, 1, (noOfVoices - size(currentNotes, 2)));
        nmatByTime(i,:) = [size(currentNotes, 2) currentNotes filler];
    else nmatByTime = [nmatByTime repmat(fillerNo, size(nmatByTime, 1), (size(currentNotes, 2)-noOfVoices))];
            noOfVoices = size(currentNotes, 2);
            nmatByTime(i,:) = [size(currentNotes, 2) currentNotes];
    end
end

