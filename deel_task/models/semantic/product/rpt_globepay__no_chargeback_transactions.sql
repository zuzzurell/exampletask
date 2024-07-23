--Which transactions are missing chargeback data?
with load_dim_globepay as (
     SELECT * FROM {{ref('dim_globepay')}}
     where not is_globepay_chargeback 
),
load_fct_globepay as (
     SELECT * FROM {{ref('fct_globepay')}}

),

join_tables as (
    SELECT 
    load_dim_globepay.globepay_acceptance_id,
    load_fct_globepay.globepay_acceptance_event_id
    FROM load_dim_globepay 
    LEFT JOIN load_fct_globepay  
    ON load_fct_globepay.GLOBEPAY_ACCEPTANCE_ID = load_dim_globepay.GLOBEPAY_ACCEPTANCE_ID
)

SELECT * FROM join_tables