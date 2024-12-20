import 'package:flexpay/constant/AppUi.dart';
import 'package:flexpay/constant/constant.dart';
import 'package:flexpay/controller/userController.dart';
import 'package:flexpay/routes/routes.dart';
import 'package:flexpay/widgets/buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserProfile extends GetView<UserController> {
  static String routeName = '/UserProfile';
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [primaryColor, primaryColor.withOpacity(0.2)],
        ),
      ),
      child: Obx(()=> Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar(controller),
        body: controller.userProfileModel.value == null
            ? const Center(
          child: Text(
            "No user data available.",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        )
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: _getRandomColor(controller.userProfileModel.value!.fullName ?? "No Name"),
                  backgroundImage:  controller.userProfileModel.value!.imageUrl != null ? NetworkImage( controller.userProfileModel.value!.imageUrl!) : null,
                  child:  controller.userProfileModel.value!.imageUrl == null
                      ? Text(
                    controller.userProfileModel.value!.fullName != null ? controller.userProfileModel.value!.fullName![0].toUpperCase() : "?",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      : null,
                ),
                15.h,
                // Full Name
                Text(
                  controller.userProfileModel.value!.fullName ?? "No Name",
                  style: whiteFontStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                8.h,
            
                if (controller.userProfileModel.value!.email != null && controller.userProfileModel.value!.email!.isNotEmpty)
                  Text(
                    controller.userProfileModel.value!.email!,
                    style: whiteFontStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                24.h,
                _buildInfoRow("Phone Number", controller.userProfileModel.value!.phoneNumber!.isNotEmpty? controller.userProfileModel.value!.phoneNumber.toString(): "N/A"),
                _buildInfoRow("Address", controller.userProfileModel.value!.address!.isNotEmpty? controller.userProfileModel.value!.address.toString() : "N/A"),
                _buildInfoRow("Age", controller.userProfileModel.value!.age!.isNotEmpty? controller.userProfileModel.value!.age.toString(): "N/A"),
                 _buildInfoRow("Gender", controller.userProfileModel.value!.gender ?? "Not Available"),
                _buildInfoRow("Joining Date", _formatDate(controller.userProfileModel.value!.joiningDate)),
                _buildInfoRow("Next Fee Will be charge on", _formatDate(controller.userProfileModel.value!.feeUpdateDate)),
                _buildInfoRow("Membership Fee", controller.userProfileModel.value!.membershipFee != null ? "Rs ${controller.userProfileModel.value!.membershipFee!.toStringAsFixed(2)}" : "N/A"),
                _buildInfoRow("Active Member", controller.userProfileModel.value!.isActiveMember.value ? "Yes" : "No"),
                20.h,
                Obx(()=> controller.isLoading.value
                    ? AppUi.showLoading()
                    : CustomButton(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    color: controller.userProfileModel.value!.isUserPaid.value? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    borderRadius: 5,
                    text: controller.userProfileModel.value!.isUserPaid.value? 'Paid': 'UnPaid', onPressed: ()=> controller.updateUserPaidStatus(userId: controller.userProfileModel.value!.id!, isPaid: controller.userProfileModel.value!.isUserPaid)),),
                20.h,
              ],
            ),
          ),
        ),
      ),)
    );
  }
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$label:",
              style: whiteFontStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          5.w,
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: whiteFontStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),

        ],
      ),
    );
  }
  String _formatDate(DateTime date) {
    return DateFormat('d-MMM-yyyy').format(date);
  }
  Color _getRandomColor(String seed) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
    ];
    return colors[seed.hashCode % colors.length];
  }
}

AppBar buildAppBar(UserController controller) {
  return AppBar(
    backgroundColor: Colors.transparent,
    actions: [
      Obx(() => controller.isDelete.value
          ? AppUi.showLoading()
          : IconButton(
        onPressed: () async {
          Get.defaultDialog(
            title: "Warning",
            titleStyle: customFontStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 20),
            middleText: "Are you sure you want to delete this member?",
            middleTextStyle: blackFontStyle(fontSize: 16, fontWeight: FontWeight.normal),
            confirm: ElevatedButton(
              onPressed: () async {
                Get.back();
                await controller.deleteUser(controller.userProfileModel.value!.id!);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Yes, Delete", style: whiteFontStyle(fontSize: 16)),
            ),
            cancel: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: Text("Cancel", style: whiteFontStyle(fontSize: 16)),
            ),
          );
        },
        icon: const Icon(Icons.delete, color: Colors.red),
      ),
      ),

      10.w,

      IconButton(
        onPressed: () {
          controller.setUserProfile = controller.userProfileModel.value;
          Get.toNamed(AppRoutes.addUser);
        },
        icon: const Icon(Icons.edit),
      ),

      10.w,
    ],
  );
}
