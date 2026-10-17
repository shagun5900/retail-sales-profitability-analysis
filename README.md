# Retail Sales & Profitability Analysis

**Status:** In progress  
**Tools:** Power BI Desktop, Power Query, DAX, SQL (planned)

An end-to-end business intelligence project investigating retail sales performance and profitability. The goal is to turn transaction data into validated KPIs, interactive reporting, and practical recommendations for business stakeholders.

> **Important:** This repository is a project scaffold. Findings, screenshots, and final KPI values will be added only after the dataset has been loaded, analyzed, and validated.

## Business questions

- How do sales and profit change over time?
- Which products and categories contribute most to revenue and profit?
- Which markets or stores perform strongly or weakly?
- How do online and in-store sales compare, where channel data supports the analysis?
- What actions could improve profitable growth?

## Planned workflow

1. **Data acquisition** — document the dataset source, license/terms, tables, and coverage.
2. **Data quality** — inspect data types, missing values, duplicate keys, and relationships.
3. **Transformation** — clean and shape data in Power Query; document material decisions.
4. **Data model** — build and validate a suitable model, preferably a star schema where the source supports it.
5. **Measures** — implement and validate sales, profit, margin, order count, and time-intelligence measures against the actual schema.
6. **Analysis** — investigate trends, product performance, store/country performance, and profitability drivers supported by the data.
7. **Dashboard** — build an interactive Power BI report with an executive overview and focused analysis pages.
8. **Communication** — publish screenshots, methodology, verified findings, limitations, and recommendations.

## Planned report pages

- **Executive Overview:** headline KPIs and sales trends.
- **Product Analysis:** category and product comparisons.
- **Store & Time Analysis:** geography/channel comparisons and trends supported by the source fields.

The final report design will follow the fields available in the downloaded dataset rather than assuming every dimension exists.

## Repository structure

```text
retail-sales-profitability-analysis/
├── README.md
├── data/
│   └── README.md
├── docs/
│   └── data_dictionary.md
├── powerbi/
│   └── README.md
├── screenshots/
│   └── README.md
└── sql/
    └── README.md
```

## Dataset

We plan to use the **Global Electronics Retailer** sample dataset from Maven Analytics.

- [Dataset page](https://mavenanalytics.io/data-playground/global-electronics-retailer)
- The source describes transactional data for a fictional global electronics retailer, with multiple tables and time-series analysis opportunities. [Dataset details](https://mavenanalytics.io/data-playground/global-electronics-retailer)

Before analysis, the exact downloaded files, fields, date coverage, row counts, and applicable reuse terms will be checked and documented. The source page identifies the dataset license as Public Domain. Dataset files will still be added only after verifying that the downloaded files correspond to this source.

## Tools

- **Power BI Desktop** — report authoring and data modeling
- **Power Query** — data preparation
- **DAX** — measures and analytical calculations
- **SQL** — exploratory analysis and validation, once the source format/schema is confirmed
- **GitHub** — versioned documentation and project assets

## Quality checks

- Reconcile row counts and key totals to the source.
- Check primary-key uniqueness and relationship cardinality.
- Validate measures with independent calculations.
- Document assumptions and limitations.
- Do not publish unverified business findings.

## Current status

- [x] Create public repository and project scaffold
- [ ] Download and inspect the dataset
- [ ] Document source tables and fields
- [ ] Clean and validate data
- [ ] Build data model and measures
- [ ] Create Power BI report
- [ ] Add screenshots and verified findings
- [ ] Finalize portfolio documentation

## How to reproduce

Instructions will be added after the actual data files and model are confirmed. For now, obtain the dataset from the source above and retain the original files locally.

## Author

**Shagun** — aspiring Data Analyst
