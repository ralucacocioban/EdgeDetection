function nonMaximalSuppression(dir, magnitude)

discreteDirections = [0, 45, 90, 135, 180];
[rows cols] = size(magnitude);

dir = dir + 2*360;
dir = rem(dir,180);

interpolatedDir = interp1(discreteDirections, discreteDirections, dir, 'nearest','extrap');
interpolatedMatrix = reshape(interpolatedDir, cols, rows)';

for i=2:rows-2
    for j =2:cols-2
        
        switch interpolatedMatrix(i,j)
            case 0
                    if(magnitude(i,j) < magnitude(i+1,j) || magnitude(i,j) < magnitude(i-1, j))
                        magnitude(i,j) = 0;
                    end
            case 45 
                    if(magnitude(i,j) < magnitude(i+1,j+1) || magnitude(i,j) < magnitude(i-1, j-1))
                        magnitude(i,j) = 0;
                     end
            case 90
                     if(magnitude(i,j) < magnitude(i,j-1) || magnitude(i,j) < magnitude(i, j+1))
                        magnitude(i,j) = 0;
                     end
            case 135 
                    if(magnitude(i,j) < magnitude(i+1,j+1) || magnitude(i,j) < magnitude(i-1, j-1))
                        magnitude(i,j) = 0;
                     end
            case 180
                    if(magnitude(i,j) < magnitude(i+1,j) || magnitude(i,j) < magnitude(i-1, j))
                        magnitude(i,j) = 0;
                     end
        end
        
    end
end

%figure, imshow(magnitude), title('After performing non maxima suppresion');
plotPhaseAndMagnitude(magnitude);

end



function plotPhaseAndMagnitude(suppressedImg)

% threshold varies in this case
% it plots the magnitude and phase by using fft2 
% for each image obtained by thresholding with the varying values

for thresh=10:2:16
    
    thresholdedImg = thresholdImg(thresh, suppressedImg);
    %{
    figure, imshow(thresholdedImg),
    titleImg = sprintf('Thresholded img with threshold = %d',thresh);
    title(titleImg);
    %}
    doubleImg = double(thresholdedImg);
    
    F = fft2(doubleImg); 
    F = fftshift(F); % Center FFT
    
    figure;

    subplot(2,1,1), imagesc(log(1+abs(F))); colormap(gray); 
    titleMag = sprintf('Magnitude for threshold = %d',thresh);
    title(titleMag);

    subplot(2,1,2), imagesc(angle(F));  colormap(gray); 
    titlePhase = sprintf('Phase for threshold = %d',thresh);
    title(titlePhase);

end

end