function VOL = loadVolume(filename) 
% filename - name of file 
% VOL 3D matrix 

% Determine size of the volume 
info = imfinfo(filename);
imgInfo = info(1); 
numberOfImages = length(info);

% Allocate Memory 
VOL = zeros(imgInfo.Height, imgInfo.Width, numberOfImages); 

% Loop over each image 
for k = 1:numberOfImages
    currentImage = imread(filename, k, 'Info', info);
    VOL(:,:,k) = currentImage;
end