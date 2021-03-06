% PS-RANSAC
% -------------------------------------------------------------------------
% Segmentation of the external iris boundary in non-ideal ocular images
% R. Donida Labati, E. Mu�oz, V. Piuri, A. Ross, F. Scotti, "Non-ideal iris segmentation using Polar Spline RANSAC and illumination compensation", in Computer Vision and Image Understanding, Elsevier, 2019 [DOI: 10.1016/j.cviu.2019.07.007]
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% DEMO
% -------------------------------------------------------------------------

close all
clear
clc

% Input data
%--------------------------------------------------------------------------
% Ocular image to be segmented
imgName = 'example.bmp';
%--------------------------------------------------------------------------

% Algorithm parameters
%--------------------------------------------------------------------------
percInliers = 0.9; %(0.5 to 1)
nPoints = 6;
plot_debug = false;
%--------------------------------------------------------------------------

% Manual segmentation of the pupil-iris boundary
%-------------------------------------------------------------------------
img = imread(imgName);
figure,
imshow(img);
title('Select 4 points of the INTERNAL boundary')

XP = [];
YP = [];
for nPoint = 1 : 4
    [x,y] = ginput(1);
    XP = [XP, x];
    YP = [YP, y];
end

[xcP,ycP,rP,a] = circfit(XP, YP);

close all
%-------------------------------------------------------------------------



% Plot the input data
figure
imshow(img)
hold on
plotCircle(xcP, ycP, rP, 360, 'r', 3)
title('INPUT: ocular image and pupil parameters')

% Binary mask of the pupil region
[xI, yI] = meshgrid(1:size(img,2), 1:size(img,1));
distancesFromCenter = sqrt( (xI - xcP).^2 + (yI - ycP).^2 );
pupilMask = distancesFromCenter <= rP;


% External boundary segmentation
[maskI, irisBoundarySpline] = PS_RANSAC(img, pupilMask, xcP, ycP, rP, percInliers, nPoints, plot_debug);

%Plot the results
figure
subplot(1,2,1)
hold on
B = bwboundaries(pupilMask);
BP = B{1};
imshow(img, []);  title('Iris Boundary', 'Interpreter', 'none')
hold on
if size(irisBoundarySpline,1) * size(irisBoundarySpline,2) > 0
    plot(irisBoundarySpline(2,:), irisBoundarySpline(1,:), '.r');
end
axis equal
title('OUTPUT: external iris boundaries')
subplot(1,2,2)
imshow(maskI)
axis equal
title('OUTPUT: segmentation mask')


