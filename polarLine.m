
% PS-RANSAC
% -------------------------------------------------------------------------
% Segmentation of the external iris boundary in non-ideal ocular images
% R. Donida Labati, E. Muñoz, V. Piuri, A. Ross, F. Scotti, "Non-ideal iris segmentation using Polar Spline RANSAC and illumination compensation", in Computer Vision and Image Understanding, Elsevier, 2019 [DOI: 10.1016/j.cviu.2019.07.007]
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% This function casts a set of points from Cartesian to Polar coordinates
% and computes a line in the Polar image space
% INPUTS:
%  - cartesianPoints = input points
%  - centerCoordinates = Cartesian coordinates of the center of the Polar
% representation
%  -  plot_debug = boolean
% OUTPUTS:
% - xPolar = vector of the x coordinate in Polar space (theta)
% - yPolar = vector of the y coordinate in Polar space (rho)
% -------------------------------------------------------------------------


function [xPolar, yPolar] = polarLine(cartesianPoints, centerCoordinates, plot_debug)


[THETA,RHO] = cart2pol(cartesianPoints(:,2)-centerCoordinates(1),cartesianPoints(:,1)-centerCoordinates(2));

xPolar = 0: 359;

xBounday = rad2deg(THETA)+180;

if plot_debug
    figure
    plot(xBounday,RHO,'.')
end

yPolar = ones(size(xPolar)) * NaN;
xBoundayRound = round(xBounday);

xFound = zeros(size(xPolar));

for i = xPolar
    vIndices = find(xBoundayRound == i);
    if size(vIndices,1) * size(vIndices,2) > 0
        yPolar(i+1) = max(RHO(vIndices));
        xFound(i+1) = 1;
    end
end
iFound = find(xFound > 0);
iMinT = iFound(1);
iMaxT = iFound(end);
yPolar(1) = yPolar(iMinT(1));
xFound(1) = 1;
yPolar(359) = yPolar(iMaxT(1));
xFound(359) = 1;
iFound = find(xFound > 0);

[xBounday, iSort] = sort(xPolar(iFound));
RHO = yPolar(iFound);
RHO = RHO(iSort);

[minTheta, iMinT] = min(xBounday);
[maxTheta, iMaxT] = max(xBounday);

maxTheta  = maxTheta - 360;
minTheta  = minTheta + 360;

THETA = [maxTheta, xBounday, minTheta ];
RHO = [RHO(iMaxT), RHO, RHO(iMinT)];

yPolar  = interp1(THETA, RHO, xPolar);






