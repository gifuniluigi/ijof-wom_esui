## **Code Package**  
**Gifuni, L. (202x). Whispers in the oil market: exploring sentiment and uncertainty insights**, _International Journal of Forecasting_ (conditionally accepted).  

**Publication (open access).**

<a href="https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3957549"><u>Final working paper version.</u></a>

---

All results in this repository were generated on one of the following machines:

- **macOS**: MacBook Pro (14-inch, 2021)  
  - Apple M1 Pro chip  
  - 18 GB RAM  

- **Windows**: Dell Latitude 7000 Series  
  - Intel Core i5-vPro processor  
  - 16 GB RAM  

**Text Processing:** Python 3.9 with the following packages required:
``transformers``, ``pysentiment2``, ``nltk``, ``torch``, ``scikit-learn``, ``pandas``, ``numpy``, ``vaderSentiment``, ``spacy``, ``textblob``, ``lm-sentiment``.

**Econometric Analysis:** MATLAB 2023b

**MCS & ROC–AUROC Estimates:** R 4.1.1 with the following packages required:  
``R.matlab``, ``MCS``, ``xtable``.

> **Note:** Estimating a 5-variable SVB-VAR model takes approximately 4 hours on either machine.

---

## **Replication Code**  
- Folder **data**  
  - Contains the original time-series data in their raw formats.

- Folder **tables**
  - Reproduce results of Table 3, Table 4, Table 5, Table 6 and Table 7 from the main manuscript.  
  - Each subfolder contains the estimation data and LaTeX source.  

- Folder **figures**
  - Reproduce results of Figure 1, Figure 2, Figure 3, Figure 4, Figure 5 and Figure 6 from the main manuscript.
  - Each subfolder contains the estimation data

- Folder **appendix**  
  - Code for generating the tables and figures in the online appendix.
