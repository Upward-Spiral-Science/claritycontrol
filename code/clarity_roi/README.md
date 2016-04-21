# Clarity ROI analysis

## ROI extraction and features generating

> This matlab code is based on part of CLARITYDataAnalysis Project.

The matlab code used in the original project is very inefficient, requires too much memory and takes very long time to finish. 
The main focus here is largely rewrite the code and fit it into smaller memory and run faster. 
You may find there are many programming optimizations crafted in the code.

To run the code:

1. Find a machine or server with sufficient memory (recommend more than 8GB free memory). Put this folder on the machine. The machine need to install matlab and its commandline tools.
2. Create a folder named dataMatfile and get the data into it. (I will upload all the data to foo.cis.jhu.edu server at /cis/home/alee/clarity_roi/dataMatfile/ directory)
3. Run commandline <code>matlab -nodisplay -nodesktop -r "run ./main.m"</code>.
4. The results will be in dataMatfile folder with .csv suffix.

## Some tips and explanations

1. The program will run for a long time before finish, so you may use screen command to hold a session. Detach it while it's running.
2. The data mat-files are generated from the annotation .nrrd file and clarity .tif files, it use matlab v7.3 format with compression. They are much smaller than the original data files.
3. The features extracted are stored into a csv file for each of the brains. Each row contains features computed from each ROI. The data in each raw contains 12 features computed in 13 directions, plus the mean, std and roi_ID, so there are 12*13+3 columns.
