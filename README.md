# Sales Cloud Product list UI on an LWR Site Salesforce


Here’s a **comprehensive summary of everything we discussed today from a Sales Cloud perspective**, focusing on key entities, their relationships, and practical use cases:

***

## ✅ **1. Core Sales Cloud Entities**

*   **Product2**
    *   Represents products in Salesforce.
    *   Key fields: `Name`, `ProductCode`, `Family`, `IsActive`.
    *   Used in product catalog, CPQ, and quoting.

*   **Pricebook2**
    *   Represents a price book (collection of products with prices).
    *   Types: **Standard Price Book** (mandatory) and **Custom Price Books** (for regions, tiers, channels).

*   **PricebookEntry**
    *   Junction object between **Product2** and **Pricebook2**.
    *   Fields: `Pricebook2Id`, `Product2Id`, `UnitPrice`, `IsActive`, `UseStandardPrice`.
    *   Enables **different prices for the same product** across price books.

*   **OpportunityLineItem**
    *   Links an Opportunity to a PricebookEntry.
    *   Fields: `Quantity`, `UnitPrice`, `TotalPrice`.

***

## ✅ **2. Bulk Pricing with Multiple Price Books**

*   Create **multiple Pricebook2 records** for different regions or customer tiers.
*   Example:
    *   Standard Price Book → Apple = $1.00
    *   Retail Price Book → Apple = $1.20
    *   Wholesale Price Book → Apple = $0.80
    *   APAC Price Book → Apple = $1.50
*   When creating an Opportunity, select the appropriate Price Book → OpportunityLineItems use prices from that PricebookEntry.

***

## ✅ **3. Common SOQL Queries**

*   **Get all active products**

```sql
SELECT Id, Name, ProductCode, Family FROM Product2 WHERE IsActive = TRUE
```

*   **Get all price books**

```sql
SELECT Id, Name FROM Pricebook2 WHERE IsActive = TRUE
```

*   **Get products in a specific price book**

```sql
SELECT Product2.Name, UnitPrice FROM PricebookEntry WHERE Pricebook2.Name = 'APAC Price Book'
```

*   **Get price for a product in a price book**

```sql
SELECT UnitPrice FROM PricebookEntry WHERE Product2Id = 'PRODUCT_ID' AND Pricebook2Id = 'PRICEBOOK_ID'
```

***

## ✅ **4. Advanced Topics**

*   **Multi-Currency Support**: PricebookEntry supports currency-specific pricing.
*   **CPQ Integration**: Advanced pricing rules, discounts, bundles.
*   **Bulk Operations**: Use **Bulk API** or **Batch Apex** for large-scale updates.

***

## ✅ **5. Related Design Scenarios Discussed**

*   **Store → Store\_Product → Product2**
    *   Multiselect picklist on Store (e.g., Fruits, Dry Fruits).
    *   Auto-create/delete child records for thousands of Product2 under selected families.
    *   Implemented via **Queueable/Batch Apex** for scalability.
    *   UI with **LWC** for category selection, preview counts, and sync actions.

*   **Handling Multiselect Picklists**
    *   In **Flow**: Use `Split()` function.
    *   In **Apex**: `String.split(';')`.
    *   In **LWC**: `lightning-dual-listbox`.

***

## ✅ **Interview Tips**

*   Understand **Product2 → PricebookEntry → Pricebook2 → OpportunityLineItem** relationships.
*   Explain **Standard Price Book** requirement.
*   Know **SOQL queries** for products, price books, and pricing.
*   Be ready to discuss **bulk pricing strategies** and **real-world use cases** (Retail vs Wholesale vs Region-specific pricing).
*   Mention **multi-currency** and **CPQ** for advanced scenarios.

***


 
