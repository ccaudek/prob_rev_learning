function revlRun(sID, img_pair, is_psychopathy_reward_first, subject_name, block_of_trials)
% FUNCTION revl_run(sID, img_pair, is_psychopathy_reward_first, subject_name, block_of_trials)
%
% img_pair = a number from 1 to 9 that identifies the pair of psychopathy
% and neutral images defined in the script selectImgPair.m
% Numbers from 1 to 3 are for dishinibition
% Numbers from 4 to 6 are for boldness
% Numbers from 7 to 12 are for meanness
%
% Each subject must complete 9 blocks of trials. In each block, the value 
% img_pair will be different, with possible values going from 1 to 9, each
% value used once only for each subject. The sequence of the img_pair
% numbers will be randomly determined for each subject. For example, for
% one suject we have the sequence 274951386; for another subject the
% sequence 814273956, and so on.
%
% is_psychopathy_reward_first = if 1, yes; 0 = no. 
% If 1, the first epoch will reward the image related to psychopathy;
% otherwise, the first epoch rewards the neutral image.
%
% subject_name = subject identification code; MUST be between quotes!
%
% block_of_trials = integer starting from 1 and increasing for each
% subcessive block of trials
%
% When running different subjects, half will start with 
% is_psychopathy_reward_first = 1 and half will start with 
% is_psychopathy_reward_first = 0
%
% When running the same subject, half of the blocks will start with 
% is_psychopathy_reward_first = 1 and half will start with 
% is_psychopathy_reward_first = 0. However, the sequence of 1s and 0s will
% not always be the same. For example, for one subject, it will be
% 001101011, for another subject 001110101.
%
% This is the main code that runs the reversal task described below and
% will plot and save data to the 'data' subfolder. 
%
% TASK DESCRIPTION:
% 2 images are presented on every trial, each associated with either a 0.7 
% or a 0.3 probability of reward. 
% At various points during the task the identity of the high and low reward
% image are reversed. Subjects have to continuously keep track which
% image is currently best. 
% 
% In each block there are 4 epochs, with 40 trials each.
%
% The experiment parameters are set in the revlParams.m file. 
% 
% version 2019_02_15
%
% For example, consider the subject Mario Rossi.
%
% In different blocks of trials, the variable img_pair will take the values 
% 6, 2, 8, 3, 1, 4, 7, 9, 5; it will be equal to 6 in the first block, 2 in 
% the second block, ... Such sequence will change for each subject.
%
% The variable is_psychopathy_reward_first will be 1, 0, 0, 1, 0, 1, 1, 1, 
% 0, 1: 1 in the first block, 0 in the second block, ... Such sequence will 
% change for each subject.
%
% The variable subject_name will be 'mario_rossi_1993_03_23' in each block.
% Remember that this string must be written between quotes! NO SPACES are
% allowed.
%
% The last parameter is the block number. This will be used in sequence
% 1... 9 for every subject.
%
% These are the parameters used in the six runs of Mario Rossi:
%
% revlRun(23, 6,  1, 'mario_rossi_1993_03_23', 1);
% revlRun(23, 2,  0, 'mario_rossi_1993_03_23', 2);
% revlRun(23, 8,  0, 'mario_rossi_1993_03_23', 3);
% revlRun(23, 3,  1, 'mario_rossi_1993_03_23', 4);
% revlRun(23, 1,  0, 'mario_rossi_1993_03_23', 5);
% revlRun(23, 4,  1, 'mario_rossi_1993_03_23', 6);
% revlRun(23, 7,  1, 'mario_rossi_1993_03_23', 7);
% revlRun(23, 9,  1, 'mario_rossi_1993_03_23', 8);
% revlRun(23, 5,  0, 'mario_rossi_1993_03_23', 9);


% -------------------------------------------------------------------------
% Explanation of the output!
%
% In the output file saved in the data folder, we have:  
% - data.prep.locs = nx2 matrix with the locations of the stimuli on the
% screen; the first column indicates the img on the left, the second column
% indicates the stimulus on the right. 
%
% Orange is the stimulus that is rewarded. In the first of the four epochs
% the orange image is rewarded in the first and third blocks; the blue
% image is rewarded (most) in the second and fourth blocks.
% When is_psychopathy_reward_first == 1, then the orange image corresponds
% to the violent images; blue corresponds to neutral.
% For the violent images, the probability of reward is 0.7, 0.3, 0.7, 0.3
% in the four epochs.
% When is_psychopathy_reward_first == 0, then the orange image corresponds
% to the neutral images; blue corresponds to violent.
% For the violent images, the probability of reward is 0.3, 0.7, 0.3, 0.7
% in the four epochs.
% In the output file, data.choice == 1 means "orange", data.choice == 0  
% means "blue".
% What is orange or blue depends on the value of the parameter
% is_psychopathy_reward_first.
% In the output file, data.outcome indicates whether a positive feedback 
% (1) or not (0) has been assigned to each participant's choice.
%==========================================================================

% check for Opengl compatibility, abort otherwise
AssertOpenGL;

% neither macbook nor testing computer seem to interact properly with 
% display refresh rate synchronization tests, so set to 1 to skip tests 
% and avoid errors, these tests are more important for tasks where timing
% needs to be very precise
Screen('Preference', 'SkipSyncTests', 1);

% check if all needed parameters are given:
if nargin < 5
    error('Must provide required input parameters "sID", "img_pair", "is_psychopathy_reward_first", "subject_name", and "block_of_trials"!');
    Screen('CloseAll');
    ShowCursor;
    Priority(0);
    ListenChar(0);
end

% One way to get different random numbers is to initialize the generator 
% using a different seed every time. Doing so ensures that you don’t repeat 
% results from a previous session.
rng('shuffle');

% select the pair of images to be displayed and whether the NJRE stimulus
% is rewarded in the first sequence of trials or not.
selectImgPair;

% Debugging: if turned on, task will not be displayed full screen
debug = 0; 
% debug = input('debug mode? (1 = yes, 0 = no): ');

% A.    Getting started
%--------------------------------------------------------------------------
revlSetPaths; 

% run and load prep file
prep = revlParams(sID, true, blue_img, orange_img);

% Set stuff up (files, variables etc.), start PTB - Screen.
revlSetup;

% Present instructions. Subject presses key to continue.
revlInstr;
WaitSecs(1);
drawfix;

Screen('Flip', wd);
if ~debug
    WaitSecs(2);
end


% A. Loop over all trials.
%--------------------------------------------------------------------------
aborted = false;
for t = 1:nt
    % Start of t: draw the stimuli according to t. This draws a
    % fixation cross with a stimulus on both sides:
    wd = revlDrawStim(wd, prep, 0, [], t, img);
    tm.stim(t) = Screen(wd, 'Flip');
    
    % Choice: wait until one has been selected or trial aborted
    nobreak = 0;
    while nobreak == 0
        [secs, keyCode, dSecs] = KbWait;
        a = find(keyCode);
        if length(a)==1;
            if(a == prep.left || a == prep.right || a == prep.abort)
                tm.choice(t)  = GetSecs;
                nobreak = 1;
                switch a
                    case prep.left
                        % find the location of stim 1. If it is on the
                        % left, you picked stim 1, otherwise you picked
                        % stim 2 
                        data.choice(t) = find(prep.locs(t,:) == 1);
                    case prep.right
                        data.choice(t) = find(prep.locs(t,:) == 2);
                end
            end
        end
    end
    
    if a == prep.abort
        abd = 'You have aborted the game';
        [wt] = Screen('TextBounds', wd, abd);
        xpos = round(wdw / 2 - wt(3) / 2);
        ypos = round(wdh / 2 - wt(4) / 2);
        Screen('Drawtext', wd, abd, xpos, ypos, prep.draw.white);
        Screen('flip', wd,[]);
        WaitSecs(1);
        % break out of trial-loop.
        break
    end
    
    % check if valid response (within boxes).
    % -----------------------------------------------------------------
    % determine feedback.
    data.outcome(t) = prep.feedback(t, data.choice(t));
    
    % present choice.
    wd = revlDrawStim(wd, prep, 1, data, t, img);
    Screen(wd, 'Flip');
    
    % Prepare the outcome.
    wd = revlDrawStim(wd, prep, 2, data, t, img);
    
    % Wait for cue-outcome interval time, then present the outcome.
    WaitSecs('UntilTime', tm.choice(t) + prep.time.coi);
    tm.outcome(t) = Screen(wd, 'Flip');
    
    % Make screen to black before switching to the next t. Record when
    % the screen flips to black. Note that the outcome is always onscreen
    % for the duration prep.time.iti, so that it's not shown longer for
    % the juice ts.
    drawfix;
    WaitSecs('UntilTime',tm.outcome(t) + prep.time.iti - prep.time.black);
    Screen(wd, 'Flip');

    % wait for start of new trial.
    WaitSecs('UntilTime', tm.outcome(t) + prep.time.iti);
    
end % end of trial loop.
data.RT = tm.choice - tm.stim;
data.totalReward = nansum(data.outcome);


% D   Save and wrap things up.
%--------------------------------------------------------------------------
Screen('FillRect', wd, prep.draw.black);
Screen(wd, 'Flip');
HideCursor;
WaitSecs(1);
data.today = today;
data.tm = tm;
data.prep = prep;
data.img_pair = img_pair;
data.is_psychopathy_reward_first = is_psychopathy_reward_first;
data.subject_name = subject_name;
data.block_of_trials = block_of_trials;

% save data. If dataFile already exists, create unique dataFile
if exist(dataFile, 'file') % subject exists already
    randAttach = round(rand * 10000);
    dataFile = sprintf('%s_%04.0f.mat', dataFile(1:end - 4), randAttach);
end
save(dataFile,'data');

% give feedback 
text =  sprintf('Congratulations, you won %d Euro!', data.totalReward);
[wt] = Screen('TextBounds',wd,text);
xpos = round(wdw / 2 - wt(3) / 2);
ypos = round(wdh / 2 - wt(4) / 2);
Screen('Drawtext', wd, text, xpos, ypos, prep.draw.white);
Screen('flip', wd,[]);
WaitSecs(2)

% Thank subjects
text =  'Thank you for participating';
[wt] = Screen('TextBounds', wd, text);
xpos = round(wdw / 2 - wt(3) / 2);
ypos = round(wdh / 2 - wt(4) / 2);
Screen('Drawtext', wd, text, xpos, ypos, prep.draw.white);
Screen('flip', wd,[]);

WaitSecs(1);
Screen('CloseAll');
clear Screen

% plot data %%% uncomment following line to show plot of data!
% revlPlotData(sID, dataPath);
end

