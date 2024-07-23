
  create or replace   view DEEL_HOME_TEST.RAW_MART.fct_globepay
  
   as (
    with laod_acceptance as (
    SELECT * FROM DEEL_HOME_TEST.RAW_STAGING.stg_globepay__acceptance
),
laod_chargeback as (
    SELECT * FROM DEEL_HOME_TEST.RAW_STAGING.stg_globepay__chargeback
),

--GRAIN is the event
join_acceptance_chargeback as (
SELECT 
    acceptance.globepay_acceptance_id,
    acceptance.globepay_acceptance_event_id,
    acceptance.globepay_acceptance_amount,
    acceptance.globepay_acceptance_at,
    acceptance.globepay_acceptance_state,
    --Getting the correct rate for country amounts
    case
        when (acceptance.globepay_acceptance_rates)::object[acceptance.globepay_currency] is not null
        then (acceptance.globepay_acceptance_rates)::object[acceptance.globepay_currency]::string::float
        else null
    end as country_rate_to_usd,
    acceptance.globepay_acceptance_amount/country_rate_to_usd as globepay_acceptance_amount_usd
FROM laod_acceptance  acceptance 
LEFT JOIN laod_chargeback chargeback
ON acceptance.globepay_acceptance_id = chargeback.globepay_acceptance_id
)
SELECT * FROM join_acceptance_chargeback
  );

