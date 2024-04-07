--Average Debt against Debt indicators

SELECT
	indicator_code AS debt_indicator,
	indicator_name,
	ROUND(AVG(year_2006 + year_2007 + year_2008 + year_2009 + year_2010 + year_2011 + year_2012 + year_2013 + year_2014 + year_2015 + year_2016 + year_2017 + year_2018 + year_2019 + year_2020 + year_2021 + year_2022) / 1000000, 2) AS avg_debt 
FROM 
	international_debt
GROUP BY debt_indicator, indicator_name
ORDER BY avg_debt DESC
LIMIT 10;