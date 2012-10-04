function [v2, v3, v4, v5] = splitByVoice(fugues, voiceData)
% [v2oices, v3oices, v4oices, v5oices] = splitByVoice(fugues, voiceData)
%
% Split up the set of 48 fugues into sets with the same number of voices

counter2 = 0;
counter3 = 0;
counter4 = 0;
counter5 = 0;

for i=1:size(voiceData, 1)
    switch(voiceData(i, 2))
        case 2
            counter2 = counter2+1;
            v2{counter2} = fugues{i};
        case 3
            counter3 = counter3+1;
            v3{counter3} = fugues{i};
        case 4
            counter4 = counter4+1;
            v4{counter4} = fugues{i};
        case 5
            counter5 = counter5+1;
            v5{counter5} = fugues{i};
    end
end

sets = {v2 v3 v4 v5};
