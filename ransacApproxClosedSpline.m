% PS-RANSAC
% -------------------------------------------------------------------------
% Segmentation of the external iris boundary in non-ideal ocular images
% R. Donida Labati, E. Muñoz, V. Piuri, A. Ross, F. Scotti, "Non-ideal iris segmentation using Polar Spline RANSAC and illumination compensation", in Computer Vision and Image Understanding, Elsevier, 2019 [DOI: 10.1016/j.cviu.2019.07.007]
% -------------------------------------------------------------------------

% -------------------------------------------------------------------------
% This function refines the iris boundaries
% INPUTS:
%  - XIn = coordinates of the edges of the iris boundary
%  - inliers = % of inliers considered for RANSAC computation
%  - nPoints = # of points considered for RANSAC computation
% OUTPUTS:
% - splineOut = refined iris boundary in Polar coordinates
% -------------------------------------------------------------------------

function splineOut = ransacApproxClosedSpline(XIn, inliers, nPoints)

addpath([cd,'\ClosedSpline'])
addpath([cd,'\RANSAC-Toolbox-master\Common\']);
addpath([cd,'\RANSAC-Toolbox-master']);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% noise
sigma = 0.3;

% set RANSAC options
% options.epsilon = 1e-6;
% options.P_inlier = 0.99;

strFunction = sprintf('@estimate_ClosedSpline_%i', nPoints);

options.epsilon = 1e-6;
options.P_inlier = inliers; %WVU
% options.P_inlier = 0.8;
options.sigma = sigma;
options.est_fun = eval(strFunction);
options.man_fun = @error_ClosedSpline;
options.mode = 'MSAC';
options.Ps = [];
options.notify_iter = [];
options.min_iters = 100;
options.max_iters = 50000;
options.fix_seed = false;
options.reestimate = false;
options.stabilize = false;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RANSAC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% form the input data pairs
X = XIn;
% run RANSAC
[results, options] = RANSAC(X, options);

% xC = results.Theta(1);
% yC = results.Theta(2);
splineOut = results.Theta;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%