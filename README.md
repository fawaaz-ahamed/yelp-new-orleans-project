# Yelp New Orleans Project

## Research question

Where can someone find the best Cajun/Creole, seafood, and Southern restaurants in New Orleans, and how does the answer change after adjusting for reviewer behavior?

## Executive summary

This project analyzes Yelp restaurants and reviews in New Orleans. It focuses on Cajun/Creole, seafood, and Southern restaurants and compares restaurant ratings, reviewer-adjusted scores, category patterns, and geographic concentration.

The analysis includes 648 selected restaurants and 248,426 reviews. The final report contains the top 10 restaurants, tables, charts, maps, conclusions, limitations, and details about the data-processing methods.

## View the complete report
[Open the rendered HTML report](https://fawaaz-ahamed.github.io/yelp-new-orleans-project/yelp_new_orleans.html)

## Main findings

- Reviewer adjustment changed several rankings substantially. Bonafried moved from raw rank 18 to adjusted rank 2, while Meauxbar moved from rank 40 to rank 8.
- ZCTAs were the clearest geographic system because they assigned all 648 restaurants to 24 areas. Census tracts assigned 632 restaurants to 108 areas and left 16 restaurants unmatched.
- Southern restaurants had the highest average reviewer-adjusted score, followed by seafood and Cajun/Creole restaurants.

## Visualizations

The complete report includes the final tables, charts, and maps. Key figures are also available here:

- [Top 10 restaurant map](figures/top10_restaurants_by_zcta.png)
- [Reviewer-adjusted category scores](figures/category_adjusted_scores.png)
- [Reviewer-adjusted scores by ZCTA](figures/zcta_reviewer_adjusted_scores.png)

## Files and folders

- `R/` contains the R scripts for importing data, filtering reviews, and performing geographic analysis.
- `data/raw/` is where the downloaded Yelp JSON files should be placed locally.
- `data/new_orleans/` contains the cleaned RDS and CSV files used in the analysis.
- `figures/` contains the charts and maps.
- `yelp_new_orleans.qmd` is the Quarto source file.
- `yelp_new_orleans.html` is the rendered final report.
- `README.md` is the project landing page.

## Downloading and reproducing the project

1. Download the Yelp Academic Dataset from the Yelp dataset website.
2. Extract the downloaded archive.
3. Place the business and review JSON files inside `data/raw/`.
4. Open `yelp-new-orleans-project.Rproj` in RStudio.
5. Run the scripts in the `R/` folder.
6. Render `yelp_new_orleans.qmd` to recreate the HTML report.

The large raw JSON files are not committed to GitHub because they are too large and are unnecessary for viewing the completed results. They are excluded through `.gitignore`.

## Source code

- [Business import code](R/import.R)
- [Review import code](R/reviews_import.R)
- [Geographic analysis code](R/geographic_analysis.R)
- [Quarto report source](yelp_new_orleans.qmd)
- [Processed data files](data/new_orleans/)
- [Figures and maps](figures/)
