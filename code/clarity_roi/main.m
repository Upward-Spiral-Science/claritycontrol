%% Extract ROI from ABA - RUNME
% This script generates a .mat file per brain analyzed

% Introduce variables to the workspace
masked_ano = 1;
cropped_ano = 1;
mask = 1;

disp('=== Start ===');

disp('Loading Atlas mat file ...');
whos('-file','./dataMatfile/atlas.mat')  % display
atlasfile = matfile('./dataMatfile/atlas.mat','Writable',true);
disp('OK.');

disp('Loading brain file names ...');
mouse_fnames = clarity_filenames(); % Fear, Control, Cocaine
disp('OK.');

% Loop over each mouse brain
for n=1:length(mouse_fnames)
    disp('Loading brain file=');
    disp(mouse_fnames{n});
    whos('-file',mouse_fnames{n})  % display
    clarityfile = matfile(mouse_fnames{n},'Writable',true);
    [nrow, ncol, nsli] = size(clarityfile, 'clarity_volume');
    disp('OK.');
    
    try
        disp(clarityfile.znorm);
        disp('Already normalized.');
    catch
        disp('Z-score Normalization (only need to do once!) ...');
        tmp = reshape(clarityfile.clarity_volume,nrow*ncol*nsli,1);
        volMean = mean(tmp)  % display
        volSTD = std(tmp)  % display
        clear tmp;
        clarityfile.clarity_volume = (clarityfile.clarity_volume - volMean) ./ volSTD;
        clarityfile.znorm=1;
        disp('OK.');
    end
    
    %To reduce memory
    % clear cropped_ano;
    
    disp('Initialize feature vector ...');
    % Each element will contain the feature vector for that ROI
    [nrois, ~] = size(atlasfile,'roi_values')  % display
    brain_rois = zeros(nrois, 159);
    disp('OK.');
    
    disp('Loop over each ROI');
    for m=1:nrois
        
        % Select ROI number
        roi_number = atlasfile.roi_values(m,1)  % display

        disp('Getting mask and crop the volume ...');
        maskfname = sprintf('tmp_roi_%d.mat',roi_number);

        if exist(maskfname,'file') == 2
            disp('Mask file exist, read from file ...');
            maskfile = matfile(maskfname,'Writable',true);
            [nrow, ncol, nsli] = size(maskfile,'mask');
            mask = maskfile.mask(1:nrow,1:ncol,1:nsli);
            off_row = maskfile.off_row;
            off_col = maskfile.off_col;
            off_slice = maskfile.off_slice;
            disp('OK.');
        else
            disp('Mask file not exist, getting mask ...');
            [mask, row, col, slice] = getMaskFromABA(atlasfile.atlas_anno, roi_number, false);
            off_row = min(row);
            off_col = min(col);
            off_slice = min(slice);
            mask = mask(off_row:max(row), off_col:max(col), off_slice:max(slice));
            clear row; clear col; clear slice;

            [nrow, ncol, nsli] = size(mask);

            save(maskfname,'mask','-v7.3');
            maskfile = matfile(maskfname,'Writable',true);
            maskfile.off_row = off_row;
            maskfile.off_col = off_col;
            maskfile.off_slice = off_slice;
            disp('OK.');
        end

        disp('Crop volume ...');
        cropped_ano = mask .* clarityfile.clarity_volume(off_row:off_row+nrow-1,off_col:off_col+ncol-1,off_slice:off_slice+nsli-1);
        clear mask;
        % Replace zeros with NaN
        cropped_ano(cropped_ano == 0) = NaN;
        disp(size(cropped_ano));
        disp('OK.');
        
        disp('Calculate statistics ...');
        % Compute 12 features in 13 different directions
        [featureVector, coocMat] = cooc3d (cropped_ano, 'distance', 1);
        disp('Done cooc3d.');
        %featureVector is a vector of 12*13 features
        featureVector(end+1) = nanmean(cropped_ano(:));
        featureVector(end+1) = nanstd(cropped_ano(:));
        featureVector(end+1) = roi_number;
        disp('Done mean and std.');
        disp(size(featureVector));
        disp(sum(isnan(featureVector)));
        disp('OK.');

        brain_rois(m,:) = featureVector;

        clear cropped_ano;
        disp([m, nrois]);
    end
    featurefname = strcat(mouse_fnames{n}, '.csv');
    csvwrite(featurefname, brain_rois)

    disp([n, length(mouse_fnames)])
end

disp('=== Finish ===');
exit;

