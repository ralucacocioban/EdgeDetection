function [img, direction] = GaussianFilteringDerivative(img)

kernel_x = fspecial('gaussian', [3 3], 0.5);

[kx,ky] = gradient(kernel_x);

[rows cols] = size(img);

direction = zeros(rows,cols);

for i=1:rows-2
    for j =1:cols-2
        
        subMatrix = img(i:i+2, j:j+2);
        subMatrix = double(subMatrix);
        
        Gx = sum(sum(kx.*subMatrix));
        Gy = sum(sum(ky.*subMatrix));

        % calculate the direction
        direction(i,j) = atan2(Gy,Gx)*180;
        % calculate the magnitude
        img(i,j)=sqrt(Gx^2+Gy^2);  
    end
end

%figure,imshow(img); title('Gaussian derivative gradient');

end