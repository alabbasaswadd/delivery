class CustomerDataModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final DateTime joinDate;
  final int orderCount;
  final double totalSpending;
  final DateTime? lastOrderDate;

  CustomerDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.joinDate,
    required this.orderCount,
    required this.totalSpending,
    required this.lastOrderDate,
  });

  factory CustomerDataModel.fromJson(Map<String, dynamic> json) {
    return CustomerDataModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      joinDate: DateTime.parse(json['joinDate']),
      orderCount: json['orderCount'],
      totalSpending: json['totalSpending'],
      lastOrderDate: json['lastOrderDate'] != null
          ? DateTime.parse(json['lastOrderDate'])
          : null,
    );
  }
}
