% # DATA description (column description)
% # 0. Class label [0=cocaine | 1=control | 2=fear]
% # 1. Brain number
% # 2. ROI number
% # 3. ROI position X
% # 4. ROI position Y
% # 5. ROI position Z
% # 6. ROI mean
% # 7. ROI std
% # 8. Haralick feature - Energy
% # 9. Haralick feature - Entropy
% # 10. Haralick feature - Correlation
% # 11. Haralick feature - Contrast
% # 12. Haralick feature - Variance
% # 13. Haralick feature - SumMean
% # 14. Haralick feature - Inertia
% # 15. Haralick feature - Cluster Shade
% # 16. Haralick feature - Cluster tendency
% # 17. Haralick feature - Homogeneity
% # 18. Haralick feature - MaxProbability
% # 19. Haralick feature - Inverse Variance
%this code only tests  Cocaine vs Control
close all;
%Load data
load('brain_173');
load('brain_174');
load('brain_175');
load('brain_177');
load('brain_178'); %Cocaine
load('brain_181');
load('brain_182');
load('brain_189');
load('brain_239');
load('brain_258'); %Control

%load feature names 
load('feature_names');
%load roi numbers
load('roi_numbers');
j=1;
%pick ROIs to test
    roi1=13;
%Testing for a pair of features - Kmeans clustering 
%loop through all ROIs
    for i = 1:14 %loop through all features
        figure(i);
        for j=1:14
        X = [brain_173(roi1,i+6), brain_174(roi1,i+6), brain_175(roi1,i+6), brain_177(roi1,i+6) ,brain_178(roi1,i+6), brain_181(roi1,i+6),brain_182(roi1,i+6),brain_189(roi1,i+6),brain_239(roi1,i+6),brain_258(roi1,i+6);brain_173(roi1,j+6), brain_174(roi1,j+6), brain_175(roi1,j+6), brain_177(roi1,j+6) ,brain_178(roi1,j+6), brain_181(roi1,j+6),brain_182(roi1,j+6),brain_189(roi1,j+6),brain_239(roi1,j+6),brain_258(roi1,j+6)];
        X=X.';
        idx(:,j) = kmeans(X,2);
       s(:,j) = silhouette(X,idx(:,j),'cityblock');
       subplot(3,5,j);plot(X(1:5,1),X(1:5,2),'mo','MarkerSize',8);hold on;
       plot(X(6:10,1),X(6:10,2),'co','MarkerSize',8);hold on;
       plot(X(idx(:,j)==1,1),X(idx(:,j)==1,2),'*r');hold on;
       plot(X(idx(:,j)==2,1),X(idx(:,j)==2,2),'*b');
       xlabel(sprintf('%s',feature_names{i}));
       ylabel(sprintf('%s',feature_names{j})); 
       if j==14
       legend('Cocaine','Control','Cluster 1','Cluster 2');
       end
        end
        subplot(3,5,3);
    title(sprintf('ROI: %d',roi_numbers(roi1)));
    end