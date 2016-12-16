function [sound] = create_FenceStim(sound,Fs,breaks,varargin)
%breaks should be in ms

fence_length = 200; %200 ms of silence

for i = 1:length(varargin)
   if ischar(varargin{i})
   switch lower(varargin{i})
       case 'length'
           fence_length = varargin{i+1};
   end
   end
end


new_sound = sound;
i = 1;
while i <= length(sound)
    i = i + (breaks/1000)*Fs;
   
    new_sound(i:i+(fence_length/1000)*Fs) = 0;
    
    i = i + (fence_length/1000)*Fs;
end

sound = new_sound(1:length(sound));