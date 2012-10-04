function [mu, sd, prob] = fitGaussian(possibles, notes, region)
% [mu, sd, region, prob] = fitGaussian(possibles, notes)

% Fit Gaussian to these regions? Mean = midpoint of region, sd = ?
    sd = 6;
    % sd = voiceSpread/4; % As 95% of data is within 4 s.ds
    for i = 1:noOfVoices
        mu(i) = mean([region(i), region(i+1)]);
    end
    
    % Thirdly mark out all points in P for which the notes sounding fit the
    % distributions worked out in the second step. Return these points only.
    for i = 1:size(possibles, 1)
        currentNotes = notes(possibles(i),2:(noOfVoices+1));
        currentNotes = sort(currentNotes, 'descend');
        for j = 1:noOfVoices
            prob(i, j) = normpdf(currentNotes(j), mu(j), sd);
        end
        prob(i, (noOfVoices+1):(2*noOfVoices)) = currentNotes;
    end

