-- Load raw data
with load_chargeback as (
    select * 
    from {{ source('RAW_GLOBEPAY', 'RAW_GLOBEPAY_CHARGEBACK_REPORT') }}
)

select 
    EXTERNAL_REF as globepay_acceptance_id,
    SOURCE as globepay_chargeback_source,
    STATUS::boolean as globepay_chargeback_status,
    CHARGEBACK::boolean as is_globepay_chargeback
from load_chargeback
