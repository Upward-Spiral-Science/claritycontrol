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
clear all;
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
load('brain_187');
load('brain_188');
load('brain_197');
load('brain_199');
load('brain_200'); %Fear

%load feature names 
load('feature_names');
%load roi numbers
load('roi_numbers');
j=1;
%pick ROIs to test
    %roi1=13;
%Testing for a pair of features - Kmeans clustering 
%loop through all ROIs
no=1;
for k=1:27
    figure(k);
    roi1=k;
    for i = 1:14 %loop through all features
        for j=1:14
        X = [brain_173(roi1,i+6), brain_174(roi1,i+6), brain_175(roi1,i+6), brain_177(roi1,i+6) ,brain_178(roi1,i+6), brain_181(roi1,i+6),brain_182(roi1,i+6),brain_189(roi1,i+6),brain_239(roi1,i+6),brain_258(roi1,i+6);brain_173(roi1,j+6), brain_174(roi1,j+6), brain_175(roi1,j+6), brain_177(roi1,j+6) ,brain_178(roi1,j+6), brain_181(roi1,j+6),brain_182(roi1,j+6),brain_189(roi1,j+6),brain_239(roi1,j+6),brain_258(roi1,j+6)];
        X=X.';
        E = evalclusters(X,'kmeans','silhouette','klist',[1:6]);
        rng(100);
        opts = statset('Display','final');
        idx(:,j) = kmeans(X,2,'Distance','cityblock',...
    'Replicates',3,'Options',opts);
       s(:,j) = silhouette(X,idx(:,j),'cityblock');
       mean_s(j)=mean(s(:,j));
       [max_s(i) ft(i)]=max(mean_s);
       
% if E.OptimalK==2 && mean_s(j)>0.5
%     figure(no);
%     subplot(121);plot(E);
%         subplot(122);plot(X(1:5,1),X(1:5,2),'mo','MarkerSize',8);hold on;
%         plot(X(6:10,1),X(6:10,2),'co','MarkerSize',8);
%         gscatter(X(:,1),X(:,2),E.OptimalY,'rb','xx');         
%         xlabel(sprintf('%s',feature_names{i}),'FontSize',14);
%         ylabel(sprintf('%s',feature_names{j}),'FontSize',14); 
%         legend('Cocaine','Control','Cluster 1','Cluster 2');
%         title(sprintf('ROI: %d',roi_numbers(roi1)),'FontSize',14);
%         no=no+1;
% end
        end
    end 
     
    
     [best(roi1) I(roi1)]= max(max_s);
     bestft(roi1)=ft(I(roi1));
     disp('ROI NO:');
     disp(roi_numbers(roi1));
     display(feature_names{I(roi1)});
     display(feature_names{bestft(roi1)});
     i=I(roi1);
     j=bestft(roi1);
     %verify and plot
        X= [brain_173(roi1,i+6), brain_174(roi1,i+6), brain_175(roi1,i+6), brain_177(roi1,i+6) ,brain_178(roi1,i+6), brain_181(roi1,i+6),brain_182(roi1,i+6),brain_189(roi1,i+6),brain_239(roi1,i+6),brain_258(roi1,i+6);brain_173(roi1,j+6), brain_174(roi1,j+6), brain_175(roi1,j+6), brain_177(roi1,j+6) ,brain_178(roi1,j+6), brain_181(roi1,j+6),brain_182(roi1,j+6),brain_189(roi1,j+6),brain_239(roi1,j+6),brain_258(roi1,j+6)];
        X=X.';
        E = evalclusters(X,'kmeans','silhouette','klist',[1:6]);
        subplot(121);plot(E);
        rng(50);
        idx = kmeans(X,2);
        subplot(122);
        plot(X(1:5,1),X(1:5,2),'mo','MarkerSize',8);hold on;
        plot(X(6:10,1),X(6:10,2),'co','MarkerSize',8);
        gscatter(X(:,1),X(:,2),E.OptimalY,'rb','xx');       
%         plot(X(idx==1,1),X(idx==1,2),'*k');hold on;
%         plot(X(idx==2,1),X(idx==2,2),'*k');
       xlabel(sprintf('%s',feature_names{I(roi1)}),'FontSize',14);
       ylabel(sprintf('%s',feature_names{bestft(roi1)}),'FontSize',14); 
       legend('Cocaine','Control','Cluster 1','Cluster 2');
          %subplot(3,5,3);
    title(sprintf('ROI: %d',roi_numbers(roi1)),'FontSize',14);
end
     