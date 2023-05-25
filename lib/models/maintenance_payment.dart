import 'package:admin/models/maintenance_charge.dart';
import 'package:admin/models/user.dart';

class MaintenancePayment {
  int id;
  int userId;
  int maintenanceChargeId;
  DateTime paymentDate;
  double amount;
  User? user;
  MaintenanceCharge? maintenanceCharge;

  MaintenancePayment({
    required this.id,
    required this.userId,
    required this.maintenanceChargeId,
    required this.paymentDate,
    required this.amount,
    this.user,
    this.maintenanceCharge,
  });

  // Method to convert MaintenancePayment object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'maintenanceChargeId': maintenanceChargeId,
      'paymentDate': paymentDate?.toIso8601String(),
      'amount': amount,
      'user': user?.toJson(),
      'maintenanceCharge': maintenanceCharge?.toJson(),
    };
  }

  // Method to create a MaintenancePayment object from JSON
  factory MaintenancePayment.fromJson(Map<String, dynamic> json) {
    return MaintenancePayment(
      id: json['id'],
      userId: json['userId'],
      maintenanceChargeId: json['maintenanceChargeId'],
      paymentDate: DateTime.parse(json['paymentDate']),
      amount: json['amount'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      maintenanceCharge: json['maintenanceCharge'] != null
          ? MaintenanceCharge.fromJson(json['maintenanceCharge'])
          : null,
    );
  }

  // ... other methods and validations ...
}
