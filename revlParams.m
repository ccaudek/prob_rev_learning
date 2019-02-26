function prep = revl_params(sID, runTask, blue_img, orange_img)

%==========================================================================
% FUNCTION prep = revl_params(sID,runTask)
% 
% Create general parameter definitions for the probabilistic reversal task.
% This routine stores and returns all parameters in the structure 'prep'.
% This is called from revlRun when running the task, but can also be used
% to generate feedback sequences for simulation purposes. 
%
% sID = subject ID between 1-999
% runTask = boolean, set to 0 when just generating a stimulus sequence for
% data simulation purposes. 
% 
% NB: all timing parameters are given in seconds
% 
% version 2019_02_15
%==========================================================================

% PARAMETERS THAT NEED TO BE MODIFIED
%==========================================================================
% Total number of testing sessions for this subject in this study. Note
% that this is NOT the current testing day, and this number should NOT be
% altered during a study.

% =========================================================================
% A.    Trial sequence parameters
% =========================================================================

blocksequences{1}   = [40 40 40 40]; % length needs to be even number! 
blocks              = blocksequences{1};
prep.sID            = sID;
prep.prob           = 70 / 100; % feedback contingency 
prep.nStim          = 2;
prep.nt             = sum(blocks);

% generate the feedback sequence
probTrial = repmat([prep.prob 1-prep.prob], 1, length(blocks) / 2);
t = 0;
for b = 1:length(blocks)
    for x = 1:blocks(b)
        t = t + 1;
        feedbackprob(t) = probTrial(b);
        feedback(t) = double(rand(1) <= feedbackprob(t));
    end
end
prep.feedbackprob = feedbackprob(:);
prep.feedback = feedback(:);
prep.feedback(:, 2) = 1 - prep.feedback;

if runTask
    % B.    Psychtoolbox parameters to run the task
    % =========================================================================
    KbName('UnifyKeyNames');
    prep.left  = KbName('v');
    prep.right = KbName('m');
    prep.locID = {'left', 'right'};
    prep.dir.imgs = fullfile(fileparts(which('revlRun')), 'pics');
    
    % Sequence of the stimulus locations.
    prep.locs = mix([ones(floor(prep.nt/2), 1); 2*ones(ceil(prep.nt/2), 1)]);
    prep.locs(:, 2) = 3 - prep.locs;
    
    % Timing
    prep.time.coi   = 0; % choice-outcome interval
    prep.time.iti   = 1; % outcome-next trial interval in case of juice delivery
    prep.time.black = 0; % time the screen is black between outcome and next trial
    
    % Display and keyboard definitions
    prep.disp.screenNum = 0; % select monitor
    prep.disp.clrdepth  = 32; % colour settings monitor
    prep.abort          = KbName('ESCAPE'); % esc button
    prep.accept         = KbName('space');
    
    % Drawing parameters for location and size of the pictures and text.
    % Get screen size/resolution
    tmp = get(0, 'ScreenSize');
    wdw = tmp(3);
    wdh = tmp(4);
   
    prep.cue{1} = fullfile(prep.dir.imgs, blue_img);   % blue
    prep.cue{2} = fullfile(prep.dir.imgs, orange_img); % orange
    
    if (rand(1, 1) > 0.5)
        prep.cue{3} = fullfile(prep.dir.imgs, 'noise_1.jpg'); 
        prep.cue{4} = fullfile(prep.dir.imgs, 'noise_2.jpg'); 
    else
        prep.cue{3} = fullfile(prep.dir.imgs, 'noise_2.jpg'); 
        prep.cue{4} = fullfile(prep.dir.imgs, 'noise_1.jpg'); 
    end
    
       
%     prep.cue{3} = fullfile(prep.dir.imgs, 'slot1_down.jpg'); % blue
%     prep.cue{4} = fullfile(prep.dir.imgs, 'slot2_down.jpg'); % orange  
    
    
     
    % Drawing size parameters
    prep.draw.fx        = 7; % radius of the fixation cross
    prep.stimDistance   = wdh / 5; % OR 175 distance of the stimuli from the centre
    prep.draw.rStim     = round(wdh / 8); % OR 85
    prep.draw.rSmile    = round(wdh / 22);% OR 45
    prep.draw.rFrame    = prep.draw.rStim + round(0.01*wdh); % 'radius' of the square outside of the pie
    prep.draw.wdFrame   = 5;  % frame width
    % prep.draw.wdStrip   = 20;
    
    % Colors settings square frame
    prep.draw.grey      = [180 180 180];
    prep.draw.darkgrey  = [100 100 100];
    prep.draw.white     = [255 255 255];
    prep.draw.colFrame  = [200 200 200];
    
    % Text details
    prep.draw.font      = 'Helvetica';
    prep.draw.txtsize   = round(0.02*wdh);
end

return
