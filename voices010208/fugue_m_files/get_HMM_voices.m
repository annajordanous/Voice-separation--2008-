function voiced_fugue = get_HMM_voices(fugue)
% voiced_fugue = get_HMM_voices(fugue)
% 
% Return the fugue MIDI notematrix with each note's channel designating the
% voice that the HMM thinks that note belongs to (channel 1 = top voice,
% channel 2 = second top voice, etc)


% Extract settings for prior, transmat and obsmat from training data if
% necessary
% [prior, transmat, obsmat] = extract_HMM_settings(testFugue);

% Pre process fugue to add a couple of extra columns used and to sort the
% fugue in order of beat no and then in order of note pitch(ascending)
[data, key] = modify_fugue(fugue);
data = sortrows(data, [1, 4]);

% Evaluate B(i,t) = P(y_t | Q_t=i) for all t,i (this step is taken from
% Kevin Murphy's guidelines)

B = multinomial_prob(data(:,9), obsmat);

% Use training data HMM settings to calculate the most likely path of 
% voices through the MIDI note matrix (this uses the 
path = viterbi_path(prior, transmat, B);

% Return the fugue MIDI notematrix with each note's channel designating the
% voice that the HMM thinks that note belongs to (channel 1 = top voice,
% channel 2 = second top voice, etc)

for i=1:length(data)
    voiced_fugue(i,1:2) = data(i, 1:2);
    voiced_fugue(i,3) = path(i);
    voiced_fugue(i, 4:7) = data(i, 4:7);
end
