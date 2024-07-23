-- Check for missing values in fact table
SELECT 
    COUNT(*) AS total_rows,
    COUNT(GLOBEPAY_ACCEPTANCE_ID) AS non_null_acceptance_id,
    COUNT(GLOBEPAY_ACCEPTANCE_AMOUNT) AS non_null_acceptance_amount,
    COUNT(GLOBEPAY_ACCEPTANCE_AT) AS non_null_acceptance_at,
    COUNT(GLOBEPAY_ACCEPTANCE_STATE) AS non_null_acceptance_state
FROM {{ ref('fct_globepay') }};

-- Check for missing values in dimension table
SELECT 
    COUNT(*) AS total_rows,
    COUNT(GLOBEPAY_ACCEPTANCE_ID) AS non_null_acceptance_id,
    COUNT(is_globepay_chargeback) AS non_null_is_chargeback,
    COUNT(GLOBEPAY_COUNTRY) AS non_null_country,
    COUNT(GLOBEPAY_CURRENCY) AS non_null_currency
FROM {{ ref('dim_globepay') }};

