function HMMprob = getHMMprob(nmat8, currentVoice, currentNote, currentPoint, probsInt, probsPitch)
% HMMprob = getHMMprob(nmat8, currentVoice, currentNote, currentPoint, probsInt, probsPitch)
%
% Work out the probability of observation currentNote forming part of 
% the currentVoice 

% Get the 1 most recent pitches observed for the currentVoice
numObs = 1; 
pitchObs = getKnownObs(nmat8, currentVoice, currentPoint, numObs);


if size(pitchObs, 1) == 0 % i.e. there are no recent notes for the current voice
    intervalProb = 0;     % In this case we have no evidence for allocation 
else intervalProb = probsInt(pitchObs, currentNote);
end

pitchProb = probsPitch(currentNote);

HMMprob = intervalProb+pitchProb / 2;   % / 2 so prob value is between 0 and 1

