import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserModel {
  final String? id;
  final String? parentId;
  final String? parentEmail;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final String? age;
  final String? gender;
  final DateTime joiningDate;
  final DateTime feeUpdateDate;
  final String? imageUrl;
  final RxBool isActiveMember;
  final RxBool isUserPaid;
  final double? membershipFee;

  UserModel({
    this.id,
    this.parentId,
    this.parentEmail,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.address,
    this.age,
    this.gender,
    required this.joiningDate,
    required this.feeUpdateDate,
    this.imageUrl,
    required bool isActiveMember,
    required bool isUserPaid,
    this.membershipFee,
  })  : isActiveMember = RxBool(isActiveMember),
        isUserPaid = RxBool(isUserPaid);

  Map<String, dynamic> toJson() {
    return {
      'parentId': parentId,
      'parentEmail': parentEmail,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'age': age,
      'gender': gender,
      'joiningDate': Timestamp.fromDate(joiningDate),
      'feeUpdateDate': Timestamp.fromDate(feeUpdateDate),
      'imageUrl': imageUrl,
      'isActiveMember': isActiveMember.value,
      'isUserPaid': isUserPaid.value,
      'membershipFee': membershipFee,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return UserModel(
      id: id,
      parentId: json['parentId'],
      parentEmail: json['parentEmail'],
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      age: json['age'],
      gender: json['gender'],
      joiningDate: (json['joiningDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      feeUpdateDate: (json['feeUpdateDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      imageUrl: json['imageUrl'],
      isActiveMember: json['isActiveMember'] ?? false,
      isUserPaid: json['isUserPaid'] ?? false,
      membershipFee: json['membershipFee']?.toDouble(),
    );
  }
}
