
  create or replace   view DEEL_HOME_TEST.RAW_STAGING.stg_globepay__acceptance
  
   as (
    -- Load raw data
with load_acceptance as (
    select * 
    from DEEL_HOME_TEST.RAW.RAW_GLOBEPAY_ACCEPTANCE_REPORT
)

select 
    AMOUNT::number as globepay_acceptance_amount,
    COUNTRY as globepay_country,
    CURRENCY as globepay_currency,
    CVV_PROVIDED::boolean as is_globepay_cvv_provided,
    DATE_TIME::timestamp as globepay_acceptance_at,
    EXTERNAL_REF as globepay_acceptance_id,
    TRY_PARSE_JSON(RATES)as globepay_acceptance_rates,
    REF as globepay_acceptance_event_id,
    SOURCE as globepay_acceptance_source,
    STATE as globepay_acceptance_state,
    STATUS as globepay_acceptance_status
from load_acceptance
  );

