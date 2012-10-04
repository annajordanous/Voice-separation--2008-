function tagged_fugue = tag_up(fugue)
% tagged_fugue = tag_up(fugue)
% 
% given the input notematrix 'fugue', construct a vector of tags
% representing the arrangement of voices in the fugue. For now these will
% all be initialised to the value '1' and will be manually altered
%
% The nth entry in the vector represents the ((n-1)/4)th beat in the fugue. For
% example the 7th entry in the vector represents beat 1.5 in the fugue
% ((7-1)/4 = 1.5)
% NB It is n-1/4 rather than n/4 because the notematrix might hold
% information about notes starting on beat 0, but a vector couldn't be
% referenced as vector(0)

fugue = add_last_column(fugue);

last_beat = max(fugue(:, 8));
for i = 1:((last_beat*4)+1)
    tagged_fugue(i) = 1;
end
