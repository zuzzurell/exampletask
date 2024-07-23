# DBT Deel Project

## Preliminary Data Exploration

Preliminary data exploration queries can be found in the `analysis` folder. These queries are used to understand the structure and quality of the raw data before transforming it. Key findings from the exploration include:

- There is a perfect 1:1 match between raw tables.
- IDs are not null and unique.
- There are no null values.
- Dates do not have outliers within the 6-month range.
- There is a consistent amount of transactions over time.
- Interestingly, every country has the exact count of 905 transactions. This anomaly should be double-checked with stakeholders.
- Noteworthy is the presence of negative amounts for ID `SPm_aqm_Rrer_6jxpLvO2`, which requires further verification with stakeholders.

## Model Architecture Overview

The model architecture is structured into four distinct layers:

1. **Raw Layer**: Initial data ingestion point, divided into schemas per source.
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

```bash
dbt docs generate
dbt docs serve
```
This command generates documentation that includes lineage graphs, helping to visualize the data flow and dependencies.

Tips Around Macros, Data Validation, and Documentation
Macros
While there was no real need to use macros for this project, one useful macro for future use could be for conversion rates to dollars. However, it seemed unnecessary for this particular project.

Data Validation
Source Freshness: Tests on source freshness could be implemented to ensure the data is up-to-date.
Uniqueness/Not Null Tests: These tests are implemented on all relevant models in the staging and mart layers to ensure data integrity. See yml files
Relationship Tests: Implemented to ensure referential integrity between tables.
Documentation
All models have attached descriptions, and columns are documented. This can be checked using the following command:

```bash
dbt docs generate
dbt docs serve
```

This command generates comprehensive documentation for all models, making it easier to understand the data transformations and structures.


