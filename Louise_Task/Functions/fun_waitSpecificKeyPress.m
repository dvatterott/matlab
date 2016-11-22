function [ Press ] = fun_waitSpecificKeyPress( Key )
%waitSpecificKeyPress Waits until a specific key is pressed
%   Waits for specific key press

FlushEvents('KeyDown');

Press = 0;
KeyCode = 1;

while Press == 0

 WaitSecs(0.01);
 
[secs, KeyCode, deltaSecs]=KbWait(-3);

if sum(KeyCode) > 1
    KeyCode = [];
end

KeyPress = KbName(KeyCode);

if strcmpi(Key, KeyPress) %vertical line Resp
    Press = 1;
    break;
end
end

