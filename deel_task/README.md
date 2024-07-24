# DBT Deel Project

## Preliminary Data Exploration

Preliminary data exploration queries can be found in the `analysis/explorative_analysis_globepay` folder. These queries are used to understand the structure and quality of the data.
The analysis was done on the mart layer to asses it's quality, however this should have been done on the raw layer too. Key findings from the exploration include:

- There is a perfect 1:1 match between raw tables.
- IDs are not null and unique.
- There are no null values.
- Dates do not have outliers within the 6-month range.
- There is a consistent amount of transactions over time.
- Interestingly, every country has the exact count of 905 transactions. This anomaly should be double-checked with stakeholders.
- Noteworthy is the presence of negative amounts for ID `SPm_aqm_Rrer_6jxpLvO2`, which requires further verification with stakeholders.

## Model Architecture Overview

The model architecture is structured into four distinct layers:

1. **Raw Layer**: Initial data ingestion point, divided into schemas per source GLOBEPAY.
   - **Acceptance**: Raw data related to Globepay acceptance transactions.
   - **Chargeback**: Raw data related to Globepay chargeback transactions.
2. **Staging Layer**: Preliminary data transformations to standardize and clean the data.
   - **stg_acceptance**: Staging table for acceptance transactions.
   - **stg_chargeback**: Staging table for chargeback transactions.
3. **Mart Layer**: Complex transformations and joins between staging tables, organized into schemas per domain.
   - **dim_globepay**: Dimension table with detailed information about Globepay transactions.
   - **fct_globepay**: Fact table with aggregated Globepay transaction data.
4. **Reporting/Semantic Layer**: Final step where data is prepared for BI tools, including aggregated tables and views for reporting.
   - **report_globepay**: Reporting table consolidating data for BI tools.
   - **report_globepay_XXX**: Additional reporting table for specific use cases.

![Model Architecture Overview](https://github.com/zuzzurell/deel_home_task/blob/main/deel_task/img/flow.png)

## Lineage Graphs

Lineage graphs can be checked using the following command:
![Lineage Graph](https://github.com/zuzzurell/deel_home_task/blob/main/deel_task/img/lineage.png)


```bash
dbt docs generate
dbt docs serve
```
This command generates documentation that includes lineage graphs, helping to visualize the data flow and dependencies.

## Tips Around Macros, Data Validation, and Documentation

## Macros
While there was no real need to use macros for this project, one useful macro for future use could be for conversion rates to dollars. However, it seemed unnecessary for this particular project.

You can find another example of a macro in macros/environment/. The set_schema_name macro demonstrates how to use custom schema names instead of the default DBT schema name default_schema_name.

Another useful application is setting the database based on the target profile used.


## Data Validation
- Source Freshness: Tests on source freshness could be implemented to ensure the data is up-to-date.
- Uniqueness/Not Null Tests: These tests are implemented on all relevant models in the staging and mart layers to ensure data integrity. See yml files
- Relationship Tests: Implemented to ensure referential integrity between tables.

## Documentation
All models have attached descriptions, and columns are documented. This can be checked using the following command:

```bash
dbt docs generate
dbt docs serve
```

This command generates comprehensive documentation for all models, making it easier to understand the data transformations and structures.

# Final considerations about the models:

## Acceptance Rate Over Time

The acceptance rate is defined based on the State column, which indicates the binary state of the transaction (e.g., Accepted or Declined). The time grain for this metric is not explicitly specified, but for this interpretation, we assume the card acceptance rate is on a daily basis.

## Countries with Declined Transactions Over $25M

Identify the countries where the amount of declined transactions exceeds $25 million.
This seems straigforward however adding as a coulumn in the model about acceptance rate seems not related - might have been more useful the countries with XXX milion of declined transaction on that day.

Transactions Missing Chargeback Data

To understand what constitutes "missing data":

It could mean events in the acceptance table that do not have a match in the chargeback table (though this doesn't seem to be the case since a relationship test is in place at the staging layer).
Alternatively, it could refer to transactions in the chargeback table where no chargeback-related data is generated because the transaction was not charged back.
I have followed the second interpretation and included all transactions on a daily basis that have no chargeback data. 

General Recommendations
Additional alignment with stakeholders and analysts is essential to support the reporting model effectively.
Avoid combining different use cases with significantly different grains into a single model unless the overarching reporting question necessitates it.



