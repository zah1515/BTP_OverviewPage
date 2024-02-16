namespace OverView;


entity Expenses  {
    key ID : String(10);
    category: String @title: 'Category';
    amount: Decimal(9,2) @title: 'Amount';
    currency: String(10) @title: 'Currency';
    postingDate: DateTime @title: 'Posting Date'
}

@Aggregation.ApplySupported.PropertyRestrictions: true
view ExpensesAnalytics as select from Expenses {
  key ID,
  @Analytics.Dimension: true
  category,
  @Analytics.Measure: true
  @Aggregation.default: #SUM
  amount,
  @Analytics.Dimension: true
  currency
};

