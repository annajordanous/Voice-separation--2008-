function [fugues, voiceData] = getFugues
% [fugues, voiceData] = getFugues
%
% Read in the 48 fugues from Well Temperered Clavier into the cell fugues.
% Also store information in voiceData on how many voices each fugue has
%
% NB This function leaves Matlab in the folder: 
% /Applications/MATLAB74/work/
%

cd /Applications/MATLAB74/work/



for i=1:48
    i
    if i<10 
        fugues{i} = readmidi(strcat('fugues/wtc1f0', int2str(i),'.mid'));
    elseif i<=24 
        fugues{i} = readmidi(strcat('fugues/wtc1f', int2str(i),'.mid'));       
    else
        i2 = i-24;
        if i2<10 
            fugues{i} = readmidi(strcat('fugues/wtc2f0', int2str(i2),'.mid'));
        else
            fugues{i} = readmidi(strcat('fugues/wtc2f', int2str(i2),'.mid'));
        end
    end
    voiceData(i, 1) = max(fugues{i}(:, 3));
    end
end