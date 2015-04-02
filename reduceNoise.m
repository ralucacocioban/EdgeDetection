function img = reduceNoise(img)

% Create the gaussian filter
G = fspecial('gaussian',[5 5],2);
% Filter the image (blur it before performing edge detection)
img = imfilter(img,G,'same');

end