function [ done ] = Wait_relTime( startTime, wait )
%Wait_relTrial Wait for a certain amount of time since a particular event
%   Wait an amount of time relative to a previous event

if (GetSecs-startTime) > wait
    disp('TIMING ERROR TOOK TOO LONG:: Wait_relTime')
end

while (GetSecs-startTime) < wait
    WaitSecs(0.0001);
    if (GetSecs-startTime) >= wait
        done=1;
        break;
    end
end

