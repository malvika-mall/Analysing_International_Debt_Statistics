-- Find highest amount of principal repayments

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
ORDER BY max_principal_repayments DESC;

/* "country_name"	"indicator_code"	"indicator_name"
"China"	"NY.GNP.MKTP.CD"	"GNI (current US$)"
"Latin America & Caribbean (excluding high income)"	"NY.GNP.MKTP.CD"	"GNI (current US$)"
"China"	"FI.RES.TOTL.CD"	"Total reserves (includes gold, current US$)"
"South Asia"	"NY.GNP.MKTP.CD"	"GNI (current US$)"
"China"	"BX.GSR.TOTL.CD"	"Exports of goods, services and primary income (current US$)"
*/
