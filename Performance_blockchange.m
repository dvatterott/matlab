function NewBlock = Performance_blockchange(TrialRecord)
%This function is a function for the MonkeyLogic Matlab library. 
% This function changes the block if performance is better than
% DesiredPerform % accuracy over the last lookBack trials. 
% This function relies on the TrialRecord structure...which seems a little
% buggy, so this script required some work arounds.

NewBlock                = 0; % default = continue current block
t                       = TrialRecord.CurrentTrialWithinBlock; % t is the trial number
e                       = TrialRecord.TrialErrors; % error record
lookBack                = 10; %minimum block length and how far back we look when evaluating performance
DesiredPerform          = 0.5; %criterion performance to change the block
b                       = TrialRecord.BlocksPlayed; %current block
B                       = TrialRecord.BlocksSelected; % the vector of blocks available to be played, as selected in the Main Menu

if t >= lookBack
    % TrialRecord.CurrentTrialWithinBlock does not work in this context, so
    % here's my own way of tracking the Current Trial within a block...
    timestamp               = find(diff([-1 b -1]) ~= 0);
    runlength               = diff(timestamp);
    
    if runlength(end) >= lookBack;
        if  sum(~e(end-lookBack+1:end))/lookBack < DesiredPerform % ~e=correct trials,so this is %correct in previous X # of trials. 
            return % %correct is less than desired performance so continue current block
        elseif  sum(~e(end-lookBack+1:end))/lookBack >= DesiredPerform % a non-zero sum means the last numcorrect trials were not all zero
            PossibleBlocks = B(B~=b(end)); % %correct is greater than minimum, so change to a different block
            NewBlock       = PossibleBlocks(randi(length(PossibleBlocks)));
        end   
    end
end
