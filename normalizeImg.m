% Min max normalization
function img = normalizeImg (I)
I = double(I);
vMin = min(I(:));
I = I - vMin;
vMax = max(I(:));
img = I / vMax;
