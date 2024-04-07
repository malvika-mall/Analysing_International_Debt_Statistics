--Top 5 Countries with highest debt

SELECT 
    country_name, 
    ROUND(SUM(year_2006 + year_2007 + year_2008 + year_2009 + year_2010 + year_2011 + year_2012 + year_2013 + year_2014 + year_2015 + year_2016 + year_2017 + year_2018 + year_2019 + year_2020 + year_2021 + year_2022) / 1000000, 2) AS total_debt
FROM international_debt
GROUP BY country_name
ORDER BY total_debt DESC
LIMIT 5;

---'China', 'Brazil', 'South Asia', 'Russian Federation'