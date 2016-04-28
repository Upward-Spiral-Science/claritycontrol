# CLARITY Control: Final report (Draft)

> Wei Wang

> NOTE: all CLARITY should use capital letters when it refer to CLARITY technique

> This is an informal report, reference will be provided as clear as possible.

## Abstract
TODO: finish this at the end

## Overview

**CLARITY introduction**

CLARITY is a technique developed to transform an intact tissue into an optically transparent and permeable hydrogel-hybridized form that can undergo immunostaining and high resolution 3-D imaging without damage to the sample. Facing the difficulty of getting both detailed structural and molecular information from intact tissues in studying biological system, it is desired to find way which could help researchers "look through" the tissues with details. CLARITY provides visualization
of long-range cellular projections for three-dimensional tissue mapping of a variety of tissue types with the following benefits:[^1]

1. No damage or thin sectioning required to visualize whole intact tissue samples
2. Allows marking and visualization of long-range projections and subcellular structures
3. Allows multiple rounds of molecular phenotyping
4. Applicable to multiple tissue types and sizes

CLARITY has been proved to be an viable method to explore tissues and has been successfully applied to clearing mouse brain, human brain slices, mouse spinal cord.

**Overview of the work**

Having the dataset of CLARITY images of sample subjects under different conditions, the work in this project aims to explore the dataset and find the connection between conditions and brain reactions. Each CLARITY raw image data is very large (even with lowest resolution) and hardly could fit into computing machine that we have, therefore the size of data should be take care of when processing. One good thinking is build statistical features over each data sample rather than process
directly on the raw image, but this will require good insights about the data. Another common method is do sampling on the data. Limited data samples could also cause challenges, analysis may yield result that doesn't apply to general cases. Based on the fact that different parts of brain serve different functions and may react on certain stimulation, condition or drug, we try to extract the data in different region of the brain and do region-wise exploration. This increase the data
produced from raw images. The region reference is based on Allen Mouse Brain Atlas—a molecular map showing where all genes are expressed in all regions of the mouse brain.[^2]

**Significance**

Psychiatric disease represents the leading cause of disability both in the U.S. and worldwide [^3]. Many major pharmaceutical companies are closing down psychiatry programs due to the lack of neural circuit-level understanding of disease-related states such as fear and reward, which impairs identification of targets for treatment [^4]. Visualization of neural projections linked to causality information and molecular descriptors will deepen our understanding of the neural
structural dynamics that underlie behavior, although so far slicing or ablative electron microscopy and array tomography methods [^5][^6] are not readily linkable with causal information on the behavioral significance of the connections. It is important to observe fine details of symptomatic brains without losing larger-scale circuit perspective. The efforts made to study CLARITY models has the potential to influence the lives of millions of people across the globe.

**Feasibility**

In preserving the full continuity of neuronal structures, CLARITY not only allows tracing individual neural connections over long distances through the brain, but also provides a way to gather rich, molecular information describing a cell's function that is not possible with other methods[^4]. In this project, we expect to establish at least one parametric structural difference in response to fear between normal and diseased brains. Although CLARITY data is of immense
benefit to the field of neuroscience, turning massive amounts of data into useful insight poses immense computational challenges that we will have to address.

**Report organization**

## Related Work

German anatomist Werner Spalteholz developed a way to render heart tissue transparent with a mixture of benzyl alcohol and methyl salicylate in order to study the causes of heart attacks. He displayed 370 of his cleared specimens at an exhibition in 1911. Yet his approach did not have a strong scientific impact.[4]

In 2013, CLARITY method was introduced on the paper *Structural and molecular interrogation of intact biological systems*[5] in *Nature*. The method address the challenge for obtaining high-resolution information from a complex system, such as brain tissues. The clearing mechanism is based on formation of a hydrophilic tissue-polymer composite, followed by  aqueous solvent-based disruption and removal of unbound components such as lipids by diffusive, mechanical, thermal,
electrical, or other means.

![Chung K, Wallace J, Kim S Y, et al. Structural and molecular interrogation of intact biological systems[J]. Nature, 2013, 497(7449): 332-337.](https://raw.githubusercontent.com/Upward-Spiral-Science/claritycontrol/master/figs/final_report/intact-adult-mouse-brain.jpg)

**Intact adult mouse brain imaging**[5]

*Imaging was performed in adult mouse brains (3 months old). a, Cajal quote before CLARITY. b, Cajal quote after CLARITY: Thy1–eYFP line-H mouse brain after hydrogel–tissue hybridization, ETC and refractive-index matching (Methods). c, Fluorescence image of brain depicted in b. d, Dorsal aspect is imaged (single-photon (1p) microscopy), then brain is inverted and ventral aspect imaged. e, Three-dimensional rendering of clarified brain imaged (×10 water-immersion objective;
numerical aperture, 0.3; working distance, 3.6 mm). Left, dorsal half (stack size, 3,100 µm; step size, 20 µm). Right, ventral half (stack size, 3,400 µm; step size, 20 µm). Scale bar, 1 mm (Supplementary Videos 3–5). f, Non-sectioned mouse brain tissue showing cortex, hippocampus and thalamus (×10 objective; stack size, 3,400 µm; step size, 2 µm). Scale bar, 400 µm (Supplementary Video 2). g–l, Optical sections from f showing negligible resolution loss even at ~3,400-µm deep: z=446 µm (g,
h), z=1,683 µm (i, j) and z=3,384 µm (k, l). h, j and l, boxed regions in g, i and k, respectively. Scale bars, 100 µm.m, Cross-section of axons in clarified Thy1–channelrhodopsin2 (ChR2)–eYFP striatum: membrane-localized ChR2–eYFP (1-mm-thick coronal block; ×63 glycerol-immersion objective; numerical aperture, 1.3; working distance, 280 µm). Scale bar, 5 µm. n, Dendrites and spines of neurons in clarified Thy1–eYFP line-H cortex (1-mm-thick coronal block; ×63 glycerol objective).
Scale bar, 5 µm.*

To test whether CLARITY could be used to show how brains react to stimuli, neuroscientists Li Ye and Karl Deisseroth of Stanford University in California engineered mice so that their neurons would make a fluorescent protein when they fired. (The system is activated by the injection of a drug.) The researchers then trained four of these mice to expect a painful foot shock when placed in a particular box; another set of mice placed in the box received cocaine, rather than shocks.[^7]
The results are presented on 14 November 2014 at the conference of the US National Institute on Drug Abuse in Bethesda, Maryland.

## CLARITY Image Dataset

TODO:
* Description about the datasets, tables
* Format & Atlas
* Introduce how to Load data
* Plots
* Visualization
* Adapting computational resources

The CLARITY dataset we obtained contains 15 CLARITY samples. Each sample is a 3d image in only one channel (grayscale) with on of three labels, control, cocaine and fear. The dataset is getting from one of the server in Center For Imaging Science.[3] We found two sets of the CLARITY data, one is raw data in nifti format, the other is in tif which has been manipulated and registered on Allen Mouse Brain Atlas. This will be explained in a moment, let's first look at the basic description
of the data.

**Table of CLARITY data information**

|subject id|condition|nifti size (resolution=5)|tif size|
|---|-------|------------|-------------|
|181|control|677x812x767 |1382x1170x770|
|182|control|642x744x767 |1382x1170x770|
|189|control|628x770x1333|1382x1170x770|
|239|control|609x757x1375|1382x1170x770|
|258|control|557x757x1375|1382x1170x770|
|173|cocaine|            |1382x1170x770|
|174|cocaine|655x815x1408|1382x1170x770|
|175|cocaine|662x749x1094|1382x1170x770|
|177|cocaine|            |1382x1170x770|
|178|cocaine|557x733x1371|1382x1170x770|
|187|fear   |572x862x1087|1382x1170x770|
|188|fear   |            |1382x1170x770|
|197|fear   |608x795x1097|1382x1170x770|
|199|fear   |540x717x1358|1382x1170x770|
|200|fear   |557x721x1295|1382x1170x770|

**Allen Mouse Brain Atlas and LDDMM Registering**

In order to compare between CLARITY sampled and further compare the certain region of the sample. We need to put the data in the same scale in order diminish noise information. How do we manipulate the data, such that they can be compared fairly? The answer is to map the CLARITY brain image to a "standard" brain map. The "standard" brain we used is Allen Mouse Brain Atlas (AMBA) resource. The AMBA brain map is a 3d image with some integer values, which is also known as annotation
values. Each value represent a certain region, therefore AMBA brain map is a 3d region map of mouse brain.

LDDMM

**How to load data**



**3D visualization of the data**


![CLARITY 3D visualization 1](https://raw.githubusercontent.com/Upward-Spiral-Science/claritycontrol/master/figs/final_report/clarity3d1.png)

![CLARITY 3D visualization 2](https://raw.githubusercontent.com/Upward-Spiral-Science/claritycontrol/master/figs/final_report/clarity3d2.png)


## Histogram

## ROI Extraction and Features building
TODO:
1. ROI and Atlas
2. ROI extraction
3. features building
4. Heat map

## Exploring ROI Features

## Conclusions

## Future Work

## Resources and Reference

1. CLARITY Resources Center: http://clarityresourcecenter.org/
2. Allen Brain Atlas: http://www.brain-map.org/
3. JHU Center For Imaging Science: http://www.cis.jhu.edu/index.php 
4. Marx V. Microscopy: seeing through tissue[J]. Nat. Methods, 2014, 11(12): 1209-1214.
5. Chung K, Wallace J, Kim S Y, et al. Structural and molecular interrogation of intact biological systems[J]. Nature, 2013, 497(7449): 332-337.

[^1]: http://wiki.claritytechniques.org/index.php/CLARITY_Technique

[^2]: http://www.brain-map.org/overview/index.html

[^3]: https://www.nami.org/Learn-More/Mental-Health-By-the-Numbers

[^4]: http://www.nature.com/nprot/journal/v9/n7/full/nprot.2014.123.html

[^5]: http://science.sciencemag.org/content/334/6056/618

[^6]: http://www.sciencedirect.com/science/article/pii/S0896627307004412

[^7]: http://www.nature.com/news/transparent-brains-reveal-effects-of-cocaine-and-fear-1.16365

