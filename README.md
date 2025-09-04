## **Code Package**  
**Gifuni, L. (202x). Whispers in the oil market: exploring sentiment and uncertainty insights**, _International Journal of Forecasting_ (conditionally accepted).  

**Publication (open access).**

<a href="https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3957549"><u>Final working paper version.</u></a>

<a href="https://www.eia.gov/finance/markets/reports_presentations/2025/Gifuni_EIAWS_2025.pdf"><u>Slides.</u></a>

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

## **Replication Code and Instructions**  
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

---

> **Important:** Run MATLAB scripts from within MATLAB (set the current folder to the script folder or add it to the MATLAB path). Run R scripts with `Rscript` or in an R environment from the folder containing the script.

### Table 3

The `Table 3` folder contains two subfolders:

- `4-SVBVAR/` — `Get_Table3_4SVBVAR.m` generates results reported in **line 1** of Table 3.  
- `5-SVBVAR/` — `Get_Table3.m` generates results for **lines 2–15** (_Sentiment_ count through _BERT_).

1. In folder `4-SVBVAR` run `Get_Table3_4SVBVAR.m` and save the output as `4SVBVAR0`
2. Move `4SVBVAR0` into `tables/Table 3/5-SVBVAR/functions/`
3. In `tables/Table 3/5-SVBVAR/` run `Get_Table3.m` one text index at a time. For example, by default line 37 in `Get_Table3.m` is Sentiment = SentVar(2:end,1); which uses the first text index. Run and save the result as `4SVBVAR1`. Then, change line 37 to Sentiment = SentVar(2:end,2); run again and save as `4SVBVAR2`. Continue incrementing the index and saving results up to `4SVBVAR14`. See the comment block on lines 39–52 in `Get_Table3.m` for the mapping of index.
4. After running all indices, run `Print_Table3_tex.m` in `tables/Table 3/5-SVBVAR/` to print Table 3 in LaTeX format.



