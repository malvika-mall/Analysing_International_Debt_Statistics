--top 10 countries with maximum debt

SELECT
    country_name,
    MAX(debt) AS maximum_debt
FROM international_debt
GROUP BY country_name
ORDER BY maximum_debt DESC
LIMIT 10;