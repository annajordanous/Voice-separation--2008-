fugue = readmidi('work/fugue.midi');
tags = [unique(fugue(:, 1)) repmat(0, length(unique(fugue(:,1))), 1)];