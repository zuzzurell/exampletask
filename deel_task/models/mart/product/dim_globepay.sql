with laod_acceptance as (
    SELECT * FROM {{ref('stg_globepay__acceptance')}}
),
laod_chargeback as (
    SELECT * FROM {{ref('stg_globepay__chargeback')}}
),

--GRAIN is the event
join_acceptance_chargeback as (
SELECT 
    acceptance.globepay_acceptance_id,
    chargeback.globepay_chargeback_source,
    acceptance.globepay_country,
    acceptance.globepay_currency,
    acceptance.globepay_acceptance_source,
    chargeback.is_globepay_chargeback,
    acceptance.is_globepay_cvv_provided,
    acceptance.globepay_acceptance_status,
    chargeback.globepay_chargeback_status,
FROM laod_acceptance  acceptance 
LEFT JOIN laod_chargeback chargeback
ON acceptance.globepay_acceptance_id = chargeback.globepay_acceptance_id
)
SELECT * FROM join_acceptance_chargeback