# Retail Sales & Profitability Analysis

**Status:** In progress  
**Tools:** Power BI Desktop, Power Query, DAX, SQL Server (planned)

An end-to-end business intelligence project using the Global Electronics Retailer sample dataset. The project will examine retail sales patterns, product mix, and estimated gross profitability, then present validated insights in an interactive Power BI report.

> **Metric limitation:** The source has product list prices and unit costs but no transaction-level selling price or discount. Any value calculated from list price is labeled an estimate, not actual realized revenue or profit.

## Business questions

- How do list-price sales estimates and estimated gross profit change over time?
- Which products and categories contribute most to estimated sales and profit?
- How do online and physical-store channels compare?
- Which markets or product groups warrant further investigation?
- What actions could improve profitable growth, given the limitations of the available fields?

## Dataset

- **Source:** [Maven Analytics — Global Electronics Retailer](https://mavenanalytics.io/data-playground/global-electronics-retailer)
- **Sales period:** 2016-01-01 to 2021-02-20
- **Files:** Sales, Customers, Products, Stores, Exchange_Rates, Data_Dictionary

The provided ZIP has been inspected. Initial profile: Sales has 62,884 rows, Customers 15,266, Products 2,517, Stores 67, Exchange_Rates 11,215, and Data_Dictionary 37. See [the data quality report](docs/data_quality_report.md) and [data dictionary](docs/data_dictionary.md).

The archive is not committed to this repository. Keep local copies of source data and confirm applicable terms before redistributing files.

## Planned report pages

- **Executive Overview:** list-price sales estimate, estimated gross profit, estimated gross margin, quantity, order count, and monthly trends.
- **Product & Category Analysis:** performance by category, subcategory, brand, and product.
- **Channel & Market Analysis:** Online versus physical stores, country/state, and trends where supported by the data.

## Repository structure

```text
retail-sales-profitability-analysis/
├── README.md
├── .gitignore
├── data/README.md
├── docs/
│   ├── data_dictionary.md
│   └── data_quality_report.md
├── powerbi/
│   ├── README.md
│   └── dax_measures.md
├── screenshots/README.md
└── sql/
    ├── README.md
    └── retail_analysis.sql
```

## Methodology

1. Profile and clean the source in Power Query.
2. Build a star-schema-style model with Sales as the fact table and customer, product, store, and date dimensions.
3. Define explicit DAX measures and reconcile them against independent totals.
4. Use SQL queries for additional analysis and validation.
5. Build an interactive Power BI report, capture genuine screenshots, and document recommendations supported by the results.

### Metric definitions and caveats

- **Estimated list-price sales (USD):** Quantity × product unit list price in USD.
- **Estimated gross profit (USD):** Quantity × (unit list price − unit cost).
- **Estimated gross margin:** Estimated gross profit ÷ estimated list-price sales.

These measures are analytical proxies because transaction selling prices and discounts are not provided. Exchange-rate conversion will not be used until the rate direction is confirmed.

## Current status

- [x] Create public GitHub repository and project structure
- [x] Inspect the supplied archive and profile row counts, fields, keys, and missing values
- [x] Document initial data quality checks and caveats
- [x] Add starter DAX measures and SQL analysis queries
- [ ] Import CSVs into Power BI Desktop and clean data types
- [ ] Build and validate the model and measures
- [ ] Create report pages and validate interactions
- [ ] Add genuine dashboard screenshots and findings
- [ ] Finalize portfolio write-up and recommendations

## Tools

- Power BI Desktop
- Power Query
- DAX
- SQL Server / T-SQL
- GitHub

## Author

**Shagun** — aspiring Data Analyst
