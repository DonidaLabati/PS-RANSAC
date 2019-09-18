% PS-RANSAC
% -------------------------------------------------------------------------
% Segmentation of the external iris boundary in non-ideal ocular images
% R. Donida Labati, E. Muñoz, V. Piuri, A. Ross, F. Scotti, "Non-ideal iris segmentation using Polar Spline RANSAC and illumination compensation", in Computer Vision and Image Understanding, Elsevier, 2019 [DOI: 10.1016/j.cviu.2019.07.007]
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% This function estimates the points of the external boundary using
% PS-RANSAC
% Inputs:
% - img = image
% - pupilMask = pupil mask
% - xP = x coordinate of the pupil center
% - yP = y coordinate of the pupil center
% - rP = pupil radius
% - inliers = inliers considered by Polar-RANSAC (from 0.5 to 1)
% - nPoints = n. of points used by Polar-RANSAC 
% - plot_debug = debug mode
% Outputs:
% - maskI = segmentation mask
% - boundaryI = vector of the iris boundary coordinates (refined)
% -------------------------------------------------------------------------


function [maskI, irisBoundarySpline] = PS_RANSAC(img, pupilMask, xP, yP, pupilRadius, inliers, nPoints, plot_debug)

parFGaussI = 0;
margine = 0;

img = normalizeImg(img);

% Filtered Polar image  
[linIris, linMask] = computePolarImgFiltered(img, pupilMask, [xP, yP], min(pupilRadius/0.1, 170), 10, 20, false);

% Boundary  in Polar coordinates
[dummy, irisBoundaryPolar] = min(linIris);

% Boundary in Cartesian coordinate
[irisBoundary1, angles] = unwrapCircle(irisBoundaryPolar, xP, yP, linIris);

% Boundary refinement
pp = ransacApproxClosedSpline(irisBoundaryPolar, inliers, nPoints);
yy = ppval(pp, 0:359);

% Refined boundary in Cartesian coordinate
[irisBoundarySpline, anglesSpline] = unwrapCircle(yy, xP, yP, linIris);

% Debug
if plot_debug
     figure
     subplot(2,1,1)
     imshow(linIris,[]);
     hold on
     plot(irisBoundaryPolar, '.g')
     plot(yy, '.r')
     legend('Boundary points', 'Refined boundary');
     subplot(2,1,2)
     imshow(img)
     hold on
     plot(irisBoundary1(2,:), irisBoundary1(1,:), '.g')
     plot(irisBoundarySpline(2,:), irisBoundarySpline(1,:), '.r')
     legend('Boundary points', 'Refined boundary');
end
title('Boundary in Cartesian coordinate')


% Output computation
irisOut = zeros(size(img));
boundaryI = irisBoundarySpline;
irisOut = roipoly(irisOut, boundaryI(2,:), boundaryI(1,:));
maskI = irisOut - pupilMask;