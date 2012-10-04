
function modifiedFugue = add_last_column(fugue)

% modifiedFugue = add_last_column(fugue)
%
% Add a column to the given fugue that represents the last beat that a note
% is sounding on

for i=1:length(fugue)
    end_beat = onset(fugue(i,:),'beat') + dur(fugue(i,:),'beat');
    modifiedFugue(i,1:7) = fugue(i,:);
    modifiedFugue(i,8) = end_beat;
end