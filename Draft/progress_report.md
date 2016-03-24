## Progress Report - March 23rd, 2016
**Table of Contents:**
- [Overview](./progress_report.md#overview)
- [Scientific Questioning](./progress_report.md#scientific-questioning)
  - [Decriptive Analysis](./progress_report.md#descriptive-analysis)
  - [Exploratory Analysis](./progress_report.md#exploratory-analysis)
  - [Inferential Analysis](./progress_report.md#inferential-analysis)
  - [Predictive Analysis](./progress_report.md#predictive-analysis)
  - [Testing Assumptions](./progress_report.md#testing-assumptions)
  - [Next Steps](./progress_report.md#next-steps)
- [Methods](./progress_report.md#methods)
  - [Decriptive Analysis](./progress_report.md#descriptive-analysis-1)
  - [Exploratory Analysis](./progress_report.md#exploratory-analysis-1)
  - [Inferential Analysis](./progress_report.md#inferential-analysis-1)
  - [Predictive Analysis](./progress_report.md#predictive-analysis-1)
  - [Testing Assumptions](./progress_report.md#testing-assumptions-1)

----------

### Overview
Clarity brain imaging can potentially unlock the secrets behind differentiating brain structures in different people.

### Scientific Questioning
Exploratory and Descriptive Analysis was used to guide the questions that we decided to tackle.

#### Descriptive Analysis
Working with the data was relatively difficult due to the computationally intensive nature of the image volumes we tried to tackle. We first created an API to visualize the data. Next we converted the images to a csv representation using sparse sampling. By doing so we were able to understand the nuances involved with the Clarity data like intensity, clusters, etc. 

#### Exploratory Analysis
After visualizing the Clarity data and understanding where we could potentially generate useful data leads, we explored the images to determine patterns in the intensity of the images.

#### Inferential Analysis
Inferential Analysis was unfortunately not as useful for analysis because due to our extremely small sample size it was difficult to obtain statistically significant results. The main conclusion we reached was that the graphs we created were different from one another...which was obvious without any necessary analysis.

#### Predictive Analysis
Classification was also difficult due to the small sample size. 

#### Testing Assumptions


#### Next Steps
Thus far we have learned a fair amount about the edge densities and properties of our data. Moving forward, we can analyze the mean and covariance of the clusters found in our assumption checking, and cluster our data prior to testing hypotheses and classifying over covariates. We can also expand to regressing subject age, with several methods. Finally, once we are confident in and satisfied with a method testing on this dataset, we can expand towards testing the method on the MRN114 and SWU4 datasets, as well.

### Methods
Each of the questions required code and (for the inferential, predictive, and assumption checking portions) mathematical theory. This is all explained in detail in each file, tabulated below. Here, we will discuss the methods used in each of these sections, rationalize decision made, and discuss alternatives that could have been performed instead.

| Question Type | Code |
|---------------|------|
| Descriptive | [**``./code/descriptive_and_exploratory_answers.ipynb``**](./code/descriptive_and_exploratory_answers.ipynb) |
| Exploratory | [**``./code/descriptive_and_exploratory_answers.ipynb``**](./code/descriptive_and_exploratory_answers.ipynb) |
| Inferential | [**``./code/inferential_simulation.ipynb``**](./code/inferential_simulation.ipynb) |
| Predictive  | [**``./code/classification_simulation.ipynb``**](./code/classification_simulation.ipynb) |
| Testing Assumptions | [**``./code/test_assumptions.ipynb``**](./code/test_assumptions.ipynb) |

#### Descriptive Analysis
When answering descriptive questions, we sought out values which could summarize the dataset. Our sample sizes, graph size, and amount of obviously invalid data were chosen because they would be important in virtually any downstream task. More complicated features could have also been looked at, such as dynamic range of edge weights, or distribution of genders in each dataset as well.

#### Exploratory Analysis
Three exploratory questions were answered here: average degree, average graph, and plotting the histograms of edge weight. The average degree for each graph was computed by summing the binary edge count for each graph and dividing by the number of nodes. The graphs were binarized, but not thresholded or scaled before to remove small magnitude edges. This means that the estimated degree is an upper bound estimate based on these graphs.

The mean connectome was computed simply here due to the graphs being graph matched (i.e. same nodes). The edge-weight for each location was simply averaged across all graphs. We did not do this, but perhaps should (and certainly could) for each individual dataset as well, to see if population specific mean connectomes are significantly different from one another.

There was very limited computation or design when computing the histograms.

#### Inferential Analysis
Here we needed to define a model and test statistic for our hypothesis test. We wanted to test whether or not males and females are sampled from the same distribution, so we chose a test statistic that is a function of distribution: edge probability. We could have fit a GMM or other distribution to our data and then compared them, but as a preliminary measure this enabled us to proceed easily. We also needed to choose a statistical text. We choose the Wilcoxon test because it is a non-parametric test that makes significantly fewer assumptions about the data (i.e. doesn't impose a distribution) than the t-test. In order to prove that our test in fact convered to 1 in power as the number of samples approached infinity under the alternate model (that a class conditional probability exists), and would stay at our alpha value under the null model (no relationship exists), we simulated data that have similar properties to our graphs. Shown below is a figure illustrating that this test converges as desired.

<img src="../figs/inference_power.png" data-canonical-src="../figs/inference_power.png" width="300" />

#### Predictive Analysis
Similarly to the inferential analysis, we needed to here specify a model and loss function for our classification task. The model again used edge probability as the feature. Here the loss function was simply the indicator function over assigned label by the classifer compared to true label - if the labels were the same, there was no loss; otherwise, the loss was 1. Here we tested 5 different classifiers on the data and compared their performance. Some of the tests were non-parametric (LDA, QDA), while others required some parameters to be set (K-nearest neighbour, Linear SVM, and Random Forest). The parameters chosen for each of these algorithms was not at all tuned to our data, but were the default parameters suggested by the sklearn website, where the implementations were found. Improving this, and choosing parameters that match our assumptions or expectations about our data could drastically improve the performance of these classifiers.

Shown below is a figure illustrating the performance of each of these classifiers tested on simulated data that is sampled from a distribution similar to our observed data.

<img src="../figs/classifier_performance.png" data-canonical-src="../figs/classifier_performance.png" width="300" />

#### Testing Assumptions
When performing any analysis that requires assumptions, it is wise to test the assumptions made. We made three types of assumptions here: samples are independent, samples are identical, and there exists a class conditional covariance matrix (i.e. classes have different covariances). For testing independence, we chose to look at linear dependence. We computed the covariance matrix across all samples (first this meant graphs were samples, then samples were edges within the graphs), and looked at what portion of this lay in the off diagonal. If a significant portion of the covariance matrix lay in the off diagonal, we could say that the samples were not linearly independent.

For testing whether or not samples were identically distributed, we attempted to cluster the data using a Gaussian Mixture Model while varying the number of clusters. We ran Bayesian Information Criterion (BIC) on all of the clusterings and plotted the curve of BIC values over varying dimension. Where BIC is maximized, we have found the optimal number of clusters for this data (using this clustering method). Therefore, if the ideal number of clusters is 1, we can feel confident that our data may be identically distributed. However, when the optimal BIC is at a higher number, or monotonically increasing, it suggests that our data are not identically distributed.

The final test, which asserts a class conditional covariance, was perhaps the most obvious to test. We computed the covariance of all the data in each class, and then took the difference of the two class covariance matrices. We found that the covariance matrices were very different, which lead us to believe that this assumption was in fact correct.
