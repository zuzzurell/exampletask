-- Summary statistics for numerical columns in fact table
SELECT 
    MIN(GLOBEPAY_ACCEPTANCE_AMOUNT) AS min_acceptance_amount,
    MAX(GLOBEPAY_ACCEPTANCE_AMOUNT) AS max_acceptance_amount,
    AVG(GLOBEPAY_ACCEPTANCE_AMOUNT) AS avg_acceptance_amount,
    SUM(GLOBEPAY_ACCEPTANCE_AMOUNT) AS total_acceptance_amount
FROM {{ ref('fct_globepay') }};

--Summary on date  min and max
SELECT 
    MIN(globepay_acceptance_at) AS min_globepay_acceptance_at,
    MAX(globepay_acceptance_at) AS max_globepay_acceptance_at,
FROM {{ ref('fct_globepay') }};

-- Monthly transaction count in fact table
SELECT 
    DATE_TRUNC('month', GLOBEPAY_ACCEPTANCE_AT) AS acceptance_month,
    COUNT(*) AS transaction_count
FROM {{ ref('fct_globepay') }}
GROUP BY acceptance_month
ORDER BY acceptance_month;

-- Distribution of acceptance states in fact table
SELECT 
    GLOBEPAY_ACCEPTANCE_STATE,
    COUNT(*) AS count
FROM {{ ref('fct_globepay') }}
GROUP BY GLOBEPAY_ACCEPTANCE_STATE
ORDER BY count DESC;

-- Distribution of countries in dimension table
SELECT 
    GLOBEPAY_COUNTRY,
    COUNT(*) AS count
FROM {{ ref('dim_globepay') }}
GROUP BY GLOBEPAY_COUNTRY
ORDER BY count DESC;