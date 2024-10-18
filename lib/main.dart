import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MyApp());
}

/// The application that contains datagrid on it.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syncfusion DataGrid Demo',
      theme: ThemeData(useMaterial3: false),
      home: const MyHomePage(),
    );
  }
}

/// The home page of the application which hosts the datagrid.
class MyHomePage extends StatefulWidget {
  /// Creates the home page.
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
  }

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

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 5000, 5, 20000),
      Employee(10002, 7000, 8, 30000),
      Employee(10003, 4000, 3, 15000),
      Employee(10004, 3000, 4, 15000),
      Employee(10005, 6000, 6, 15000),
      Employee(10006, 5000, 5, 15000),
      Employee(10007, 2000, 2, 15000),
      Employee(10008, 3000, 3, 15000),
      Employee(10009, 4000, 4, 15000),
      Employee(10010, 4500, 5, 15000),
      Employee(10011, 5500, 7, 22000),
      Employee(10012, 6000, 6, 24000),
      Employee(10013, 7500, 9, 35000),
      Employee(10014, 3000, 2, 13000),
      Employee(10015, 9000, 10, 40000),
      Employee(10016, 8000, 9, 38000),
      Employee(10017, 3500, 4, 16000),
      Employee(10018, 4700, 5, 17000),
      Employee(10019, 5200, 5, 19000),
      Employee(10020, 4100, 3, 14000),
    ];
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.bonus, this.experience, this.salary);

  /// Id of an employee.
  final int id;

  /// Bonus of an employee.
  final int bonus;

  /// Experience of an employee.
  final int experience;

  /// Salary of an employee.
  final int salary;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<int>(columnName: 'bonus', value: e.bonus),
              DataGridCell<int>(columnName: 'experience', value: e.experience),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  // Define the formatter with the appropriate currency symbol.
  final formatter = NumberFormat.currency(symbol: '\$');

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          (e.columnName == 'salary' || e.columnName == 'bonus')
              ? formatter.format(e.value) 
              : e.value.toString(),
        ),
      );
    }).toList());
  }

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
