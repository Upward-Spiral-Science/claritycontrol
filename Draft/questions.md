###Questions About my Project

We have 'D' datasets with each dataset containing 3D image data I=G(X,Y,Z), in gray scale.

'R' is the resolution level of the 3D image data I. It can be set from 1 to 5.

We know that gray scale images contain values form 0 to 255 for each pixel.

Each dimension X,Y,Z of the image data I has seperate ranges and offsets.

'T' is a histogram of the data, which is a count of the number of times a value appears in image datasets.

**Descriptive** <br />

* What assumptions do we need to make before analyzing our data?
* What is the meaning of three dimensions in a 3D image dataset?
* The best size of our datasets for experimentation?
* What is the histogram of a 3D image?
* How sparse are the images (ratio of pixels with value 0 over size of the image)?

**Exploratory** <br />

* Can normalized histograms create meaningful data for the CLARITY brains?
* Do we need to segment the image data? 
* How do we perform segmentation?
* How does the resolution effect our project?
* What is the best resolution for our 3D image - balancing precision and recall?
* If p_x(i)=p(x=i)=n_i/n where 0<=i<L, then which normalization technique is best?

**Inferential** <br />

* Can clustering reveal trends about our data?
* What conditions do we need to control to make an inference?
* Is there any specific range to determine a certain brain structure?
* What kind of computational models should we use?

**Predictive** <br />

* What kind of regression do we need to run?
* Given a condition, can we predict the reaction within brain structures? Or reverse?
* How do we mathematically represent our results?

**Causal** <br />

* What do we need to prove in order to make a causal claim?
* How does state or environment influence the reaction within a certain structure of the brain?
* With only ten brains how do we validate associational assumptions?
* Does P(Y = y|set(X = x)) reveal causal directionality?

**Mechanistic** <br />

* How does a difference in gene make a difference of reaction within brain structures, given the identical external conditions?


