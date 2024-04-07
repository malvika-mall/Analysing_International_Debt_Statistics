--how the total debt of each country correlates with time over the specified period (2006 to 2022).

WITH total_debt AS (
    SELECT 
        country_name,
        ROUND(SUM(year_2006 + year_2007 + year_2008 + year_2009 + year_2010 + year_2011 + year_2012 + year_2013 + year_2014 + year_2015 + year_2016 + year_2017 + year_2018 + year_2019 + year_2020 + year_2021 + year_2022) / 1000000, 2) AS debt
    FROM international_debt
    GROUP BY country_name
)

SELECT 
    country_name,
    CORR(debt, year) AS debt_year_correlation 
FROM total_debt
CROSS JOIN generate_series(2006, 2022) AS year --to generate a series of years from 2006 to 2022. This ensures that for each country, there's a row for each year in that range.
WHERE year BETWEEN 2006 AND 2022 
GROUP BY country_name;
