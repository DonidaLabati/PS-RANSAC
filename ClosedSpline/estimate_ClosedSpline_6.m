function [Theta, k] = estimate_ClosedSpline_6(X, s)


k = 6;
Theta = [];
if (nargin == 0) || isempty(X)
    Theta = [];
    return;
end;

if (nargin == 2) && ~isempty(s)
         s1 = sort(s);
         s1 = unique(s1);
         radiiSpline = X(s1);
         anglesSplineMom = s1-1; 
         anglesSpline = [anglesSplineMom-360, anglesSplineMom, anglesSplineMom+360];
         radiiSpline = [radiiSpline, radiiSpline, radiiSpline];
         Theta = spline(anglesSpline, radiiSpline);

end;

return;