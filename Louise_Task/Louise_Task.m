%seed the random number generator
rand('twister',sum(100*clock)) 

%notice that this will change for each user!!
cd ~/Documents/Louise_Task/
addpath('./Functions')

%set up screen paramters and position
Screen('Preference','SkipSyncTests', 1); %my computer will not pass sync tests
distFromScreen_inCm                         = 10;
[window, ~]                                 = Screen('OpenWindow', 0, [1 1 1], round([0 0 500 300]));  
%[window, ~]                                 = Screen('OpenWindow', 0, 0, [], 32, 2);
[midW, midH]                                = getScreenMidpoint(window); % get screen middle point in pixels
center                                      = [midW, midH];
windowRect                                  = Screen('Rect', window);
White                                       = WhiteIndex(window);
Black                                       = BlackIndex(window);

% fixation point
fpDiameter_inDegrees                        = 0.5; 
fpDiameter_inPixels                         = degrees2pixels(fpDiameter_inDegrees, distFromScreen_inCm);
fpColor                                     = White;

%present letters
Letters                                     = {'A','B','C','D'};
Letter_order                                = Shuffle(1:length(Letters));
Letters                                     = Letters(Letter_order);
LetterColor                                 = White;

for i = 1 : length(Letters)
    
    %draw fixation dot
    Screen('DrawDots',window,center,fpDiameter_inPixels,fpColor,[0,0],1);
    Screen('Flip',window);
    
    %wait 200 ms
    WaitSecs(0.2);
    
    %draw text
    DrawFormattedText(window,Letters{i},'center','center',LetterColor);
    Screen('Flip',window);
    
    %wait for response
    fun_waitSpecificKeyPress(Letters{i});
    
    %clear screen
    Screen(window, 'FillRect', Black);
    Screen('Flip',window);
    
    %ITI
    WaitSecs(0.5);
end

Screen('CloseAll');