% PS-RANSAC
% -------------------------------------------------------------------------
% Segmentation of the external iris boundary in non-ideal ocular images
% R. Donida Labati, E. Muñoz, V. Piuri, A. Ross, F. Scotti, "Non-ideal iris segmentation using Polar Spline RANSAC and illumination compensation", in Computer Vision and Image Understanding, Elsevier, 2019 [DOI: 10.1016/j.cviu.2019.07.007]
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% This function casts the boundary points from Polar to Cartesian
% coordinates
% INPUTS:
%  - polarBoundary = coordinates of the edges of the iris boundary 
%  - cX = x coordinate of the center of the Polar space
%  - cY = y coordinate of the center of the Polar space
%  - linImg = linearized (Polar) image
% OUTPUTS:
% - boundaryCart = Cartesian coordinates of the boundary
% - boundaryCartAngles = Polar coordinate theta of every point casted in
%  Cartesian coordinates
% -------------------------------------------------------------------------


function [boundaryCart, boundaryCartAngles ] = unwrapCircle(polarBoundary, cX, cY, linImg)

[dimY, dimX] = size(linImg);


vetRadii = polarBoundary ;

angularStep = 2 * pi / dimX;

vetAngles = 0: dimX-1;

vetAngles =  vetAngles * angularStep ;

vetAngles = vetAngles - pi;

[indicesOk] = find(polarBoundary > 0);

angles = vetAngles(indicesOk);
radii = vetRadii(indicesOk);

boundaryCart(2,:) = radii .* cos(angles) + cX;
boundaryCart(1,:) = radii .* sin(angles)+ cY;
boundaryCartAngles = indicesOk;
