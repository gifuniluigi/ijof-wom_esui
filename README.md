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

> **table execution checklist:** (recommended order)

### Table 3

The `Table 3` folder contains two subfolders:

- `4-SVBVAR/` — `Get_Table3_4SVBVAR.m` generates results reported in **line 1** of Table 3.  
- `5-SVBVAR/` — `Get_Table3.m` generates results for **lines 2–15** (_Sentiment_ count through _BERT_).

1. In folder `4-SVBVAR` run `Get_Table3_4SVBVAR.m` and save the output as `4SVBVAR0`
2. Move `4SVBVAR0` into `tables/Table 3/5-SVBVAR/functions/`
3. In `tables/Table 3/5-SVBVAR/` run `Get_Table3.m` one text index at a time. For example, by default line 37 in `Get_Table3.m` is Sentiment = SentVar(2:end,1); which uses the first text index. Run and save the result as `4SVBVAR1`. Then, change line 37 to Sentiment = SentVar(2:end,2); run again and save as `4SVBVAR2`. Continue incrementing the index and saving results up to `4SVBVAR14`. See the comment block on lines 39–52 in `Get_Table3.m` for the mapping of index.
4. After running all indices, run `Print_Table3_tex.m` in `tables/Table 3/5-SVBVAR/` to print Table 3 in LaTeX format.

### Table 4

The `Table 3` folder contains two .m files:

- `Get_Table4_5SVBVAR.m` generates the results reported in Table 4. _Note you must select the sentiment combination for each estimation on line 38 (see comments on lines 40-48)_  
- `Print_Table4_5SVBVAR.m` prints the results in LaTeX format (one table row per combination).

Example workflow.
- To produce Line 1 of Table 4 (FT + TR, VADER):
1. In `Get_Table4_5SVBVAR.m`, on line 38, set "Sentiment = SentVar(2:end,1);". This selects the VADER index constructed from Financial Times and Thomson Reuters text data.
2. Run `Get_Table4_5SVBVAR.m`. The results will be saved as `5SVBVARFtTrVader.mat`
3. In `Print_Table4_5SVBVAR.m`, edit line 8 to "load 5SVBVARFtTrVader". Then run `Print_Table4_5SVBVAR.m` to obtain Line 1 of Table 4 in LaTeX format.

- To produce Line 2 of Table 4 (FT + IND, VADER):
1. In `Get_Table4_5SVBVAR.m`, on line 38, set "Sentiment = SentVar(2:end,2);". This selects the VADER index constructed from Financial Times and Independent text data.
2. Run `Get_Table4_5SVBVAR.m`. The results will be saved as `5SVBVARFtIndVader.mat`
3. In `Print_Table4_5SVBVAR.m`, edit line 8 to "load 5SVBVARFtIndVader". Then run `Print_Table4_5SVBVAR.m` to obtain Line 2 of Table 4 in LaTeX format.

Repeat the same procedure for the remaining lines of Table 4, selecting the appropriate column in SentVar on line 38, then loading the corresponding .m file in `Print_Table4_5SVBVAR.m`.



### Table 5

1. In `tables/Table 5/PanelA_mspe` each subfolder is named as the index under investigation and contains two `.m` files:
  - a generator `.m` file to produce results using that index,
  - a printer `.m` file to produce the single-line LaTeX output.
    Run the generator, then the printer, for each index folder. 
2. In `tables/Table 5/PanelB_mspe` run:
  - `GetMCS.m` to generate MCS results,
  - `MCS_file.R` in R to print the MCS results.

### Table 6

1. In `tables/Table 6/` run `Get_Table6.m` to generate all result files both with and without the TOSI index. The script creates the SVBVARcmb*.mat files used by the printing scripts (`Print_Table6_panelA.m` and `Print_Table6_panelB.m`).
2. To print Panel A, edit `tables/Table 6/Print_Table6_panelA.m`. Specifically, for each line of Table 6 you must set the two .mat file names on lines 11 and 12 to the appropriate pair. Use the following mapping:
   - **Line 1 (Table 6):** set line 11 -> `SVBVARcmb1.mat` and line 12 -> `SVBVARcmb2.mat`
       - comparison: AR model on oil price lags  vs  2-variable SVBVAR with oil prices + TOSI
   - **Line 2 (Table 6):** set line 11 -> `SVBVARcmb3.mat` and line 12 -> `SVBVARcmb4.mat`
       - comparison: 2-variable SVBVAR (oil prices + global crude oil production)  vs  3-variable SVBVAR where TOSI is added
   - **Line 3 (Table 6):** set line 11 -> `SVBVARcmb5.mat` and line 12 -> `SVBVARcmb6.mat`
       - comparison: 3-variable SVBVAR (oil prices + global crude oil production + world industrial production)  vs  4-variable SVBVAR where TOSI is added
   - **Line 4 (Table 6):** set line 11 -> `SVBVARcmb7.mat` and line 12 -> `SVBVARcmb8.mat`
       - comparison: 4-variable SVBVAR (oil prices + global crude oil production + world industrial production + oil inventories)  vs  5-variable SVBVAR where TOSI is added
3. The same logic applies for Panel B. For `Print_Table6_panelB.m` use the same .mat pairs to print the corresponding table lines:
   - `SVBVARcmb1` & `SVBVARcmb2` -> **Line 1 of Table 6, Panel B**
   - `SVBVARcmb3` & `SVBVARcmb4` -> **Line 2 of Table 6, Panel B**
   - `SVBVARcmb5` & `SVBVARcmb6` -> **Line 3 of Table 6, Panel B**
   - `SVBVARcmb7` & `SVBVARcmb8` -> **Line 4 of Table 6, Panel B**

### Table 7

1. In `tables/Table 7/` run `auroc.main.r`. This single R script runs the AUROC analysis and prints the results reported in Table 7.

---

_Note:_ The estimation routines use Bayesian sampling to draw from posterior distributions. As a result, small numerical differences between runs on different machines are expected. Such variation typically affects only very small digits and does not alter the substantive conclusions reported in the paper.

