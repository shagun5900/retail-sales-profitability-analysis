# Initial Data Quality Report

**Dataset:** Global Electronics Retailer  
**Profile status:** Initial structural checks completed on the supplied CSV archive.  
**Important:** These checks do not establish that every business metric is semantically correct.

## File inventory

| File | Rows | Columns |
|---|---:|---:|
| Sales.csv | 62,884 | 9 |
| Customers.csv | 15,266 | 10 |
| Products.csv | 2,517 | 10 |
| Stores.csv | 67 | 5 |
| Exchange_Rates.csv | 11,215 | 3 |
| Data_Dictionary.csv | 37 | 3 |

## Checks completed

- No duplicate CustomerKey values in Customers.
- No duplicate ProductKey values in Products.
- No duplicate StoreKey values in Stores.
- No duplicate Sales Order Number + Line Item combinations.
- Every Sales CustomerKey matched Customers.
- Every Sales ProductKey matched Products.
- Every Sales StoreKey matched Stores.
- Sales Order Date spans 2016-01-01 to 2021-02-20.
- Sales has 49,719 missing Delivery Date values.
- Customers has 10 missing State Code values.
- Stores has one missing Square Meters value; the Online store has no physical footprint.

## Modeling and interpretation cautions

1. **List price is not necessarily realized sales revenue.** Sales.csv contains quantity and currency code but no transaction unit price or discount. A calculation using Products[Unit Price USD] is an estimated list-price sales value, not verified actual revenue.
2. **Gross profit is estimated at list price.** Quantity × (list price − unit cost) is an analytical proxy, not audited realized profit.
3. **Currency conversion requires care.** Exchange_Rates contains date, currency, and rate, but conversion direction must be confirmed before applying it. Use USD list-price measures consistently at first.
4. **Missing delivery dates need context.** They may represent orders without recorded delivery information. Do not impute dates without evidence.
5. **Online is a valid channel.** Stores[StoreKey] = 0 is the Online record, not an unmatched key.
6. **Protect customer privacy.** Keep names and birthdays out of screenshots and aggregate results at appropriate levels.

## Next checks

- Validate data types and currency parsing in Power Query.
- Check that every Order Date has a matching Date table row.
- Confirm Products[Unit Cost USD] ≤ Products[Unit Price USD] or document exceptions.
- Reconcile the first Power BI measures against independent totals.
- Confirm source documentation before currency conversion.
