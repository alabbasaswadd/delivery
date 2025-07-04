import 'package:delivery/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerReportsScreen extends StatefulWidget {
  @override
  _CustomerReportsScreenState createState() => _CustomerReportsScreenState();
}

class _CustomerReportsScreenState extends State<CustomerReportsScreen> {
  List<Customer> customers = [];
  List<Customer> filteredCustomers = [];
  DateTimeRange? dateRange;
  String searchQuery = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  Future<void> _loadCustomers() async {
    // في التطبيق الحقيقي، هذه البيانات ستأتي من API
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      customers = [
        Customer(
          id: '1',
          name: 'أحمد محمد',
          email: 'ahmed@example.com',
          phone: '0501234567',
          joinDate: DateTime(2023, 1, 15),
          orderCount: 12,
          totalSpending: 4500.0,
          lastOrderDate: '2023-10-05',
        ),
        Customer(
          id: '2',
          name: 'سارة علي',
          email: 'sara@example.com',
          phone: '0557654321',
          joinDate: DateTime(2023, 3, 22),
          orderCount: 8,
          totalSpending: 3200.0,
          lastOrderDate: '2023-09-28',
        ),
        // يمكن إضافة المزيد من الزبائن
      ];
      filteredCustomers = customers;
      isLoading = false;
    });
  }

  void _filterCustomers() {
    setState(() {
      filteredCustomers = customers.where((customer) {
        final matchesSearch = customer.name.contains(searchQuery) ||
            customer.phone.contains(searchQuery) ||
            customer.email.contains(searchQuery);

        final matchesDate = dateRange == null ||
            (customer.joinDate.isAfter(dateRange!.start) &&
                customer.joinDate.isBefore(dateRange!.end));

        return matchesSearch && matchesDate;
      }).toList();
    });
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: dateRange,
      locale: const Locale('ar'),
    );

    if (picked != null) {
      setState(() {
        dateRange = picked;
        _filterCustomers();
      });
    }
  }

  void _exportToExcel() {
    // هنا كود تصدير البيانات لملف Excel
    // يمكن استخدام حزمة مثل excel أو syncfusion_flutter_xlsio
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم تصدير البيانات بنجاح')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تقارير الزبائن'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _exportToExcel,
            tooltip: 'تصدير للتقرير',
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : _buildCustomersTable(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'بحث',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  _filterCustomers();
                });
              },
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDateRange(context),
                    child: Text(
                      dateRange == null
                          ? 'اختر فترة زمنية'
                          : '${DateFormat('yyyy/MM/dd').format(dateRange!.start)} - ${DateFormat('yyyy/MM/dd').format(dateRange!.end)}',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                if (dateRange != null)
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        dateRange = null;
                        _filterCustomers();
                      });
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomersTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('الاسم')),
          DataColumn(label: Text('البريد الإلكتروني')),
          DataColumn(label: Text('الهاتف')),
          DataColumn(label: Text('تاريخ الانضمام')),
          DataColumn(label: Text('عدد الطلبات'), numeric: true),
          DataColumn(label: Text('إجمالي المشتريات'), numeric: true),
          DataColumn(label: Text('آخر طلب')),
        ],
        rows: filteredCustomers.map((customer) {
          return DataRow(cells: [
            DataCell(Text(customer.name)),
            DataCell(Text(customer.email)),
            DataCell(Text(customer.phone)),
            DataCell(Text(DateFormat('yyyy/MM/dd').format(customer.joinDate))),
            DataCell(Text(customer.orderCount.toString())),
            DataCell(Text('${customer.totalSpending.toStringAsFixed(2)} ر.س')),
            DataCell(Text(customer.lastOrderDate ?? 'لا يوجد')),
          ]);
        }).toList(),
      ),
    );
  }
}
