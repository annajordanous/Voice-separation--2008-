function [weights, inputNode, outputNode] = ctrnn(N)
% [weights, inputNode, outputNode] = ctrnn(N)
%
% Creates settings for a new CTRNN (CTRNN = fully connected neural network 
% with temporal representation) with random weights and a randomly chosen 
% input node and output node.

% Generate an NxN array with weights in the range -0.5 to 0.5
weights = rand(N) - 0.5;

% Select 2 random integers between 1 and N and allocate these as the input
% and output nodes respectively
inputNode  = round(unifrnd(0.5,(N+0.5)));
outputNode = round(unifrnd(0.5,(N+0.5)));
