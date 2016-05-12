NOTE: Originally we revised our questions directly onto our original questions document. 
The documents have been edited to append this difference from the class example.

<<<<<<< HEAD

=======
###Questions About my Project

We have D datasets, each dataset contains 3D image data I=G(X,Y,Z) in gray scale.

R is the resolution level of a 3D image data I, it can be set from 0 to 5.

We know that gray scale image contains values form 0 to 255 for each pixel.

Each dimension X,Y,Z of image data I has seperate ranges and offsets.

T is a histogram of a data, which is table of counting the times a value appears in image datasets.
>>>>>>> dev

**Descriptive** <br />

* What assumptions do we need to make before analyzing our data?
<<<<<<< HEAD
There are many assumptions that are necessary: 
  * By removing "outliers" we are not changing fundamental information about the brain
  * By reducing the resolution to a significant extent (resolution factor = 5) we can still obtain reasonable data
  * Image analysis techniques will not change the data to a significant extent
  * No external factor plays a greater role than the influence of concaine/fear on the brain

* What is the meaning of three dimensions in a 3D image dataset?
  * The meaning of 3 different coordinates of data we need to analyze- 3 spatial axes [X Y Z]

* The best size of our datasets for experimentation?
  * The bottleneck probably will not be the size of the dataset, rather it will be the processing power of our computers
  * The size of a single dataset [500 GB] can be reduced to a manageable size [0.5 GB] by scaling the resolution by a factor of 5. 

* What is the histogram of a 3D image?
  * Determines the grayscale value spread of the image

* How sparse are the images (ratio of pixels with value 0 over size of the image)?
  * Depends on the resolution of the image. 

**Exploratory** <br />

* Can normalized histograms create meaningful data for the CLARITY brains?
  * We need more data, however theoretically there should be differences in the normalized histograms
* Do we need to segment the image data? 
  * We can only answer this after we parse the data without segmentation
* How do we perform segmentation?
  * Segmentation needs to be performed by calling chunks/blocks of data of higher quality rather than a large mass of data of lower quality
* How does the resolution effect our project?
  * Lower resolution will give us more “black” pixels
* What is the best resolution for our 3D image - balancing precision and recall?
  * This can only be determined by testing
* If p_x(i)=p(x=i)=n_i/n where 0<=i<L, then which normalization technique is best?
  * We don’t know the answer to this yet
=======
  * No external factor plays a greater role than the influence of concaine/fear on the brain 
* What is the meaning of three dimensions in a 3D image dataset?
  * 3 dimensions - 3 spatial axes X Y Z
* What is the resolution of a 3D image? 
  *  The resolution can be varied between 0 and 5. 
  *  Due memory restrictions we will use image data scaled by 5. 
* The size of our datasets?
  * The size of unscaled dataset is about 500 GB for a single dataset. 
  * The size of the scaled [ by 5] dataset is 0.5 GB. 
* What is the histogram of a 3D image?
  * Frequency of occurence of gray value. 
* How sparse are the images (ratio of pixels with value 0 over size of the image)?
   * we need to look at the data to find the number of 0s in the image. 

**Exploratory** <br />

* Can normalized histograms create meaningful data for the clarity brains?
* Do we need to segment the image data and how to perform segmentation?
* How does the resolution effect our project?

>>>>>>> dev

**Inferential** <br />

* Can clustering reveal trends about our data?
<<<<<<< HEAD
  * Theoretically there should be different clusters for each “brain group”
* What conditions do we need to control to make an inference?
  * Potentially the size of the data
* Is there any specific range to determine a certain brain structure?
  * We need to experiment to discover this
* What kind of computational models should we use?
  * Possible random forest
=======
* What conditions do we need to control to make an inference?
* Is there any specific range to determine a certain brain structure?
>>>>>>> dev

**Predictive** <br />

* What kind of regression do we need to run?
<<<<<<< HEAD
  * Start with linear regression, and then increase complexity
* Given a condition, can we predict the reaction within brain structures? Or reverse?
  * We need data to support this
* How do we mathematically represent our results?
  * Normalized histograms, and clustering of data points

**Causal** <br />
For Causal we need a lot of research and data

* What do we need to prove in order to make a causal claim?
* How does state or environment influence the reaction within a certain structure of the brain?
* With only ten brains how do we validate associational assumptions?
* Does P(Y = y|set(X = x)) reveal causal directionality?

**Mechanistic** <br />
To determine mechanistic questions we need a lot of research and data

* How does a difference in the state of the subject (normal/diseased) make a difference in the structure of the brain?



=======
* Given a condition, can we predict the reaction within brain structures? Or reverse?

**Causal** <br />

* What do we need to prove in order to make a causal claim?
* How does emotions or environment influence the reaction within a certain structure of the brain?

**Mechanistic** <br />

* How does a difference in gene could make a difference of reaction within brain structures, given the identical external conditions?
>>>>>>> dev

