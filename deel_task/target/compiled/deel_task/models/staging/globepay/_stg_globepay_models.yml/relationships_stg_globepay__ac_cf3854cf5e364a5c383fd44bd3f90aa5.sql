
    
    

with child as (
    select globepay_acceptance_id as from_field
    from DEEL_HOME_TEST.RAW_STAGING.stg_globepay__acceptance
    where globepay_acceptance_id is not null
),

parent as (
    select globepay_acceptance_id as to_field
    from DEEL_HOME_TEST.RAW_STAGING.stg_globepay__chargeback
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


