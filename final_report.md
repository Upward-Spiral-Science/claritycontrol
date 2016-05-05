# CLARITY Control: Final report

> Wei Wang, Albert Lee, Sahithi

-------
**Table of Contents:**
- [Overview](./final_report.md#overview)
- [Scientific Questioning](./final_report.md#scientific-questioning)
  - [Decriptive Analysis](./final_report.md#descriptive-analysis)
  - [Exploratory Analysis](./final_report.md#exploratory-analysis)
  - [Inferential Analysis](./final_report.md#inferential-analysis)
  - [Predictive Analysis](./final_report.md#predictive-analysis)
  - [Testing Assumptions](./final_report.md#testing-assumptions)
  - [Extended Exploratory Analysis](./final_report.md#extended-exploratory-analysis)
  - [Dimensionality Reduction](./final_report.md#dimensionality-reduction)
- [Methods](./final_report.md#methods)
  - [Decriptive Analysis](./final_report.md#descriptive-analysis-1)
  - [Exploratory Analysis](./final_report.md#exploratory-analysis-1)
  - [Inferential Analysis](./final_report.md#inferential-analysis-1)
  - [Predictive Analysis](./final_report.md#predictive-analysis-1)
  - [Testing Assumptions](./final_report.md#testing-assumptions-1)
  - [Extended Exploratory Analysis](./final_report.md#extended-exploratory-analysis-1)
  - [Dimensionality Reduction](./final_report.md#dimensionality-reduction-1)
----------

## Abstract

TODO: finish this at the end

## Overview

**CLARITY introduction**

CLARITY is a technique developed to transform intact tissue into an optically transparent and permeable hydrogel-hybridized form that can undergo immunostaining and high resolution 3-D imaging without damage to the sample. Solving the difficulty of obtaining detailed structural and molecular information from intact tissues, CLARITY provides visualization of long-range cellular projections for three-dimensional tissue mapping with the following benefits:[^1]

1. No damage or thin sectioning required to visualize whole intact tissue samples
2. Allows marking and visualization of long-range projections and subcellular structures
3. Allows multiple rounds of molecular phenotyping
4. Applicable to multiple tissue types and sizes

CLARITY has been proved to be a viable method to explore tissues and has been successfully applied to mouse brains, human brain slices, and mouse spinal cords.

**Overview of the work**

Having the dataset of CLARITY images of sample subjects under different conditions, the work in this project aims to explore the dataset and find the connection between conditions and brain reactions. Each CLARITY raw image data is very large (even with lowest resolution) and hardly could fit into computing machine that we have, therefore the size of data should be take care of when processing. One good thinking is build statistical features over each data sample rather than process directly on the raw image, but this will require good insights about the data. Another common method is do sampling on the data. Limited data samples could also cause challenges, analysis may yield result that doesn't apply to general cases. Based on the fact that different parts of brain serve different functions and may react on certain stimulation, condition or drug, we try to extract the data in different region of the brain and do region-wise exploration. This increase the data produced from raw images. The region reference is based on Allen Mouse Brain Atlas—a molecular map showing where all genes are expressed in all regions of the mouse brain.[^2]

**Significance**

Psychiatric disease represents the leading cause of disability both in the U.S. and worldwide [^3]. Many major pharmaceutical companies are closing down psychiatry programs due to the lack of neural circuit-level understanding of disease-related states such as fear and reward, which impairs identification of targets for treatment [^4]. Visualization of neural projections linked to causality information and molecular descriptors will deepen our understanding of the neural structural dynamics that underlie behavior, although so far slicing or ablative electron microscopy and array tomography methods [^5][^6] are not readily linkable with causal information on the behavioral significance of the connections. It is important to observe fine details of symptomatic brains without losing larger-scale circuit perspective. The efforts made to study CLARITY models has the potential to influence the lives of millions of people across the globe.

**Feasibility**

In preserving the full continuity of neuronal structures, CLARITY not only allows tracing individual neural connections over long distances through the brain, but also provides a way to gather rich, molecular information describing a cell's function that is not possible with other methods[^4]. In this project, we expect to establish at least one parametric structural difference in response to fear between normal and diseased brains. Although CLARITY data is of immense benefit to the field of neuroscience, turning massive amounts of data into useful insight poses immense computational challenges that we will have to address.

## Related Work

German anatomist Werner Spalteholz developed a way to render heart tissue transparent with a mixture of benzyl alcohol and methyl salicylate in order to study the causes of heart attacks. He displayed 370 of his cleared specimens at an exhibition in 1911. Yet his approach did not have a strong scientific impact.[4]

In 2013, CLARITY method was introduced on the paper *Structural and molecular interrogation of intact biological systems*[5] in *Nature*. The method address the challenge for obtaining high-resolution information from a complex system, such as brain tissues. The clearing mechanism is based on formation of a hydrophilic tissue-polymer composite, followed by  aqueous solvent-based disruption and removal of unbound components such as lipids by diffusive, mechanical, thermal, electrical, or other means.

![Chung K, Wallace J, Kim S Y, et al. Structural and molecular interrogation of intact biological systems[J]. Nature, 2013, 497(7449): 332-337.](https://raw.githubusercontent.com/Upward-Spiral-Science/claritycontrol/master/figs/final_report/intact-adult-mouse-brain.jpg)

**Intact adult mouse brain imaging**[5]

*Imaging was performed in adult mouse brains (3 months old). a, Cajal quote before CLARITY. b, Cajal quote after CLARITY: Thy1–eYFP line-H mouse brain after hydrogel–tissue hybridization, ETC and refractive-index matching (Methods). c, Fluorescence image of brain depicted in b. d, Dorsal aspect is imaged (single-photon (1p) microscopy), then brain is inverted and ventral aspect imaged. e, Three-dimensional rendering of clarified brain imaged (×10 water-immersion objective; numerical aperture, 0.3; working distance, 3.6 mm). Left, dorsal half (stack size, 3,100 µm; step size, 20 µm). Right, ventral half (stack size, 3,400 µm; step size, 20 µm). Scale bar, 1 mm (Supplementary Videos 3–5). f, Non-sectioned mouse brain tissue showing cortex, hippocampus and thalamus (×10 objective; stack size, 3,400 µm; step size, 2 µm). Scale bar, 400 µm (Supplementary Video 2). g–l, Optical sections from f showing negligible resolution loss even at ~3,400-µm deep: z=446 µm (g, h), z=1,683 µm (i, j) and z=3,384 µm (k, l). h, j and l, boxed regions in g, i and k, respectively. Scale bars, 100 µm.m, Cross-section of axons in clarified Thy1–channelrhodopsin2 (ChR2)–eYFP striatum: membrane-localized ChR2–eYFP (1-mm-thick coronal block; ×63 glycerol-immersion objective; numerical aperture, 1.3; working distance, 280 µm). Scale bar, 5 µm. n, Dendrites and spines of neurons in clarified Thy1–eYFP line-H cortex (1-mm-thick coronal block; ×63 glycerol objective). Scale bar, 5 µm.*

To test whether CLARITY could be used to show how brains react to stimuli, neuroscientists Li Ye and Karl Deisseroth of Stanford University in California engineered mice so that their neurons would make a fluorescent protein when they fired. (The system is activated by the injection of a drug.) The researchers then trained four of these mice to expect a painful foot shock when placed in a particular box; another set of mice placed in the box received cocaine, rather than shocks.[^7] They use the CLARITY technique to show how the entire brain responds to cocaine addiction and fear. 

It is believed that the findings could uncover new brain circuits involved in drug response. The results are presented on 14 November 2014 at the conference of the US National Institute on Drug Abuse in Bethesda, Maryland.

## CLARITY Image Dataset

The CLARITY dataset we obtained contains 15 CLARITY samples. Each sample is a 3d image in only one channel (grayscale) with on of three labels, control, cocaine and fear. The dataset is getting from one of the server in Center For Imaging Science.[3] We found two sets of the CLARITY data, one is raw data in nifti format, the other is in tif which has been manipulated and registered on Allen Mouse Brain Atlas. This will be explained in a moment, let's first look at the basic description of the data.

**Table of CLARITY data information**

| subject id | condition | nifti size (resolution=5) | tif size      |
| ---------- | --------- | ------------------------- | ------------- |
| 181        | control   | 677x812x767               | 1382x1170x770 |
| 182        | control   | 642x744x767               | 1382x1170x770 |
| 189        | control   | 628x770x1333              | 1382x1170x770 |
| 239        | control   | 609x757x1375              | 1382x1170x770 |
| 258        | control   | 557x757x1375              | 1382x1170x770 |
| 173        | cocaine   |                           | 1382x1170x770 |
| 174        | cocaine   | 655x815x1408              | 1382x1170x770 |
| 175        | cocaine   | 662x749x1094              | 1382x1170x770 |
| 177        | cocaine   |                           | 1382x1170x770 |
| 178        | cocaine   | 557x733x1371              | 1382x1170x770 |
| 187        | fear      | 572x862x1087              | 1382x1170x770 |
| 188        | fear      |                           | 1382x1170x770 |
| 197        | fear      | 608x795x1097              | 1382x1170x770 |
| 199        | fear      | 540x717x1358              | 1382x1170x770 |
| 200        | fear      | 557x721x1295              | 1382x1170x770 |

**Allen Mouse Brain Atlas and LDDMM Registering**

In order to compare between CLARITY sampled and further compare the certain region of the sample. We need to put the data in the same scale in order diminish noise information. How do we manipulate the data, such that they can be compared fairly? The answer is to map the CLARITY brain image to a "standard" brain map. The "standard" brain we used is Allen Mouse Brain Atlas (AMBA) resource. The AMBA brain map is a 3d image with some integer values, which is also known as annotation values. Each value represent a certain region, therefore AMBA brain map is a 3d region map of mouse brain.

Because each brain sample is obtained from different individual experiment subject, there might be a lot differences between each sample even though the brain structure is the same. Those differences including the size of the brain, the shape of the brain, orientations of the brain and the activity of the brain. To study the brain under different conditions, we need to be able to compare the brain samples without the distraction caused by size, shape or orientations, only keep the information of structure and activities. On the other hand it seems impossible to make annotations for each brain. Therefore, a method comes in for convert each sample to a new brain sample with same size, shape and orientation without hurting the structure and activities information. This method makes it much more convenience to compare and study the brain samples.

Large deformation diffeomorphic metric mapping (LDDMM) is often used to refer to a specific suite of algorithms used for diffeomorphic mapping and manipulating dense imagery based on diffeomorphic metric mapping within the academic discipline of Computational anatomy, to be distinguised from it's precursor based on diffeomorphic mapping.[^8]

For the datasets listed above, each tif format data is generated by performing LDDMM on the raw CLARITY image (nifti format). The LDDMM transform the raw data into a standard brain image referring to AMBA. The transformation is called registering the CLARITY data on Allen Mouse Brain Atlas.

**How to load data**

To load the raw nifti format data, we can use python package NiBabel.[^9] It will read the header file to get the meta information and the raw data will be stored as a 3d numpy array. Example line to load the data using NiBabel is the following:

```python
import nibabel as nib
img = nib.load(pathname)  # load data object
```

To load the tif format data, we can use MatLab. Note the tif format can be regraded as a stack of 2d images, so loading the data can be done by loading each layer as 2d image and stack together to a matrix. The following is the code for loading the data in MatLab:

```matlab
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
```

**3D visualization of the data**

It is nature to think about visualize the data directly in 3D to have a look at what it looks like. In this sense, we developed API to visualize the raw data. The API provide tools to visualize, sampling and making histogram of the raw data. The following shows how the visualization looks like. [Link to clarity API](https://github.com/Upward-Spiral-Science/claritycontrol/blob/master/code/scripts/clarity/__init__.py)

*Visualization of Fear199 CLARITY data*


![CLARITY 3D visualization 1](https://raw.githubusercontent.com/Upward-Spiral-Science/claritycontrol/master/figs/final_report/clarity3d1.png)

![CLARITY 3D visualization 2](https://raw.githubusercontent.com/Upward-Spiral-Science/claritycontrol/master/figs/final_report/clarity3d2.png)

The visualization shows the scatter plot in a 3D space. The size of the points indicates the magnitude of the value. The color (RGB) represent how far each point is from the original point in three directions.

> Note: there are some required packages need to be installed in order to run the visualization api. The packages including PyQt4, SIP, numpy, vispy, nibabel etc.

## Histogram

A variety of histogram techniques were used to analyze the data. Using the Clarity API obtaining histograms is simple. 

> Note: All the data directories and tokens are defined in `clarity/resources` and have default setting. The following code assumes the raw nifti dataset is stored in `WORKDIR/../data/raw`. Change it if this doesn't apply to you.

```python
import nibabel as nib
import os
# change working dir, use your own path
PATH="/Users/albertlee/claritycontrol/code/scripts/"
os.chdir(PATH)

import clarity as cl 
import matplotlib.pyplot as plt
import jgraph as ig

c = cl.Clarity("Fear199") # use the token corresponding to the wanted data
c.loadImg().imgToPoints(threshold=0.02,sample=0.3).showHistogram(bins=256) # adjust the threshold, sample, and bin number to the desired parameters
```

The following shows the histogram from 3 raw CLARITY images in different conditions.

![Fear199 Histogram](https://github.com/Upward-Spiral-Science/claritycontrol/blob/master/figs/final_report/hist_fear199.png?raw=true)

![Control239 Histogram](https://github.com/Upward-Spiral-Science/claritycontrol/blob/master/figs/final_report/hist_control239.png?raw=true)

![Cocaine174 Histogram](https://github.com/Upward-Spiral-Science/claritycontrol/blob/master/figs/final_report/hist_cocaine174.png?raw=true)

The raw image values are rescaled to 0-255 in order to visualize, however the histogram shows how those values are distributed. Data are sampled using a certain sample rate and small value or noise data are dropped using a threshold. From the figures its hard to tell apart between different samples.

The following figures shows the histogram distributions of each sample. Sample from different classes are plotted using different color.

![histograms](https://github.com/Upward-Spiral-Science/claritycontrol/blob/master/figs/final_report/histograms.png?raw=true)

From the histogram graph, we could find that the values tend to be concentrate within a certain range. And there are some difference between different classes, however it's still not very distinguish.

> Link to the [code and histograms files](https://github.com/Upward-Spiral-Science/claritycontrol/tree/master/code/data/hist).

**Indpendence of histograms**

![histograms covariance](https://github.com/Upward-Spiral-Science/claritycontrol/blob/master/figs/final_report/histograms-covariance.png?raw=true)

Ratio of on- and off-diagonal determinants: 0.289106140272.

The figure shows that the histograms are not very independent which makes it hard to be classified.

**Classification on histograms**

For classification, we cut off the parts containing the majority data. And run classification algorithms on it. The classification results indicate the histograms of the samples are not good for classification.

*Classification results*

|            Method            | Accuracy | +/-  |
| :--------------------------: | :------- | ---- |
|      Nearest Neighbors       | 0.00     | 0.00 |
|          Linear SVM          | 0.33     | 0.94 |
|        Random Forest         | 0.07     | 0.50 |
| Linear Discriminant Analysis | 0.47     | 0.47 |

**Histogram Equalization**

Applying local histogram equalization is a more complicated process, but can be accomplished with our _____ script.

## ROI Extraction and Features building
From the histogram of raw datasets, it's hard to do classification. One reason is that the histograms lose a lot of structure information and the distribution tends to be similar which makes it hard to classify. Therefore it might be helpful to compare each sample with structure information. We use the term region of interest (ROI) to refer a certain region in the brain, the region can be defined as a structural part or functional part of the brain. Each ROI has an identical number as an annotation, the annotations are marked in AMBA.

> This analysis is based on part of CLARITYDataAnalysis Project.
>
> However, the matlab code used in the original project is very inefficient, requires too much memory and takes very long time to finish. The main focus here is largely rewrite the code and fit it into smaller memory and run faster. You may find there are many programming optimizations crafted in the [code](https://github.com/Upward-Spiral-Science/claritycontrol/blob/master/code/clarity_roi/main.m).

**ROI extraction**

The workflow of ROI extraction consists of several steps. First, use z standarded normalization to normalize the data. Then build the binary mask from the AMBA atlas image and use the mask to mask out certain region from the data. Then find the bounding box of the region, all the features will be calculated in this bounding box.

**Build Haralick features**

Main features built from each region are Haralick features.[6] It consists of 12 features, stored in a table along with other information. The description of the final built features data is the following:

1. class label [0=cocaine | 1=control | 2=fear]
2. brain number
3. roi number
4. roi position X
5. roi position Y
6. roi position Z
7. roi mean
8. roi std
9. Haralick feature - Energy
10. Haralick feature - Entropy
11. Haralick feature - Correlation
12. Haralick feature - Contrast
13. Haralick feature - Variance
14. Haralick feature - SumMean
15. Haralick feature - Inertia
16. Haralick feature - Cluster Shade
17. Haralick feature - Cluster tendency
18. Haralick feature - Homogeneity
19. Haralick feature - MaxProbability
20. Haralick feature - Inverse Variance

## Exploring ROI Features

**Look into the features**

After building all the features of each region from each sample, it's time to look into the features. The figure below indicate the features on each region across samples.

*ROI features*
![ROI features](https://github.com/Upward-Spiral-Science/claritycontrol/blob/master/figs/final_report/roi_features.png?raw=true)

The following figures shows the features in 3D space. The size of the points indicates the magnitude of the feature values.

*ROI features 3D plot*
![ROI features 3d 173](https://github.com/Upward-Spiral-Science/claritycontrol/blob/master/figs/final_report/roi-features-3d-173.png?raw=true)

**Independence of features**

Because the features are related to both samples and regions, it seems to be more reasonable to compare the same region of different samples. After testing all the regions, we find the ROI 258 has the largest independence. The covariance is shown below:

![ROI 258 features covariance](https://github.com/Upward-Spiral-Science/claritycontrol/blob/master/figs/final_report/roi-258-features-covariance.png?raw=true)

Ratio of on- and off-diagonal determinants: 2.3949709038.

**Classification**

Extracting the ROI 258 data and running classification on it. The classification results are the following:

*Classification results*

|         Method         | Accuracy | +/-  |
| :--------------------: | :------- | ---- |
|   Nearest Neighbors    | 0.20     | 0.80 |
|       Linear SVM       | 0.33     | 0.94 |
|     Random Forest      | 0.20     | 0.80 |
|  Linear Discriminant   | 0.47     | 1.00 |
| Quadratic Discriminant | 0.47     | 1.00 |

## Future Work

TODO: finish this at the end

## Resources and Reference

1. CLARITY Resources Center: http://clarityresourcecenter.org/
2. Allen Brain Atlas: http://www.brain-map.org/
3. JHU Center For Imaging Science: http://www.cis.jhu.edu/index.php 
4. Marx V. Microscopy: seeing through tissue[J]. Nat. Methods, 2014, 11(12): 1209-1214.
5. Chung K, Wallace J, Kim S Y, et al. Structural and molecular interrogation of intact biological systems[J]. Nature, 2013, 497(7449): 332-337.
6. Haralick, Robert M., Karthikeyan Shanmugam, and Its' Hak Dinstein. "Textural features for image classification." *Systems, Man and Cybernetics, IEEE Transactions on* 6 (1973): 610-621.

[^1]: http://wiki.claritytechniques.org/index.php/CLARITY_Technique

[^2]: http://www.brain-map.org/overview/index.html

[^3]: https://www.nami.org/Learn-More/Mental-Health-By-the-Numbers

[^4]: http://www.nature.com/nprot/journal/v9/n7/full/nprot.2014.123.html

[^5]: http://science.sciencemag.org/content/334/6056/618

[^6]: http://www.sciencedirect.com/science/article/pii/S0896627307004412

[^7]: http://www.nature.com/news/transparent-brains-reveal-effects-of-cocaine-and-fear-1.16365

[^8]: https://en.wikipedia.org/wiki/Large_deformation_diffeomorphic_metric_mapping

[^9]: http://nipy.org/nibabel/
