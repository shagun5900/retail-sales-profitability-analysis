# Initial DAX Measures

These measures are a starting point for the model. Create them after importing the tables and confirming table/column names in Power BI. They assume a relationship from Sales[ProductKey] to Products[ProductKey] and numeric Products price/cost columns after Power Query conversion.

Because Sales does not contain transaction price or discount, the sales and profit measures below are explicitly **list-price estimates**, not actual realized revenue/profit.

```DAX
Total Quantity =
SUM ( Sales[Quantity] )

Order Count =
DISTINCTCOUNT ( Sales[Order Number] )

Order Line Count =
COUNTROWS ( Sales )

Estimated List-Price Sales USD =
SUMX (
    Sales,
    Sales[Quantity] * RELATED ( Products[Unit Price USD] )
)

Estimated Gross Profit USD =
SUMX (
    Sales,
    Sales[Quantity]
        * (
            RELATED ( Products[Unit Price USD] )
                - RELATED ( Products[Unit Cost USD] )
        )
)

Estimated Gross Margin % =
DIVIDE (
    [Estimated Gross Profit USD],
    [Estimated List-Price Sales USD]
)
```

## After creating a Date table

Mark the Date table as the model's date table and relate Date[Date] to Sales[Order Date]. Then add:

```DAX
Estimated List-Price Sales Previous Year =
CALCULATE (
    [Estimated List-Price Sales USD],
    SAMEPERIODLASTYEAR ( 'Date'[Date] )
)

Estimated List-Price Sales YoY % =
DIVIDE (
    [Estimated List-Price Sales USD]
        - [Estimated List-Price Sales Previous Year],
    [Estimated List-Price Sales Previous Year]
)
```

## Validation

- Compare total quantity with the source total of 197,757.
- Check Order Count against the source's distinct Order Number count.
- Validate a small sample manually: quantity × unit price and quantity × (unit price − unit cost).
- Confirm margin is a ratio of aggregate profit to aggregate list-price sales, not an average of row-level margin percentages.
- Label visuals with “Estimated” or “List-price” until actual transaction prices are available.
