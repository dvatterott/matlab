%get list of all folders in the folder full of folders of sound (note that
%	you will have to change the path
file_path = '/Users/jglab/Downloads/ESC-50-master/';
directory_struct = dir(file_path);
directory_folders = [directory_struct.isdir];
folderList = {directory_struct(directory_folders).name}';
folderList(1:2) = [];

%the type of sound you want
sound = 'Dog'; %note - this has to be capitalized. 

%find the files with the sound you want
find_sound_folder = regexp(folderList,['\w*' sound '\w*']);
sound_folder = folderList{~cellfun(@isempty,find_sound_folder)};
sound_folderList = dir([file_path sound_folder]);
sound_List = {sound_folderList.name}';
sound_List(1:2) = [];

rng(0,'twister'); %seed random number generator.
chosen_sound = sound_List{randi([1 length(sound_List)],1,1)}; %choose random sound


filename = [file_path sound_folder '/' chosen_sound];

[sound,Fs] = audioread(filename); %this operation takes a couple seconds, so you will want to alot time during the experiment
player = audioplayer(sound, Fs); %this is probably not the most precise timing way to play a sound (also takes a couple seconds)
play(player);

%create fence stim
new_sound = create_FenceStim(sound,Fs,200);
player = audioplayer(new_sound, Fs); 
play(player);

%create pink noise stim
pink_sound = pinknoise(Fs, ceil(length(sound)/Fs), 0);
pink_sound = pink_sound(1:length(sound));
pink_sound = sound+pink_sound';
player = audioplayer(pink_sound, Fs); 
play(player);

%create fence+pink noise stim
pink_sound = pinknoise(Fs, ceil(length(sound)/Fs), 0);
pink_sound = pink_sound(1:length(sound));
pink_sound = sound+pink_sound';
new_sound = create_FenceStim(pink_sound,Fs,200);
player = audioplayer(new_sound, Fs); 
play(player);