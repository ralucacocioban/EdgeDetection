function PRcurve(img, groundTruthImg)

[x,y] = getPrecissionAndRecall(groundTruthImg, img);
computePRcurve(x,y);

end

function [xCoord, yCoord] = getPrecissionAndRecall(groundTruth, img)

%distance vector
D = (1:10);

%declare/initialise the TP, TN, FP and FN
fp = zeros(numel(D));
tp = zeros(numel(D));
fn =zeros(numel(D));
tn =zeros(numel(D));
 
xCoord = zeros(numel(D));
yCoord = zeros(numel(D));

%go through all the treshold values and computer the binary clasifier
for i =1:numel(D)
    
    
    [fp(i), tp(i), fn(i), tn(i)] = computeClasificationError(groundTruth, img, D(i));
    
    %x coords:
    xCoord(i) = double(tp(i)/(tp(i)+fn(i)));
    
    %y coord:
    yCoord(i) = double(tp(i)/(tp(i)+fp(i)));
    
end

end


function [fp,tp,fn,tn] = computeClasificationError(groundTruthImg, binImg, dist)

tp=0;
fp=0;
tn=0;
fn=0;

[h, w] = size(groundTruthImg);

for i=1+dist:h-dist
    for j=1+dist:w-dist
        
        foundOne = checkPixelInDistance(binImg, dist, 1, i, j);
        foundZero = checkPixelInDistance(binImg, dist, 0, i, j);
        
        if(groundTruthImg(i,j) == 1 && foundOne == false)
            fp= fp+1;
        elseif (groundTruthImg(i,j) == 1 && foundOne == true)
            tp = tp+1;
        elseif  (groundTruthImg(i,j) == 0 && foundZero == false)
            fn = fn + 1;
        else tn= tn+1;
        end
    end
end

end


function found = checkPixelInDistance(groundTruthImg, dist, pixelValue, i, j)

found = false;

for row = i-dist:i+dist
   for col = j-dist:j+dist
    if(groundTruthImg(row,col) == pixelValue)
        found = true;
    end
   end
end

end

function computePRcurve(xCoord, yCoord)

%plot the PR curve
figure, plot(xCoord,yCoord,'b'); title('PR curve'), xlabel('Recall'), ylabel('Precision');

end