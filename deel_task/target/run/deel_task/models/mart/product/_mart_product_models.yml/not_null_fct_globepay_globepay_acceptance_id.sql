select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select globepay_acceptance_id
from DEEL_HOME_TEST.RAW_MART.fct_globepay
where globepay_acceptance_id is null



      
    ) dbt_internal_test