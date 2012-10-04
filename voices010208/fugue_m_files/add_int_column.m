
function modifiedFugue = add_int_column(fugue)

% modifiedFugue = add_last_column(fugue)
%
% Add a column to the given fugue that represents the last beat that a note
% is sounding on

for i=2:size(fugue, 1)
    interval = fugue(i, 4) - fugue((i-1), 4);
    modifiedFugue((i-1),1:8) = fugue((i-1),:);
    if i<size(fugue, 1)
        modifiedFugue(i,9) = interval;
    end
end