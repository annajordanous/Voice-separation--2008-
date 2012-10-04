function allocationPoints = findOtherAllocations(nmat, beat, voice)
% allocationPoints = findOtherAllocations(nmat, beat, voice)
% 
% Find all voices already allocated at given onset beat to the given voice
% Returns allocationPoints as [indexPoint onsetBeat probabilityOfAllocation]

[currently_sounding, indices] = current_notes(beat, nmat);
allocationPoints = [];

counter = 1;
for i=1:size(indices, 1)
    if nmat(indices(i), 3) == voice % && nmat(indices(i), 7) > 0
        allocationPoints(counter, 1) = indices(i);           % index
        allocationPoints(counter, 2) = nmat(indices(i), 1);  % onset beat
        allocationPoints(counter, 3) = nmat(indices(i), 7);  % prob of allocation
        counter = counter + 1;
    end
end