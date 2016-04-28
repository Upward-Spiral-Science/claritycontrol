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
load('brain_187');
load('brain_188');
load('brain_197');
load('brain_199');
load('brain_200'); %Fear

%Testing for a pair of features - Contrast & Correlation 
for i=1:26
figure(i);
p1=scatter(brain_173(i,11),brain_173(i,12),'ro'); hold on;
p2=scatter(brain_174(i,11),brain_174(i,12),'ro');
p3=scatter(brain_175(i,11),brain_175(i,12),'ro');
p4=scatter(brain_177(i,11),brain_177(i,12),'ro');
p5=scatter(brain_178(i,11),brain_178(i,12),'ro');
p6=scatter(brain_181(i,11),brain_181(i,12),'b.');
p7=scatter(brain_182(i,11),brain_182(i,12),'b.');
p8=scatter(brain_189(i,11),brain_189(i,12),'b.');
p9=scatter(brain_239(i,11),brain_239(i,12),'b.');
p10=scatter(brain_258(i,11),brain_258(i,12),'b.');
p11=scatter(brain_187(i,11),brain_187(i,12),'g*');
p12=scatter(brain_188(i,11),brain_188(i,12),'g*');
p13=scatter(brain_197(i,11),brain_197(i,12),'g*');
p14=scatter(brain_199(i,11),brain_199(i,12),'g*');
p15=scatter(brain_200(i,11),brain_200(i,12),'g*');
xlabel('Correlation');
ylabel('Contrast');
legend([p1,p6,p11],'Cocaine','Control','Fear');
roiname=num2str(brain_173(i,3));
title(sprintf('Pair of features %s',roiname));
end

