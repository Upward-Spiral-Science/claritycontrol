#Extract ROI and main issues

I have tried to write python code to extract ROI:
[roi_analysis.py](https://github.com/Upward-Spiral-Science/claritycontrol/blob/master/code/scripts/roi_analysis.py)

But there are two main issues that I could not achieve extracting ROI and calculate all the features.

## Issue 1

The atlas file seems to be too large (4.6G) to fit into memory. So write now I'm using fake image and fake atlas to test the code.

## Issue 2

In terms of compute the GLCM matrix, I found in ROI analysis they use a lib code in matlab. Which could generating GLCM with 3D image, all the mathmatical details are hidden behind that lib file.

[The lib file: cooc3d](http://www.mathworks.com/matlabcentral/fileexchange/19058-cooc3d)

However, I tried to find anything helpful with computing GLCM matrix in python, I could only find

* http://scikit-image.org/docs/dev/auto_examples/features_detection/plot_glcm.html
* http://scikit-image.org/docs/dev/api/skimage.feature.html?highlight=greycoprops#skimage.feature.greycoprops
* http://scikit-image.org/docs/dev/api/skimage.feature.html?highlight=greycomatrix#skimage.feature.greycomatrix

which only works with 2d image.
