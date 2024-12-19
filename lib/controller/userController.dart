import 'package:flexpay/constant/AppUi.dart';
import 'package:flexpay/constant/constant.dart';
import 'package:flexpay/models/user_model.dart';
import 'package:flexpay/routes/routes.dart';
import 'package:flexpay/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
 final FirebaseAuthService _authService = FirebaseAuthService();
 var isLoading = false.obs;
 var isLogout = false.obs;
 var isDelete = false.obs;
 final fullNameController = TextEditingController();
 final emailController = TextEditingController();
 final addressController = TextEditingController();
 final ageController = TextEditingController();
 final feeController = TextEditingController();
 final phoneNumberController = TextEditingController();
 final selectedGender = 'Male'.obs;
 Rxn<UserModel> userProfileModel = Rxn<UserModel>();
 RxInt selectedUserIndex = (1).obs;
 set setUserProfile(UserModel? value) {
   userProfileModel.value = value;
   if(userProfileModel.value != null) {
     editUser(userProfileModel.value!);
   }

 }
 Future<void> addUser() async {
   final fullName = fullNameController.text.trim();
   final email = emailController.text.trim();
   final phone = phoneNumberController.text.trim();
   final address = addressController.text.trim();
   final age = ageController.text.trim();
   final fee = feeController.text.trim();
   if (fullName.isEmpty) {
     AppUi.showToast(message: 'Full Name is required');
     return;
   }
   isLoading.value = true;
   try {
     final String? parentId = auth.currentUser?.uid;
     if (parentId == null) {
       AppUi.showSnackBar(title: 'Opps!', message: 'Please Logout and then Login Again for perform this action');
       throw Exception("No logged-in user found");
     }
     final user = UserModel(
       parentId: parentId,
       fullName: fullName,
       email: email,
       phoneNumber: phone,
       address: address,
       age: age,
       gender: selectedGender.value,
       joiningDate: DateTime.now(),
       feeUpdateDate: DateTime.now().add(const Duration(days: 30)),
       imageUrl: null,
       isActiveMember: true,
       isUserPaid: true,
       membershipFee: double.tryParse(fee),
     );
     await FirebaseAuthService().addUser(user);
     AppUi.showSnackBar(title: 'Success', message: 'User added successfully!',isError: false);
     clearFields();
   } catch (e) {
     debugPrint(e.toString());
     AppUi.showSnackBar(title: 'Warning!', message: e.toString());
   } finally {
     isLoading.value = false;
   }
 }
 Stream<List<UserModel>> getUsersStream() {
   return fireStore
       .collection(userCollectionName)
       .where('parentId', isEqualTo: auth.currentUser?.uid ?? '')
       .snapshots()
       .map((snapshot) {
     return snapshot.docs.map((doc) {
       final user = UserModel.fromJson(doc.data(), id: doc.id);
       if (DateTime.now().isAfter(user.feeUpdateDate)) {
         debugPrint('User ${user.fullName} is not paid');
         user.isUserPaid.value = false;
         setUserUnPaid(userId: user.id!, isPaid: user.isUserPaid);
       }
       return user;
     }).toList();
   });
 }
 Future updateUserPaidStatus({required String userId, required RxBool isPaid}) async {
   if (isPaid.value) {
     AppUi.showSnackBar(
       title: 'Opps!',
       message: 'This member is already paid.',
       isError: false,
     );
     return;
   }
   isPaid.toggle();
   try {
      isLoading.value = true;
      Map<String, dynamic> data = {
        'isUserPaid': isPaid.value,
        'feeUpdateDate': DateTime.now().add(const Duration(days: 30)),
      };
     await _authService.updateUserField(userId: userId, data: data);
      AppUi.showSnackBar(title: 'Success', message: 'This Member is now ${isPaid.value? 'Paid': 'UnPaid'}', isError: false);
   } catch (e) {
     isPaid.toggle();
     AppUi.showSnackBar(title: 'Warning!', message: e.toString());
   } finally {
     isLoading.value = false;
   }
 }
 Future setUserUnPaid({required String userId, required RxBool isPaid}) async {
   try {
     isLoading.value = true;
     Map<String, dynamic> data = {
       'isUserPaid': isPaid.value,
     };
     await _authService.updateUserField(userId: userId, data: data);
   } catch (e) {
     AppUi.showSnackBar(title: 'Warning!', message: e.toString());
   } finally {
     isLoading.value = false;
   }
 }
 final searchController = TextEditingController();
 var searchQuery = ''.obs;
 List<UserModel> filterUsers(List<UserModel> users) {
   if (searchQuery.value.isEmpty) {
     return users;
   }
   return users.where((user) => user.fullName != null && user.fullName!.toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
 }

 @override
 void onInit() {
   super.onInit();
   searchController.addListener(() {
     searchQuery.value = searchController.text.trim();
   });
 }

 void editUser(UserModel user) {
   fullNameController.text = user.fullName ?? '';
   emailController.text = user.email ?? '';
   phoneNumberController.text = user.phoneNumber ?? '';
   addressController.text = user.address ?? '';
   ageController.text = user.age ?? '';
   feeController.text = user.membershipFee?.toString() ?? '';
   selectedGender.value = user.gender.toString();
 }
 Future updateUser() async {
   final fullName = fullNameController.text.trim();
   final email = emailController.text.trim();
   final phone = phoneNumberController.text.trim();
   final address = addressController.text.trim();
   final age = ageController.text.trim();
   final fee = feeController.text.trim();
   if (fullName.isEmpty) {
     AppUi.showToast(message: 'Full Name is required');
     return;
   }
   isLoading.value = true;
    try {
      final user = UserModel(
        id: userProfileModel.value!.id,
        parentId: userProfileModel.value!.parentId,
        fullName: fullName,
        email: email,
        phoneNumber: phone,
        address: address,
        age: age,
        membershipFee: double.tryParse(fee),
        isUserPaid: userProfileModel.value!.isUserPaid.value,
        isActiveMember: userProfileModel.value!.isActiveMember.value,
        feeUpdateDate: userProfileModel.value!.feeUpdateDate,
        joiningDate: userProfileModel.value!.joiningDate,
        gender: selectedGender.value,
        parentEmail: userProfileModel.value!.parentEmail,
        imageUrl: userProfileModel.value!.imageUrl,
      );
      bool? isSuccess = await _authService.updateUser(user);
      if(isSuccess == true) {
        setUserProfile = user;
        clearFields();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
 }
 Future deleteUser(String userId) async {

   try {
     isDelete.value = true;
     await _authService.deleteUser(userId);
     AppUi.showSnackBar(title: 'Success', message: 'User deleted successfully!', isError: false);
    } catch (e) {
     AppUi.showSnackBar(title: 'Warning!', message: e.toString());
   } finally {
     isDelete.value = false;
   }
 }
 void clearFields() {
   fullNameController.clear();
   emailController.clear();
   phoneNumberController.clear();
   addressController.clear();
   ageController.clear();
   feeController.clear();
   selectedGender.value = 'Male';
 }
 Future<void> logOut() async {
   isLogout.value = true;
   await Future.delayed(const Duration(seconds: 1));
    try {
      await _authService.signOut();
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      AppUi.showSnackBar(
        title: 'Warning!',
        message: e.toString(),
      );
    } finally {
      isLogout.value = false;
    }
  }




}