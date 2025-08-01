## **Code package: Gifuni, L. (202x). Whispers in the oil market: exploring sentiment and uncertainty insights, _International Journal of Forecasting_, conditionally accepted.**

**Publication (open access).**

<a href="https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3957549"><u>Final working paper version.</u></a>

## **Software information**
Result in the paper are generated using either a MacOS laptop with an M1 Pro chip, 18GB of memory, or a Windows laptop with 16GB of memory and an Intel vPRO i5 processor. Text data are processed using Python (3.9), with the following libraries employed to obtain all text indicators: `transformers`, `pysentiment2`, `nltk`, `torch`, `scikit-learn`, `pandas`, `numpy`, `vaderSentiment`, `spacy`, `textblob`, `lm-sentiment`. The econometric analysis was conducted using MATLAB 2023b, while MCS and ROC-AUROC estimates were performed in R (4.1.1) with the following packages: `R.matlab`, `MCS`, `xtable`. The estimation of a 5-variable SVBVAR takes roughly 4 hours on one of the above computers.

## **Replication code**
Files in the folders **tables** and **figures** replicate the results reported in the main manuscript. Each subfolder already includes the data required for the estimation and the LaTeX code. However, for completeness, the folder **data** also provides the original format of each series used in the manuscript. Results in the online appendix can be shared upon request.
