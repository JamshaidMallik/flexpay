import 'package:flexpay/constant/AppUi.dart';
import 'package:flexpay/constant/constant.dart';
import 'package:flexpay/controller/userController.dart';
import 'package:flexpay/models/user_model.dart';
import 'package:flexpay/routes/routes.dart';
import 'package:flexpay/widgets/buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashBoard extends GetView {
  static const String routeName = '/DashBoard';
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
        init: Get.put(UserController()),
        builder: (controller) {
          return Scaffold(
            backgroundColor: primaryColor,
            drawerEdgeDragWidth: 100,
            // drawer: buildDrawer(controller),
            appBar: buildAppBar(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                controller.clearFields();
                controller.setUserProfile = null;
                Get.toNamed(AppRoutes.addUser);
              },
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(Icons.add, color: primaryColor),
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
                      style: whiteFontStyle(fontSize: 16),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/empty-data.png'),
                      15.h,
                      Text(
                        'No members found!',
                        style: whiteFontStyle(fontSize: 16),
                      ),
                      50.h,
                    ],
                  );
                }

                final users = snapshot.data!;

                // Tabs to filter data
                return DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      // Tab Bar
                      Container(
                        color: primaryColor,
                        child: const TabBar(
                          indicatorColor: Colors.white,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white70,
                          tabs: [
                            Tab(text: "Male"),
                            Tab(text: "Female"),
                            Tab(text: "UnPaid"),
                          ],
                        ),
                      ),
                      // Tab Bar View
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildFilterList(users.where((user) => user.gender == 'Male').toList()),
                            _buildFilterList(users.where((user) => user.gender == 'Female').toList()),
                            _buildFilterList(users.where((user) => !user.isUserPaid.value).toList()),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      title: Hero(
          tag: 'logoText',
          child: Material(
              color: Colors.transparent,
              child: Text(
                'FlexPay',
                style: whiteFontStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ))),
      actions: [
        IconButton(onPressed: (){
         Get.toNamed(AppRoutes.searchScreen);
        }, icon: const Icon(Icons.search)),
        Obx(()=> Get.find<UserController>().isLogout.value
            ? AppUi.showLoading()
        : IconButton(
          onPressed: () {
            Get.find<UserController>().logOut();
          },
          icon: const Icon(Icons.logout),
        ),),

      ],

    );
  }

  Widget buildDrawer(UserController controller) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: primaryColor),
            child: Center(
              child: Text(
                'FlexPay',
                style: whiteFontStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.blue),
            title: const Text('About Us'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            onTap: () => controller.logOut(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterList(List<UserModel> filteredUsers) {
    if (filteredUsers.isEmpty) {
      return Center(
        child: Text(
          'No users found!',
          style: whiteFontStyle(fontSize: 16),
        ),
      );
    }
    return ListView.separated(
      itemCount: filteredUsers.length,
      separatorBuilder: (context, index) => const Divider(color: Colors.white24),
      padding: const EdgeInsets.only(bottom: 150, top: 10),
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        return GestureDetector(
            onTap: () {
              Get.find<UserController>().setUserProfile = user;
              Get.toNamed(
                AppRoutes.userprofile,
              );
            },
            child: _buildUserCard(user, Get.find<UserController>(), index));
      },
    );
  }

  Widget _buildUserCard(UserModel user, UserController controller, int index) {
    final String fullName = user.fullName ?? "No Name";
    final String joiningDate = DateFormat('d-MMM-yyyy').format(user.joiningDate);
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
}
