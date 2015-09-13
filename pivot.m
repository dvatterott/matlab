function [ answer ] = pivot( x,y )
%PIVOT gives summary statistics across unique values of x
%   Computes the mean, count, and sem of y values corresponding to unique
%   values of x. 

uni                         = unique(x);
answer.x                    = uni';

for i = 1 : length(uni)
    
   var                      = uni(i);
   answer.GroupCount(i,1)   = length(y(x==var))';
   answer.mean_y(i,1)       = mean(y(x==var));
   answer.sem(i,1)          = std(y(x==var))/sqrt(answer.GroupCount(i))';
   
end

end
