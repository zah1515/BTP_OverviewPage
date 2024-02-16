using OverView as pg from '../db/service';


service myservice {
    entity Expenses as projection on pg.Expenses;
    view ExpensesAnalytics as select from pg.ExpensesAnalytics;

    annotate ExpensesAnalytics with @UI.Chart #ExpensesAnalytics: {
        ChartType          : #Donut,
        Measures           : [amount],
        MeasureAttributes  : [{
            Measure: amount,
            Role   : #Axis1
        }],
        Dimensions         : [category],
        DimensionAttributes: [{
            Dimension: category,
            Role     : #Category
        }]
    };

    annotate myservice.Expenses with @(UI: {
        LineItem #ExpensesAnalytics : [ 
            { 
                $Type : 'UI.DataField',
                Criticality : #Positive,
                Value: ID  
            },
            { 
                $Type : 'UI.DataField',
                Criticality : #Positive,
                Value: category,
                ![@UI.Importance] : #High
            },
            { 
                Value: amount }, 
        ],
    });
}
