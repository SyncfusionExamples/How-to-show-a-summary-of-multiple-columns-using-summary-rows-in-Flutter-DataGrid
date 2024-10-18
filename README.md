# How to show a summary of multiple columns using summary rows in Flutter DataTable (SfDataGrid)?.

In this article, we will show you how to create a summary of multiple columns using summary rows in [Flutter DataTable](https://www.syncfusion.com/flutter-widgets/flutter-datagrid).

Initialize the [SfDataGrid](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid-class.html) widget with all the required properties. To display the summary information in a column, set the [GridTableSummaryRow.showSummaryInRow](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/GridTableSummaryRow/showSummaryInRow.html) property to false. Additionally, to define summary columns within the GridTableSummaryRow, add the [GridSummaryColumn](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/GridSummaryColumn-class.html) to the [GridTableSummaryRow.columns](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/GridTableSummaryRow/columns.html) collection. Additionally, you can position the summary row at either the top or bottom by using the [GridTableSummaryRow.position](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/GridTableSummaryRow/position.html) property.

```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter DataGrid'),
      ),
      body: SfDataGrid(
        source: employeeDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        tableSummaryRows: [
          GridTableSummaryRow(
              showSummaryInRow: false,
              columns: [
                const GridSummaryColumn(
                    name: 'Sum',
                    columnName: 'salary',
                    summaryType: GridSummaryType.sum),
                const GridSummaryColumn(
                    name: 'Count',
                    columnName: 'id',
                    summaryType: GridSummaryType.count),
                const GridSummaryColumn(
                    name: 'Sum',
                    columnName: 'bonus',
                    summaryType: GridSummaryType.sum),
                const GridSummaryColumn(
                    name: 'AvgExperience',
                    columnName: 'experience',
                    summaryType: GridSummaryType.average),
              ],
              position: GridTableSummaryRowPosition.bottom)
        ],
        columns: <GridColumn>[
          GridColumn(
              columnName: 'id',
              label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'ID',
                  ))),
          GridColumn(
              columnName: 'bonus',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Bonus'))),
          GridColumn(
              columnName: 'experience',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Experience'))),
          GridColumn(
              columnName: 'salary',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Salary'))),
        ],
      ),
    );
  }

class EmployeeDataSource extends DataGridSource {

.... 

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    // Mapping of column names to their respective summary labels.
    final summaryLabels = {
      'id': 'Count : $summaryValue',
      'bonus': 'Sum : ${formatter.format(double.tryParse(summaryValue))}',
      'experience': 'Avg : $summaryValue',
      'salary': 'Sum : ${formatter.format(double.tryParse(summaryValue))}',
    };

    // Get the text for the summary column.
    String displayText = summaryLabels[summaryColumn?.columnName] ?? '';

    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Text(displayText),
      ),
    );
  }
}
```

You can download the example from [GitHub](https://github.com/SyncfusionExamples/How-to-show-a-summary-of-multiple-columns-using-summary-rows-in-Flutter-DataGrid).