with load_fct_globepay as (
     SELECT * FROM {{ref('fct_globepay')}}

),

load_dim_globepay as (
     SELECT * FROM {{ref('dim_globepay')}}
),

join_tables as (
    SELECT 
        load_fct_globepay.*,
        load_dim_globepay.* EXCLUDE (GLOBEPAY_ACCEPTANCE_ID)
    FROM load_fct_globepay 
    LEFT JOIN load_dim_globepay  
    ON load_fct_globepay.GLOBEPAY_ACCEPTANCE_ID = load_dim_globepay.GLOBEPAY_ACCEPTANCE_ID 
),

acceptance_rate_cte as (
    SELECT
    DATE_TRUNC(day,GLOBEPAY_ACCEPTANCE_AT)::date as GLOBEPAY_ACCEPTANCE_DATE,
    COUNT_IF(GLOBEPAY_ACCEPTANCE_STATE = 'ACCEPTED') as count_acceptance,
    COUNT(*) as total_counts_acceptance,
    count_acceptance/ total_counts_acceptance as daily_acceptance_rate
    FROM join_tables
    GROUP BY GLOBEPAY_ACCEPTANCE_DATE
),
country_above_cte as (
    SELECT
    GLOBEPAY_COUNTRY,
    SUM(globepay_acceptance_amount_usd) as total_amount_usd,
    FROM join_tables
    where GLOBEPAY_ACCEPTANCE_STATE = 'DECLINED' 
    GROUP BY GLOBEPAY_COUNTRY
    HAVING total_amount_usd > 25000000
),

missing_transaction_cte as (
SELECT
DATE_TRUNC(day,GLOBEPAY_ACCEPTANCE_AT)::date GLOBEPAY_ACCEPTANCE_DATE,
ARRAY_UNIQUE_AGG(IFF(not is_globepay_chargeback, globepay_acceptance_id, null)) as daily_no_chaargeback_transaction,
FROM join_tables
GROUP BY ALL)

SELECT
    acceptance_rate_cte.GLOBEPAY_ACCEPTANCE_DATE,
    acceptance_rate_cte.daily_acceptance_rate,
    ARRAY_UNIQUE_AGG(GLOBEPAY_COUNTRY) as declined_acceptance_above_25M_country,
    daily_no_chaargeback_transaction
    FROM acceptance_rate_cte 
LEFT JOIN missing_transaction_cte
ON acceptance_rate_cte.GLOBEPAY_ACCEPTANCE_DATE = missing_transaction_cte.GLOBEPAY_ACCEPTANCE_DATE
LEFT JOIN country_above_cte 
GROUP BY ALL
