
% PS-RANSAC
% -------------------------------------------------------------------------
% Segmentation of the external iris boundary in non-ideal ocular images
% R. Donida Labati, E. Muñoz, V. Piuri, A. Ross, F. Scotti, "Non-ideal iris segmentation using Polar Spline RANSAC and illumination compensation", in Computer Vision and Image Understanding, Elsevier, 2019 [DOI: 10.1016/j.cviu.2019.07.007]
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% This function casts the ocular image in Polar coordinates and estimates
% the boundary points
% INPUTS:
% - img = image
% - pupilMask = pupil mask
% - centerCoord = coordinates of the pupil center [x, y]
% - rPolar = y size of the polar image
% - unesefulUp = margin in the top part of the Polar image
% - minDistanceFromPupil = margin in the bottom part of the Polar image
% - plot_debug = boolean
% OUTPUTS:
% - gradRad = filtered Polar image
% - mask = mask of the ROI in Polar coordinates
% -------------------------------------------------------------------------



function [gradRad, mask] = computePolarImgFiltered(img, pupilMask, centerCoord, rPolar, unesefulUp, minDistanceFromPupil, plot_debug)

rI = rPolar + unesefulUp;

img = normalizeImg(img);

B = bwboundaries(pupilMask);


% pupil boundary
pupilB = [];
maxPerimeter = 0;
for i = 1:length(B)
    if size(B{i},1) > maxPerimeter 
        maxPerimeter = size(B{i},1);
        pupilB = B{i};
    end
end

if plot_debug
    figure,
    imshow(img,[])
    hold on
    plot(pupilB(:,2), pupilB(:,1), 'r')
    plot(centerCoord(1), centerCoord(2),'xr')
    title('Pupil')
end

% Limit 1
[xPolari, yPupil] = polarLine(pupilB, centerCoord, plot_debug);

% Limit 2
minX = max(1, centerCoord(1)-rI);
distX = centerCoord(1)-rI -minX;
minY = max(1, centerCoord(2)-rI);
distY = centerCoord(2)-rI -minY;
maxX = min(size(img,2), centerCoord(1)+rI);
maxY = min(size(img,1), centerCoord(2)+rI);
centerCircle = [rI+distX, rI+distY];

% Polar image space
[X, Y] = meshgrid(minX:maxX, minY:maxY);

circleOfInterest = sqrt( (X-centerCoord(1)).^2  + (Y-centerCoord(2)).^2 ) <= rI;
indiciC = find(circleOfInterest > 0);

% Limits of the space
limitB = [];
B = bwboundaries(circleOfInterest);
maxPerimeter = 0;
for i = 1:length(B)
    if size(B{i},1) > maxPerimeter 
        maxPerimeter = size(B{i},1);
        limitB= B{i};
    end
end
if plot_debug
    figure,
    imshow(circleOfInterest,[])
    hold on
    plot(limitB(:,2), limitB(:,1), 'r')
    plot(centerCircle(1), centerCircle(2),'xr')
end

[xLimit, yLimit] = polarLine(limitB, centerCircle, plot_debug);
yLimit = yLimit - unesefulUp;


porzioneImg = img(minY:maxY, minX:maxX);


[THETA,RHO] = cart2pol(X-centerCoord(1), Y-centerCoord(2));
THETANew= rad2deg(THETA)+180;

indiciCol1 = find(THETANew < 2);
THETA1 = THETANew(indiciCol1)+360;
RHO1 = RHO(indiciCol1);
porzioneImg1 = porzioneImg(indiciCol1);
indiciCol2 = find(THETANew > 358);
THETA2 = THETANew(indiciCol2)-360;
RHO2 = RHO(indiciCol2);
porzioneImg2 = porzioneImg(indiciCol2);

ThetaP = [THETANew(indiciC); THETA1; THETA2];
RhoP = [RHO(indiciC); RHO1; RHO2];
porzioneImgP = [porzioneImg(indiciC); porzioneImg1; porzioneImg2];


F = TriScatteredInterp(ThetaP, RhoP, porzioneImgP );

[XStripe, YStripe] = meshgrid(0:361, 1:max(RHO(indiciC)));

imgPolar = F(XStripe, YStripe);
imgPolar = imgPolar(:,2:size(imgPolar,2)-1);

yPupilNew = minDistanceFromPupil + yPupil;

if plot_debug
    figure
    imshow(imgPolar,[])
    hold on
    plot(yPupil, 'r')
    plot(yLimit, 'r')
    plot(yPupilNew, 'g')
end

% Gradient-based filter
h = ones(4, 20);
h(3:4,:) = -1;
gY = imfilter(imgPolar,h,'replicate');

if plot_debug
    figure
    imshow(gY,[])
    hold on
    plot(yPupil, 'r')
    plot(yLimit, 'r')
    plot(yPupilNew, 'g')
end

% Apply limits
mask1 = zeros(size(gY));
mask2 = zeros(size(gY));
for i = 1 : size(gY,2)
    mask1(:,i) = YStripe(:,i+1) >= yPupilNew(i);
    mask2(:,i) = YStripe(:,i+1) <= yLimit(i);
end
mask = mask1 & mask2;


gradRad = mask .* gY;



if plot_debug
    figure
    imshow(gradRad,[]);
end


