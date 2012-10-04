function beatNo = bar2beat(barNo, nBeatsInBar, lengthOfFirstBar)
% beatNo = bar2beat(barNo, nBeatsInBar)
%
% works out the beat number for a given bar number.
% Needs to know how many beats there are in a bar. This is measured in
% crotchets so for a 4/4 time signature, nBeatsInBar=4. For a 3/8 time
% signature, nBeatsInBar = (0.5)*3 = 1.5
% Also needs to know the number of beats in the first bar - in case the
% music is offset by an anacrusis

beatNo = (barNo - 1) * nBeatsInBar;
    if lengthOfFirstBar ~= nBeatsInBar
        beatNo = beatNo + lengthOfFirstBar;
    end
end

