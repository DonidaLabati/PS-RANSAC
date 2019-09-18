% PS-RANSAC
% -------------------------------------------------------------------------
% Segmentation of the external iris boundary in non-ideal ocular images
% R. Donida Labati, E. Muñoz, V. Piuri, A. Ross, F. Scotti, "Non-ideal iris segmentation using Polar Spline RANSAC and illumination compensation", in Computer Vision and Image Understanding, Elsevier, 2019 [DOI: 10.1016/j.cviu.2019.07.007]
% -------------------------------------------------------------------------


function [E T_noise_squared d] = error_ClosedSpline(Theta, X, sigma, P_inlier)

E = [];
if ~isempty(Theta) && ~isempty(X)
    
    vetToCompute = ppval(Theta, 0:359);
    
 E = abs(vetToCompute - X);
                
end;
d = 5;
% compute the error threshold
if (nargout > 1)
    
    if (P_inlier == 0)
        T_noise = sigma;
    else
        
        % compute the inverse probability
        T_noise_squared = sigma^2 * chi2inv_LUT(P_inlier, d);

    end;
    
end;

return;