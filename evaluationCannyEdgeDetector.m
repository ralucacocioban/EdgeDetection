function evaluationCannyEdgeDetector(butterfly, groundTruthImg)

[x,y] = thresholdingAlgorithmBin(groundTruthImg, butterfly);
computeROCcurve(x,y);

end


function [xCoord, yCoord] = thresholdingAlgorithmBin(groundTruth, grayImg)

%treshhold vector
T = (0:256)/256;
T(257) = T(257) - 0.001;

%declare/initialise the TP, TN, FP and FN
fp = zeros(numel(T));
tp = zeros(numel(T));
fn =zeros(numel(T));
tn =zeros(numel(T));
 
xCoord = zeros(numel(T));
yCoord = zeros(numel(T));

%go through all the treshold values and computer the binary clasifier
for i =1:numel(T)
    
    binImg = edge(grayImg,'canny',T(i));
    [fp(i), tp(i), fn(i), tn(i)] = computeClasificationError(groundTruth, binImg);
    
    %x coords:
    xCoord(i) = double(fp(i)/(fp(i)+tn(i)));
    %y coord:
    yCoord(i) = double(tp(i)/(tp(i)+fn(i)));
    
end

end


function [fp,tp,fn,tn] = computeClasificationError(groundTruthImg, binImg)

tp=0;
fp=0;
tn=0;
fn=0;

[h, w] = size(groundTruthImg);

for i=1:h
    for j=1:w
        if(binImg(i,j) == 1 && groundTruthImg(i,j) == 0)
            fp= fp+1;
        elseif (binImg(i,j) == 1 && groundTruthImg(i,j) == 1)
            tp = tp+1;
        elseif  (binImg(i,j) == 0 && groundTruthImg(i,j) == 0)
            tn = tn + 1;
        else fn= fn+1;
        end
    end
end

end


function computeROCcurve(xCoord, yCoord)

%plot the ROC curve
figure, plot(xCoord,yCoord,'r'); title('ROC curve');

end