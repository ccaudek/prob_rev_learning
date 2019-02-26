% Select the pair of images to be displayed and determine in which epochs 
% the psychopathy image is rewarded most.
% If is_psychopathy_reward_first == 1,
%
% Corrado Caudek 
% corrado.caudek@unifi.it
% 
% version 31-10-2017
%==========================================================================

% the parameter img_pair is used to select which pair of images is 
% displayed in each block.

% the image that is probabilistically rewarded most is always the orange 
% image.
% Which of the two stimulis (violent or neutral) is 'orange' depends on the
% value of the parameter is_psychopathy_reward_first.
% In the 4 epochs the sequence is always: reward orange most (40 trials), 
% reward blue most (40 trials), reward orange most (40 trials), reward blue 
% most (40 trials).
% If is_psychopathy_reward_first == 0, then orange is the neutral image, so
% the psychopaty image is rewarded with prob .3, .7, .3, .7 in the 4 
% successive epochs.
% If is_psychopathy_reward_first == 1, then orange is the psychopathy 
% image, so the psychopaty image is rewarded with probability of  0.7, .3, 
% .7, 0.3 in the 4 successive epochs.
if (is_psychopathy_reward_first == 1) 
    if (img_pair     == 1)
        blue_img   = 'im_disinhibition_1.jpg'; % psychopathy image
        orange_img = 'im_neutral_1.jpg'; % neutral image
    elseif (img_pair == 2)
        blue_img   = 'im_disinhibition_2.jpg'; % psychopathy image
        orange_img = 'im_neutral_2.jpg'; % neutral image
    elseif (img_pair == 3)
        blue_img   = 'im_disinhibition_3.jpg'; % psychopathy image
        orange_img = 'im_neutral_3.jpg'; % neutral image    
    elseif (img_pair == 4)
        blue_img   = 'im_boldness_1.jpg'; % psychopathy image
        orange_img = 'im_neutral_4.jpg'; % neutral image   
    elseif (img_pair == 5)
        blue_img   = 'im_boldness_2.jpg'; % psychopathy image
        orange_img = 'im_neutral_5.jpg'; % neutral image   
    elseif (img_pair == 6)
        blue_img   = 'im_boldness_3.jpg'; % psychopathy image
        orange_img = 'im_neutral_6.jpg'; % neutral image   
    elseif (img_pair == 7)
        blue_img   = 'im_meanness_1.jpg'; % psychopathy image
        orange_img = 'im_neutral_7.jpg'; % neutral image   
    elseif (img_pair == 8)
        blue_img   = 'im_meanness_2.jpg'; % psychopathy image
        orange_img = 'im_neutral_8.jpg'; % neutral image   
    elseif (img_pair == 9)
        blue_img   = 'im_meanness_3.jpg'; % psychopathy image
        orange_img = 'im_neutral_9.jpg'; % neutral image    
    else
        message2 = sprintf('*** Input for img_pair must be a integer between 1 and 9 ***'); 
        msgbox(message2);
        return;
    end
    
elseif (is_psychopathy_reward_first == 0)
    if (img_pair     == 1)
        blue_img   = 'im_neutral_1.jpg'; % neutral image
        orange_img = 'im_disinhibition_1.jpg'; % psychopathy image
    elseif (img_pair == 2)
        blue_img   = 'im_neutral_2.jpg'; % neutral image
        orange_img = 'im_disinhibition_2.jpg'; % psychopathy image
    elseif (img_pair == 3)
        blue_img   = 'im_neutral_3.jpg'; % neutral image
        orange_img = 'im_disinhibition_3.jpg'; % psychopathy image  
    elseif (img_pair == 4)
        blue_img   = 'im_neutral_4.jpg'; % neutral image
        orange_img = 'im_boldness_1.jpg'; % psychopathy image  
    elseif (img_pair == 5)
        blue_img   = 'im_neutral_5.jpg'; % neutral image
        orange_img = 'im_boldness_2.jpg'; % psychopathy image  
    elseif (img_pair == 6)
        blue_img   = 'im_neutral_6.jpg'; % neutral image
        orange_img = 'im_boldness_3.jpg'; % psychopathy image 
    elseif (img_pair == 7)
        blue_img   = 'im_neutral_7.jpg'; % neutral image
        orange_img = 'im_meanness_1.jpg'; % psychopathy image
    elseif (img_pair == 8)
        blue_img   = 'im_neutral_8.jpg'; % neutral image
        orange_img = 'im_meanness_2.jpg'; % psychopathy image
    elseif (img_pair == 9)
        blue_img   = 'im_neutral_9.jpg'; % neutral image
        orange_img = 'im_meanness_3.jpg'; % psychopathy image  
    else
        message2 = sprintf('*** Input for img_pair must be a integer between 1 and 9 ***'); 
        msgbox(message2);
        return;
    end    
    
else
    message1 = sprintf('*** Input for is_psychopathy_reward_first must be either 0 (no) or 1 (yes) ***'); 
    msgbox(message1);
    return;
end


