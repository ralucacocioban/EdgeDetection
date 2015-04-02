function coursework3()

%-------------------------------------------------------------------------------------%
%                         load the images needed for this csw
%                      and convert them to grayscale images if necessary
%-------------------------------------------------------------------------------------%

lighthouse = imread('images/lighthouse.png');
butterfly = imread('images/monarch_bw.png');
groundTruthImg = imread('images/groundTruthImg.jpg');

lighthouse = convertToGray(lighthouse);
butterfly = convertToGray(butterfly);
groundTruthImg = convertToGray(groundTruthImg);


%-------------------------------------------------------------------------------------%
%  detect edged for the lighthouse image by using the simple edge detector procedure
%                   1) reduce the noise of the image
%                   2) filter the image by using different algorithms
%                   3) threshold the result 
%-------------------------------------------------------------------------------------%

lighthouse = reduceNoise(lighthouse);


%-------------------------------------------------------------------------------------%
%                           perform SOBEL edge detection 
%-------------------------------------------------------------------------------------%
result1 = sobelDetector(lighthouse);
% threasholding the image
thresh=60;
B = thresholdImg(thresh, result1);
figure,imshow(B);title('Edge detected Image with Sobel detector');



%-------------------------------------------------------------------------------------%
%                           perform PREWITT edge detection 
%-------------------------------------------------------------------------------------%
result2 = prewittDetector(lighthouse);
% threasholding the image
thresh=55;
B = thresholdImg(thresh, result2);
figure,imshow(B);title('Edge detected Image with Prewitt detector');



%-------------------------------------------------------------------------------------%
%           perform edge detection by using derivative of Gaussian filtering 
%-------------------------------------------------------------------------------------%
[result3, direction] = GaussianFilteringDerivative(lighthouse);

% threasholding the image
B = thresholdImg(10, result3);
figure,imshow(B);title('Edge detected Image with gaussian derivative used as kernels');

%-------------------------------------------------------------------------------------%
%           perform the non maximal suppression algorithm for the image
%-------------------------------------------------------------------------------------%

%figure, imshow(result3), title('before nonmaxima suppression');
nonMaximalSuppression(direction,result3);



%-------------------------------------------------------------------------------------%
%                           perform CANNY edge detection 
%-------------------------------------------------------------------------------------%
result4 = CannyEdgeDetector(lighthouse);
figure, imshow(result4), title('Edge detected Image with Canny edge detector');


%-------------------------------------------------------------------------------------%
%                     apply low pass and high pass filters on the image 
%-------------------------------------------------------------------------------------%

lowPassHighPass();

%-------------------------------------------------------------------------------------%
%  additional point b) evaluate the performance of the edge detection algorithms
%                         plot the corresponding ROC curves
%-------------------------------------------------------------------------------------%
butterfly = reduceNoise(butterfly);
groundTruthImg = im2bw(groundTruthImg, 0.3);


%-------------------------------------------------------------------------------------%
%                    perform SOBEL edge detection and evaluate its
%                 performance by plotting the ROC curve and PR curve
%-------------------------------------------------------------------------------------%
result1 = sobelDetector(butterfly);
evaluationEdgeDetectors(result1, groundTruthImg);

% threasholding the image
thresh=60;
B = thresholdImg(thresh, result1);
%PRcurve(B, groundTruthImg);

%-------------------------------------------------------------------------------------%
%                    perform PREWITT edge detection and evaluate its
%                  performance by plotting the ROC curve and PR curve
%-------------------------------------------------------------------------------------%
result2 = prewittDetector(butterfly);
evaluationEdgeDetectors(result2, groundTruthImg);

% threasholding the image
thresh=55;
B = thresholdImg(thresh, result2);
%PRcurve(B, groundTruthImg);

%-------------------------------------------------------------------------------------%
%          perform edge detection by using derivative of Gaussian filtering 
%            and evaluate its performance by plotting the ROC and PR curve
%-------------------------------------------------------------------------------------%
[result3, direction] = GaussianFilteringDerivative(butterfly);
evaluationEdgeDetectors(result3, groundTruthImg);

% threasholding the image
B = thresholdImg(10, result3);
%PRcurve(B, groundTruthImg);

%-------------------------------------------------------------------------------------%
%                       Evaluate the Canny Edge detector
%                  performance by plotting the ROC and PR curve
%-------------------------------------------------------------------------------------%

evaluationCannyEdgeDetector(butterfly, groundTruthImg);
B = im2bw(butterfly, 0.3);
%PRcurve(B, groundTruthImg);

end


function grayimg = convertToGray(img)

[rows cols dim] = size(img);
%check if the image is grayscale
if(dim > 1)
grayimg = rgb2gray(img);
else 
    grayimg = img;
end

end