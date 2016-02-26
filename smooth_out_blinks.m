function [out] = smooth_out_blinks(pupil_area)
%inputs pupil area with blinks. This will output the pupil area, but with a splines interpretation of what the pupil area would be without blinks. 
%This function uses the method described by Sebastiaan Mathôt at the following link
%https://figshare.com/articles/A_simple_way_to_reconstruct_pupil_size_during_eye_blinks/688001


x_all = 1:length(pupil_area);%create vector of x values 
velocity_profile = abs(diff(pupil_area)); %slope between pairs of points = diff

%check to make sure 10 is greater than general noise level/signals of interest
find_saccade = find(velocity_profile>10); %find where velocity is greater than 10. 10 is an arbitrary. It should be greater than noise.

find_saccade = [0 find_saccade']; %add a 0 so that we find the first time
find_saccade_times = find(diff(find_saccade)>10); %find velocitys greater than 10 that are more than 10 samples apart (different blinks) might want to play around with 10

saccade_times = find_saccade(find_saccade_times+1);

if mod(length(saccade_times),2) ~= 0 %IF THIS IS NOT AN EVEN NUMBER. THERES A MISTAKE
    disp('ERROR')
end

new_pupil_area = pupil_area;
jump_ahead = 110; %this is a paremter adjusting how long after blink we replace data. Louise's blinks had a funny profile following the blink that lasted ~100 ms. 

for i = 1 : 2 : length(saccade_times)-1
    try
        test_y = pupil_area(saccade_times(i)-110:saccade_times(i)-10); %take 100 ms before blink (3480~10ms before blink)
        x = x_all(saccade_times(i)-110:saccade_times(i)-10); %vector x through length of test y
        test_y = [test_y' pupil_area(saccade_times(i+1)+jump_ahead:saccade_times(i+1)+jump_ahead+100)']; %take 100 ms after the blink (notice we are exlcuding time during the blink!)
        x = [x x_all(saccade_times(i+1)+jump_ahead:saccade_times(i+1)+jump_ahead+100)]; %add on to x starting at 200 (because the blink is 100 ms and the last value of x is 
    catch
        if saccade_times(i+1)+jump_ahead+100 > length(pupil_area) %end of trial
            test_y = [test_y' pupil_area(saccade_times(i+1)+jump_ahead:end)'];
            x = [x x_all(saccade_times(i+1)+jump_ahead:end)];
        elseif saccade_times(i)-110 < 1 % beginning of trial
            test_y = pupil_area(1:saccade_times(i)-10); 
            x = x_all(1:saccade_times(i)-10); %vector x through length of test y
            test_y = [test_y' pupil_area(saccade_times(i+1)+jump_ahead:saccade_times(i+1)+jump_ahead+100)']; %take 100 ms after the blink (notice we are exlcuding time during the blink!)
            x = [x x_all(saccade_times(i+1)+jump_ahead:saccade_times(i+1)+jump_ahead+100)]; 
        end
    end
    yy = spline(x,test_y,saccade_times(i)-10:saccade_times(i+1)+jump_ahead); %splines will draw in the data missed by the blink
    %figure;
    %plot(x,test_y,'o')
    %hold on 
    %plot(saccade_times(i)-10:saccade_times(i+1)+10,yy)
    new_pupil_area(saccade_times(i)-10:saccade_times(i+1)+jump_ahead) = yy;
    
end

%figure;
%plot(new_pupil_area) %plot our splines
out = new_pupil_area