function [prior, transmat, obsmat] = extract_HMM_settings(nmat)
% [prior, transmat, obsmat] = extract_HMM_settings(notematrix)
%
% Empirically extract  HMM settings for a bach fugue based on the training
% notematrix given.
%
% For now assume the given notematrix is annotated with two extra columns,
% column 8 showing the last beat at which each note is sounding before it
% is turned off, and column 9 showing the relative pitch of the note
% compared to the key of the fugue (around a pivot of the tonic note 
% closest to and above middle C). Also the channel column, column 3, will
% be amended beforehand to tag each note as belonging to voice 1 (top
% voice), voice 2 (second highest voice), etc.

% Sort the notematrix, first by beat no (ascending) and then by note pitch
% (ascending)
nmat = sortrows(nmat, [1, 4]);

% States = which voice we are in
no_of_states = max(nmat(:,3));

% Observations = what notes we hear
% There are 128 midi notes. Given that the notes are scaled relative to the
% key of the fugue, allow some space either side of the 128 notes for
% padding

no_of_obs = 140;

% Set prior probabilities of starting in each state to be equal to each
% other (as any voice may - in theory - be the first voice for the fugue)
% NB Double check this - is it true that each voice is equally likely to
% start?
prior = normalise(repmat(1, no_of_states, 1));
transmat = get_transitions(nmat, no_of_states);
obsmat = get_obs(nmat, no_of_states, no_of_obs);