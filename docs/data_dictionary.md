# Data Dictionary

Profiled from the supplied Global Electronics Retailer CSV files. Source column names are preserved below; Power BI model names may be cleaned for readability.

## Sales.csv — 62,884 rows

| Field | Meaning | Notes |
|---|---|---|
| Order Number | Order identifier | Not unique per row; combine with Line Item for line-level key |
| Line Item | Line number within an order | No duplicate Order Number + Line Item pairs found |
| Order Date | Order date | 2016-01-01 through 2021-02-20 |
| Delivery Date | Delivery date | 49,719 nulls; do not treat null delivery dates as zero or automatically as errors |
| CustomerKey | Customer foreign key | All values matched Customers |
| StoreKey | Store/online channel foreign key | All values matched Stores; StoreKey 0 is Online |
| ProductKey | Product foreign key | All values matched Products |
| Quantity | Quantity sold | Sum in source: 197,757 |
| Currency Code | Transaction currency | USD, CAD, AUD, EUR, GBP |

## Customers.csv — 15,266 rows

| Field | Meaning | Notes |
|---|---|---|
| CustomerKey | Customer primary key | Unique in the supplied file |
| Gender | Customer gender | Categorical |
| Name | Customer name | Personal data; do not expose customer-level detail in portfolio screenshots |
| City | Customer city | Geographic attribute |
| State Code | State abbreviation | 10 nulls |
| State | State/province | Categorical |
| Zip Code | Postal code | Preserve as text to retain formatting |
| Country | Customer country | Categorical |
| Continent | Customer continent | Categorical |
| Birthday | Customer birth date | Consider excluding from report unless justified; avoid sensitive customer profiling |

## Products.csv — 2,517 rows

| Field | Meaning | Notes |
|---|---|---|
| ProductKey | Product primary key | Unique in supplied file |
| Product Name | Product name | Descriptive |
| Brand | Brand | Descriptive |
| Color | Product color | Descriptive |
| Unit Cost USD | Unit production cost in USD | Currency-formatted text in source; parse to decimal |
| Unit Price USD | Product list price in USD | Currency-formatted text in source; not necessarily actual transaction price |
| SubcategoryKey | Subcategory identifier | Validate relationships if modeled as a separate dimension |
| Subcategory | Subcategory name | Descriptive |
| CategoryKey | Category identifier | Validate relationships if modeled as a separate dimension |
| Category | Category name | Descriptive |

## Stores.csv — 67 rows

| Field | Meaning | Notes |
|---|---|---|
| StoreKey | Store primary key | Unique; keys 0–66 |
| Country | Store country | Categorical |
| State | Store state/province | Categorical |
| Square Meters | Store footprint | One null; Online store has no physical footprint |
| Open Date | Store opening date | 2005-03-04 through 2019-03-05 |
 
StoreKey 0 represents the Online channel. Keep this record; do not drop it as a missing physical store.

## Exchange_Rates.csv — 11,215 rows

| Field | Meaning | Notes |
|---|---|---|
| Date | Exchange-rate date | 2015-01-01 through 2021-02-20 |
| Currency | Currency code | USD, CAD, AUD, EUR, GBP |
| Exchange | Exchange rate relative to USD | Confirm direction from source documentation before using in currency conversion |

## Data_Dictionary.csv — 37 rows

Contains source descriptions for fields in the dataset. Keep as reference documentation; it is not a transactional fact table.

## Key modeling recommendations

- Use Sales as the fact table and Customers, Products, Stores, and a proper Date table as dimensions.
- Use a unique Date table related to Sales[Order Date]; optionally add a separate inactive/role-playing delivery-date relationship if needed.
- Exchange_Rates has a natural Date + Currency grain. Do not relate it to Sales by date alone; currency must also match. Confirm exchange-rate direction before converting values.
- Avoid importing customer Name and Birthday into the report unless a clear business need exists. Aggregated analysis is enough for this portfolio project.
