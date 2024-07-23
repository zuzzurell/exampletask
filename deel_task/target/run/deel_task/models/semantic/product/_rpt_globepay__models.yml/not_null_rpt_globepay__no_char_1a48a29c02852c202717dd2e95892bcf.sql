select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select globepay_acceptance_id
from DEEL_HOME_TEST.RAW.rpt_globepay__no_chargeback_transactions
where globepay_acceptance_id is null



      
    ) dbt_internal_test