# International Debt Statistics
<center>

![IDS](https://www.worldbank.org/content/dam/photos/780x439/2023/dec/IDR2023-DataBank-780x439-12-06-2023.png)

</center>

## Overview
Over the past 50 years, the World Bank’s International Debt Statistics has become the most important and transparent source of external debt data of low- and middle-income countries. This repository contains data and analyses related to international debt statistics from 2006 to 2022.

## Why It Matters
Understanding international debt statistics is crucial for several reasons:

- **Debt Transparency**: Poor debt transparency in the past led many countries to sleepwalk into debt crises. Knowing what a country owes and to whom is essential for better debt management and sustainability.
  
- **Guiding Debt Restructuring**: Clear data can guide debt restructuring efforts to help a country get back on track toward economic stability and growth when problems arise.
  
- **Addressing Worrying Debt Levels**: Debt levels in developing economies are at worrying levels, making it more important than ever to understand and manage international debt.

## 2023 International Debt Report
The 2023 International Debt Report marks the 50th anniversary of the collection of external debt data at the World Bank. You can read the full report [here](http://wrld.bg/KNyV50Qi2pf).

## Data Source
The data used in this project is sourced from the World Bank’s International Debt Statistics database.

## Contents
- [international_debt_all.csv](international_debt_all.csv) CSV file containing international debt data with columns for country name, indicator name, and year from 2006 to 2022.
- [SQL Queries](https://github.com/malvika-mall/Analysing_International_Debt_Statistics/tree/init_commit/SQL%20Queries): Folder containing SQL scripts for analyzing international debt statistics.

## Analysis
Query 1: Total Debt Calculation
Overview:
This query calculates the total debt across all years from 2006 to 2022 for each country and expresses it in millions. It provides a summary of the overall debt trend over time.
```sql
SELECT 
    ROUND(SUM(year_2006 + year_2007 + year_2008 + year_2009 + year_2010 + year_2011 + year_2012 + year_2013 + year_2014 + year_2015 + year_2016 + year_2017 + year_2018 + year_2019 + year_2020 + year_2021 + year_2022) / 1000000, 2) AS total_debt
FROM 
    international_debt;
```
Query 2: Maximum Principal Repayments
Overview:
This query determines the maximum principal repayments made by each country, indicator code, and indicator name combination, giving insight into the highest repayment obligations.
```sql
SELECT
    country_name,
    indicator_code,
    indicator_name,
    ROUND(MAX(year_2006 + year_2007 + year_2008 + year_2009 + year_2010 + year_2011 + year_2012 + year_2013 + year_2014 + year_2015 + year_2016 + year_2017 + year_2018 + year_2019 + year_2020 + year_2021 + year_2022) / 1000000, 2) AS max_principal_repayments
FROM
    international_debt
GROUP BY
    country_name,
    indicator_code,
    indicator_name
ORDER BY 
    max_principal_repayments DESC;
```
Query 3: Interest Payments Analysis
Overview:
This part of the query computes interest payments and their change over a ten-year period for each country. It also calculates the annual growth rate of interest payments. Additionally, it categorizes the change in interest payments as Increase, Decrease, or No Change. This analysis is crucial for understanding the dynamics of debt servicing.
```sql
WITH interest_payments AS (
    SELECT 
        country_name,
        year_2013 + year_2014 + year_2015 + year_2016 + year_2017 + year_2018 + year_2019 + year_2020 + year_2021 + year_2022 AS total_interest_payments,
        (year_2022 - year_2013) AS interest_payments_change,
        CASE
            WHEN year_2013 = 0 THEN NULL
            ELSE POWER((year_2022 / year_2013), 0.1) - 1 --to calculate the CAGR of the revenues over the 10 year period power 1/10=0.1 then to normalize we substract 1
        END AS annual_growth_rate
    FROM 
        international_debt
    WHERE 
        indicator_name = 'Interest payments on external debt, long-term (INT, current US$)'
)
SELECT 
    *,
    CASE
        WHEN interest_payments_change < 0 THEN 'Decrease'
        WHEN interest_payments_change = 0 THEN 'No Change'
        ELSE 'Increase'
    END AS change_direction
FROM 
    interest_payments;
```
Query 4: Debt-Year Correlation
Overview:
This query calculates the correlation between the total debt of each country and the years from 2006 to 2022. Understanding this correlation helps in analyzing how a country's debt evolves over time and its relationship with economic conditions.
```sql
WITH total_debt AS (
    SELECT 
        country_name,
        ROUND(SUM(year_2006 + year_2007 + year_2008 + year_2009 + year_2010 + year_2011 + year_2012 + year_2013 + year_2014 + year_2015 + year_2016 + year_2017 + year_2018 + year_2019 + year_2020 + year_2021 + year_2022) / 1000000, 2) AS debt
    FROM 
        international_debt
    GROUP BY 
        country_name
)
SELECT 
    country_name,
    CORR(debt, year) AS debt_year_correlation 
FROM 
    total_debt
CROSS JOIN 
    generate_series(2006, 2022) AS year
WHERE 
    year BETWEEN 2006 AND 2022;
```
The correlation coefficient, ranging from -1 to 1, indicates the strength and direction of the linear relationship between debt and time. A positive correlation suggests that as the years progress, the total debt tends to increase, while a negative correlation implies a decrease in debt over time. A correlation close to zero indicates a weak relationship between debt and time.

Overall, analyzing the correlation between debt and time provides crucial insights into a country's fiscal health, debt management practices, and potential economic risks, thereby enabling informed decision-making and policy formulation.
## Recommendations:

1. **Debt Management:** Understanding total debt and repayment trends is crucial for effective debt management. Governments can use this information to make informed decisions on borrowing and repayment strategies.

2. **Interest Payment Analysis:** Analyzing interest payment trends and their growth rates can provide insights into a country's financial health and its ability to service its debt. Governments can use this information to assess the sustainability of their debt levels.

3. **Correlation Analysis:** Exploring the correlation between debt and time can help identify long-term patterns and potential economic factors influencing debt accumulation. This can guide policymakers in formulating sustainable fiscal policies.

## Usage
Feel free to use the provided data and analysis scripts for your own research or projects. You can modify and customize the SQL queries as needed to suit your specific requirements.

