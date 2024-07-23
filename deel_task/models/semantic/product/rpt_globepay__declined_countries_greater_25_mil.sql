--2. List the countries where the amount of declined transactions went over $25M
with load_fct_globepay as (
     SELECT * FROM {{ref('fct_globepay')}}
     where FCT_GLOBEPAY.GLOBEPAY_ACCEPTANCE_STATE = 'DECLINED'

),

load_dim_globepay as (
     SELECT * FROM {{ref('dim_globepay')}}
),

join_tables as (
    SELECT *  
    FROM load_fct_globepay 
    LEFT JOIN load_dim_globepay  
    ON load_fct_globepay.GLOBEPAY_ACCEPTANCE_ID = load_dim_globepay.GLOBEPAY_ACCEPTANCE_ID
)

SELECT 
GLOBEPAY_COUNTRY,
SUM(GLOBEPAY_ACCEPTANCE_AMOUNT_USD) total_amount
FROM join_tables
GROUP BY 1
--Over 25 millions
HAVING total_amount > 25000000