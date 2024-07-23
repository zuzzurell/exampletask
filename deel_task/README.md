# DBT Deel Project

## Model Architecture Overview

The model architecture is structured into four distinct layers:

1. **Raw Layer**
2. **Staging Layer**
3. **Mart Layer**
4. **Reporting/Semantic Layer**

Each layer serves a specific purpose in the data transformation process, ultimately providing data to BI tools for analysis and reporting.

---

### 1. Raw Layer

The Raw Layer consists of the initial data ingestion point where data is imported into the system. The data is divided into schemas per source.

- **G.Acceptance**: Raw data related to Globepay acceptance transactions.
- **G.Chargeback**: Raw data related to Globepay chargeback transactions.

### 2. Staging Layer

In the Staging Layer, the raw data undergoes preliminary transformations to standardize and clean the data. Each source schema is processed individually.

- **stg_acceptance**: Staging table for acceptance transactions.
- **stg_chargeback**: Staging table for chargeback transactions.

### 3. Mart Layer

The Mart Layer involves more complex transformations and joins between staging tables. This layer organizes data into schemas per domain or data product, making it ready for analysis.

- **dim_globepay**: Dimension table containing detailed information about Globepay transactions.
- **fct_globepay**: Fact table containing aggregated Globepay transaction data.

### 4. Reporting/Semantic Layer

The Reporting/Semantic Layer is the final step where data is prepared for consumption by BI tools. This layer includes final aggregated tables and views that are tailored for reporting purposes.

- **report_globepay**: Reporting table that consolidates data for BI tools.
- **report_globepay_2**: Additional reporting table for specific use cases.

---

### Data Flow

The data flows from the Raw Layer through the Staging and Mart Layers to the Reporting/Semantic Layer, with each layer performing specific transformations and aggregations. The final data is then consumed by BI tools for analysis and reporting.

![Model Architecture Overview](https://github.com/zuzzurell/deel_home_task/blob/main/deel_task/img/flow.png)
