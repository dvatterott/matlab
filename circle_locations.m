function [ a ] = circle_locations( n, cx, cy, Radius, start_jitter)
%circle locations. gives evenly spaced locations around an imaginary circle
% Output is ready for images to be placed in circle
%   n = # of locations around the circle
%   cx and cy are the center points of the circle
%   imgsize is the size of the images to be placed around the circle
%   Radius is the size of the circle

dAngle = 2*pi/n; % change in angle per circle
angles = (0:n-1) * dAngle + (degtorad(start_jitter));
[xPos, yPos] = pol2cart(angles, Radius); % convert
%back to Cartesian
% translate to new center
xPos = xPos + cx;
yPos = yPos + cy;
xPos = xPos';
yPos = yPos';
a = [xPos, yPos];
end
