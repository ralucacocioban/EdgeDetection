function img = prewittDetector(img)

kx = [-1 0 1; -1 0 1; -1 0 1];
ky = [-1 -1 -1; 0 0 0;1 1 1];

[rows cols] = size(img);

for i=1:rows-2
    for j =1:cols-2
        
        subMatrix = img(i:i+2, j:j+2);
        subMatrix = double(subMatrix);
        
        Gx = sum(sum(kx.*subMatrix));
        Gy = sum(sum(ky.*subMatrix));

        img(i,j)=sqrt(Gx^2+Gy^2);
        
    end
end

%figure,imshow(img); title('Prewitt gradient');

end