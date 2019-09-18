% This function plots a circle using nPoints
% INPUT
% x = x coordinate of the center
% y = y coordinate of the center
% nPoints = number of points to be plotted
% lineColor = plot color
% lineSize = width of the plotted line


function H=plotCircle(x, y, r, nPoints, lineColor, lineSize)

THETA=linspace(0,2*pi,nPoints);
RHO=ones(1,nPoints)*r;
[vX,vY] = pol2cart(THETA,RHO);
vX=vX+x;
vY=vY+y;
H=plot(vX,vY,lineColor, 'LineWidth', lineSize);
axis equal;