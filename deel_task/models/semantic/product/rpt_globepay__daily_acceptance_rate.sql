--1. What is the acceptance rate over time?
with load_fct_globepay as (
    SELECT * FROM {{ref('fct_globepay')}}
)
SELECT
--DAILY GRAIN
DATE_TRUNC(day,GLOBEPAY_ACCEPTANCE_AT)::date GLOBEPAY_ACCEPTANCE_DATE,
COUNT_IF(GLOBEPAY_ACCEPTANCE_STATE = 'ACCEPTED') as count_acceptance,
COUNT(*) total_count,
count_acceptance/total_count as daily_acceptance_rate
FROM load_fct_globepay
GROUP BY GLOBEPAY_ACCEPTANCE_DATE