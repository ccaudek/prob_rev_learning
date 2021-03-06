%==========================================================================
% revlInstr
% Script to display the instructions for the Reversal Learning Task
%
% Hanneke den Ouden 
% Donders Institute for Brain, Cognition and Behaviour
% h.denouden@gmail.com
% 
% version 11-08-2015
%==========================================================================


% Set a bunch of parameters for the instruction screen
spacing = 2; % distance between lines, in multiples of textsize
top     = prep.top; % location of the top of the text
wacht   = 1.5; %time in secs to wait before showing the next set of instructions

% SCREEN
% -------------------------------------------------------------------------
txt{1}    = {'WELCOME TO THE PROBABILISTIC REVERSAL LEARNING EXPERIMENT!',' ',...
    'On each trial, you will see two images,',...
    'one on each side of the screen.',...
    'You choose which one to select by pressing left (v) or right (m).',...
    ' ',...
    ' ',...
    ' '};
txt{2}    = { ' ',' ',...
    'The two images differ in how often they provide a reward.',...
    'You should choose the image that provides rewards most often.',...
    'The best player will win a prize!'};
txt{3} = {'  ',' ',...
    'The probability to provide a reward of both images can change.',...
    'So you have to keep track of which image is paying out more,',...
    'and pick that one.'};
txt{4}= {'  ',' ',...
    'It is important to realize that the feedback you get',...
    'ONLY depends on the type of the image.',...
    'So it does not depend on the location,',...
    'nor on your previous choices.',' '};
txt{5} = {'Reminder: the response keys are ''v'' and ''m''.',...
    ' ','Good luck!',...
    ' ','Press any key to start the game.',...
    };

% display the texts
for i  = 1:numel(txt)-1
    disptxt(txt{i},wd,wdw,wdh,1,0,white,0,1);
    WaitSecs(2);
    pressbutton;
end

disptxt(txt{end},wd,wdw,wdh,0,0,white,0,1);
WaitSecs(0.2);
KbWait;
blackscreen;
WaitSecs(1);



