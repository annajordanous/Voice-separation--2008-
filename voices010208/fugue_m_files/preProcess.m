function obs = preProcess(pitches)
% obs = preProcess([pitchObs; currentNote])
%
% Convert pitchObs into a sequence of observations for the HMM
% This pre-processing steps converts the observations from absolute pitches
% into relative pitch differences between each time-step


obs = [];

for i=2:size(pitches,1)
    obs(:,i-1) = pitches(i) - pitches(i-1) + 128
end
