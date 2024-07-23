select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    globepay_acceptance_id as unique_field,
    count(*) as n_records

from DEEL_HOME_TEST.RAW_STAGING.stg_globepay_acceptance
where globepay_acceptance_id is not null
group by globepay_acceptance_id
having count(*) > 1



      
    ) dbt_internal_test