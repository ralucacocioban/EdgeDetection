function img = sobelDetector(img)

%sobel kernels

kx = fspecial('sobel')';
ky = fspecial('sobel');

[rows cols] = size(img);

for i=1:rows-2
    for j =1:cols-2
        
        % subtract a windows of 3x3 from the image
        subMatrix = img(i:i+2, j:j+2);
        subMatrix = double(subMatrix);
        
        % apply the kernels
        Gx = sum(sum(kx.*subMatrix));
        Gy = sum(sum(ky.*subMatrix));

        % compute the gradient magnitude   
        img(i,j)=sqrt(Gx^2+Gy^2);
        
    end
end

%figure,imshow(img); title('Sobel gradient');

end
