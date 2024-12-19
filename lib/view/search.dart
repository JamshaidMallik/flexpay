import 'package:flexpay/constant/AppUi.dart';
import 'package:flexpay/constant/constant.dart';
import 'package:flexpay/controller/userController.dart';
import 'package:flexpay/models/user_model.dart';
import 'package:flexpay/widgets/buttonWidget.dart';
import 'package:flexpay/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SearchScreen extends GetView<UserController> {
  static const String routeName = '/SearchScreen';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Search'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              controller: controller.searchController,
              onChanged: (value) => controller.searchQuery.value = value,
              fillColor: Colors.white.withOpacity(0.1),
              prefixIcon: const Icon(Icons.search, color: Colors.white),
              borderColor: Colors.white.withOpacity(0.2),
              hintText: 'Search by name',
              hintStyle: whiteFontStyle(),
              textStyle: whiteFontStyle(fontSize: 16),
              cursorColor: whiteColor,
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: controller.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No users found!',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          // Use Obx to listen to changes in searchQuery and dynamically filter users
          return Obx(() {
            final users = controller.filterUsers(snapshot.data!);
            if (users.isEmpty) {
              return const Center(
                child: Text(
                  'No matching users found!',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return _buildUserCard(user, controller, index);
              },
            );
          });
        },
      ),
    );
  }

  Widget _buildUserCard(UserModel user, UserController controller, int index) {
    final String fullName = user.fullName ?? "No Name";
    final String feeUpdateDate = DateFormat('d-MMM-yyyy').format(user.feeUpdateDate);
    final String? imageUrl = user.imageUrl;
    final String firstLatterOfTheName = fullName.isNotEmpty ? fullName[0].toUpperCase() : "?";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: _getRandomColor(fullName),
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
            child: imageUrl == null
                ? Text(
              firstLatterOfTheName,
              style: whiteFontStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )
                : null,
          ),
          15.w,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: whiteFontStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                4.h,
                Column(
                  children: [
                    if(user.isUserPaid.value)
                      Text(
                        "Next Fee Will be charge on: \n$feeUpdateDate",
                        style: customFontStyle(
                          color: whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if(!user.isUserPaid.value)
                      Text('Membership Fee is Overdue!', style: customFontStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),)
                  ],
                ),
                10.h,
                Obx(() => controller.isLoading.value && controller.selectedUserIndex.value == index
                    ? AppUi.showLoading()
                    : CustomButton(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    color: user.isUserPaid.value ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    text: user.isUserPaid.value ? 'Paid' : 'UnPaid',
                    onPressed: () {
                      controller.selectedUserIndex.value = index;
                      controller.updateUserPaidStatus(userId: user.id!, isPaid: user.isUserPaid);
                    }))
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Colors.white54,
            size: 28,
          ),
        ],
      ),
    );
  }
}
Color _getRandomColor(String fullName) {
  final colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.amber,
    Colors.pinkAccent,
    Colors.lightGreen,
    Colors.blueAccent
  ];
  return colors[fullName.length % colors.length];
}