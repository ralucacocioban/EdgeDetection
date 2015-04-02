function lowPassHighPass()

boxImg = imread('images/box.png');
img = imread('images/lighthouse.png');

[rows cols dim] = size(img);

%check if the image is grayscale
if(dim > 1)
    img = rgb2gray(img);
end

[boxRows boxCols dim2] = size(boxImg);

if(dim2>1)
   boxImg = rgb2gray(boxImg); 
end

% transform into binary image
boxImg = im2bw(boxImg, 0.2);

%low pass filtering
lowPassFiltering(boxImg, img);

% high pass filtering
highPassFiltering(1-boxImg, img);


end

function lowPassFiltering(lowPassFilter, img)

    [rows cols dim] = size(img);
    
    lowPassF = fft2(lowPassFilter,rows, cols);

    lowFFT = fftshift(lowPassF);

    % perform fourier transform for image
    doubleImg = double(img);

    F = fft2(doubleImg); 
    F = fftshift(F); % Center FFT

    % apply the filter function (low pass box)
    lowPassFiltering =  double(lowFFT) .* F;
    % get the inverse
    imgLowPassFiltered = abs(ifft2(double(lowPassFiltering)));
    imgLowPassFiltered = circshift(imgLowPassFiltered,[-1.*floor(length(lowPassFilter)/2) -1.*floor(length(lowPassFilter)/2)]);

    figure,
    imagesc(imgLowPassFiltered),
    colormap gray,
    title('Low pass filtered img');

end


function highPassFiltering(highPassFilter, img)

    [rows cols dim] = size(img);
    
    highPassF = fft2(highPassFilter,rows, cols);

    highFFT = fftshift(highPassF);

    % perform fourier transform for image
    doubleImg = double(img);

    F = fft2(doubleImg); 
    F = fftshift(F);

    % apply the filter function (low pass box)
    highPassFiltering =  double(highFFT) .* F;
    % get the inverse
    imgHighPassFiltered = abs(ifft2(double(highPassFiltering)));
    imgHighPassFiltered = circshift(imgHighPassFiltered,[-1.*floor(length(highPassFilter)/2) -1.*floor(length(highPassFilter)/2)]);

    figure,
    imagesc(imgHighPassFiltered),
    colormap gray,
    title('High pass filtered img');

end