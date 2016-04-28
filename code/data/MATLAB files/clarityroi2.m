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
j=1;
%pick ROIs to test
    roi1=6;
    roi2=13;
%Testing for a pair of features - Contrast & Correlation 
for i=9:20
  
figure(j);subplot(121);
p1=scatter(brain_173(roi1,i),brain_173(roi1,i+1),'ro'); hold on;
p2=scatter(brain_174(roi1,i),brain_174(roi1,i+1),'ro');
p3=scatter(brain_175(roi1,i),brain_175(roi1,i+1),'ro');
p4=scatter(brain_177(roi1,i),brain_177(roi1,i+1),'ro');
p5=scatter(brain_178(roi1,i),brain_178(roi1,i+1),'ro');
p6=scatter(brain_181(roi1,i),brain_181(roi1,i+1),'b.');
p7=scatter(brain_182(roi1,i),brain_182(roi1,i+1),'b.');
p8=scatter(brain_189(roi1,i),brain_189(roi1,i+1),'b.');
p9=scatter(brain_239(roi1,i),brain_239(roi1,i+1),'b.');
p10=scatter(brain_258(roi1,i),brain_258(roi1,i+1),'b.');
p11=scatter(brain_187(roi1,i),brain_187(roi1,i+1),'g*');
p12=scatter(brain_188(roi1,i),brain_188(roi1,i+1),'g*');
p13=scatter(brain_197(roi1,i),brain_197(roi1,i+1),'g*');
p14=scatter(brain_199(roi1,i),brain_199(roi1,i+1),'g*');
p15=scatter(brain_200(roi1,i),brain_200(roi1,i+1),'g*');
xlabel(sprintf('Feature no: %d',i-8));
ylabel(sprintf('Feature No: %d',i-7));
%legend([p1,p6,p11],'Cocaine','Control','Fear');
title('ROI : 544');
subplot(122);
p1=scatter(brain_173(13,i),brain_173(13,i+1),'ro'); hold on;
p2=scatter(brain_174(13,i),brain_174(13,i+1),'ro');
p3=scatter(brain_175(13,i),brain_175(13,i+1),'ro');
p4=scatter(brain_177(13,i),brain_177(13,i+1),'ro');
p5=scatter(brain_178(13,i),brain_178(13,i+1),'ro');
p6=scatter(brain_181(13,i),brain_181(13,i+1),'b.');
p7=scatter(brain_182(13,i),brain_182(13,i+1),'b.');
p8=scatter(brain_189(13,i),brain_189(13,i+1),'b.');
p9=scatter(brain_239(13,i),brain_239(13,i+1),'b.');
p10=scatter(brain_258(13,i),brain_258(13,i+1),'b.');
p11=scatter(brain_187(13,i),brain_187(13,i+1),'g*');
p12=scatter(brain_188(13,i),brain_188(13,i+1),'g*');
p13=scatter(brain_197(13,i),brain_197(13,i+1),'g*');
p14=scatter(brain_199(13,i),brain_199(13,i+1),'g*');
p15=scatter(brain_200(13,i),brain_200(13,i+1),'g*');
xlabel(sprintf('Feature no: %d',i-8));
ylabel(sprintf('Feature No: %d',i-7));
%legend([p1,p6,p11],'Cocaine','Control','Fear');
title('ROI : 87');
j=j+1;
if i==20
    break;
end
end

