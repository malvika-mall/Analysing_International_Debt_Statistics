--What is the trend in interest payments on external debt over the past decade?

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
