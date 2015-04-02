function B = thresholdImg(threshold, img)

thresh=threshold;
B = zeros(size(img));
[rows, cols] = size(img);

for i=1:rows
    for j=1:cols
        B(i,j) = (img(i,j) >= thresh);
    end
end

end