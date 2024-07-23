
  create or replace   view DEEL_HOME_TEST.RAW_STAGING.stg_globepay__chargeback
  
   as (
    -- Load raw data
with load_chargeback as (
    select * 
    from DEEL_HOME_TEST.RAW.RAW_GLOBEPAY_CHARGEBACK_REPORT
)

select 
    EXTERNAL_REF as globepay_acceptance_id,
    SOURCE as globepay_chargeback_source,
    STATUS::boolean as globepay_chargeback_status,
    CHARGEBACK::boolean as is_globepay_chargeback
from load_chargeback
  );

