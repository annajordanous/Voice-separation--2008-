function probability = prob_of_one_item(vector, item)
% probability = prob_of_one_item(vector, item)
%
% This function extracts the probability of a given item being an element
% of a given vector 

counter = 0;
for i = 1:size(vector, 1)
    if vector(i) == item
        counter = counter+1;
    end
end
probability = counter / size(vector, 1);