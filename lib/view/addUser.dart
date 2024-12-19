import 'package:flexpay/constant/constant.dart';
import 'package:flexpay/controller/userController.dart';
import 'package:flexpay/models/user_model.dart';
import 'package:flexpay/widgets/buttonWidget.dart';
import 'package:flexpay/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUserScreen extends StatefulWidget {
  static const String routeName = '/AddUserScreen';
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {

  final UserController controller = Get.find<UserController>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(controller.userProfileModel.value == null? 'Add Member' : 'Update Member'),
        backgroundColor: primaryColor,
        actions: [
          Obx(()=> controller.isLoading.value ? const Center(child: CircularProgressIndicator(color: Colors.white,)): Center(
            child: CustomButton(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              color: whiteColor,
              borderRadius: 20,
              text: controller.userProfileModel.value == null? 'Add': 'Update',
              textColor: primaryColor,
              onPressed: () {
                if(controller.userProfileModel.value == null) {
                  controller.addUser();
                }else{
                  controller.updateUser();
                }
              }
            ),
          )),
          10.w,
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(kAppPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Full Name *', style: whiteFontStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              5.h,
              CustomTextField(
                controller: controller.fullNameController,
                hintText: 'Full Name',
                keyboardType: TextInputType.name,
                prefixIcon: Icon(Icons.edit, color: blackColor),
              ),
              15.h,
              Text('Email', style: whiteFontStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              5.h,
              CustomTextField(
                controller: controller.emailController,
                hintText: 'example (test@gmail.com)',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.email, color: blackColor),
              ),
              15.h,
              Text('Phone Number', style: whiteFontStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              5.h,
              CustomTextField(
                controller: controller.phoneNumberController,
                hintText: '',
                keyboardType: TextInputType.phone,
                prefixIcon: Icon(Icons.phone, color: blackColor),
              ),
              // 15.h,
              //
              // Row(
              //   children: [
              //     Expanded(child: Column(
              //       children: [
              //         Text('Joining Date *', style: whiteFontStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              //         5.h,
              //         CustomTextField(
              //           controller: controller.joiningDateController,
              //           hintText: 'Select Date',
              //           keyboardType: TextInputType.datetime,
              //           prefixIcon: Icon(Icons.date_range_outlined, color: blackColor),
              //           onTap: () async {
              //             DateTime? pickedDate = await showDatePicker(
              //               context: context,
              //               initialDate: DateTime.now(),
              //               firstDate: DateTime(1990),
              //               lastDate: DateTime(2100),
              //             );
              //             if (pickedDate != null) {
              //               controller.joiningDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
              //             }
              //           },
              //           readOnly: true,
              //         ),
              //       ],
              //     )),
              //     20.w,
              //     Expanded(child: Column(
              //       children: [
              //         Text('Fee Update Date *', style: whiteFontStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              //         5.h,
              //         CustomTextField(
              //           controller: controller.feeUpdateDateController,
              //           hintText: 'Select Date',
              //           keyboardType: TextInputType.datetime,
              //           prefixIcon: Icon(Icons.date_range_outlined, color: blackColor),
              //           onTap: () async {
              //             DateTime? pickedDate = await showDatePicker(
              //               context: context,
              //               initialDate: DateTime.now(),
              //               firstDate: DateTime(2000),
              //               lastDate: DateTime(2100),
              //             );
              //             if (pickedDate != null) {
              //               controller.feeUpdateDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
              //             }
              //           },
              //           readOnly: true,
              //         ),
              //       ],
              //     )),
              //   ],
              // ),
              15.h,
              Text('Select Gender', style: whiteFontStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              5.h,
              Obx(()=> DropdownButtonFormField<String>(
                icon: Icon(Icons.keyboard_arrow_down_rounded, color: blackColor,),
                value: controller.selectedGender.value,
                onChanged: (value) {
                  controller.selectedGender.value = value!;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: textFieldFillColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: textFieldBorderColor),
                  ),
                ),
                items: ['Male', 'Female',]
                    .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                )).toList(),
              ),),
              15.h,
              Text('Age', style: whiteFontStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              5.h,
              CustomTextField(
                controller: controller.ageController,
                hintText: '',
                keyboardType: TextInputType.number,
                prefixIcon: Icon(Icons.numbers, color: blackColor),
              ),
              15.h,
              Text('Address', style: whiteFontStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              5.h,
              CustomTextField(
                controller: controller.addressController,
                hintText: '',
                keyboardType: TextInputType.streetAddress,
                prefixIcon: Icon(Icons.location_city, color: blackColor),
              ),
              15.h,
              Text('Fees', style: whiteFontStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              5.h,
              CustomTextField(
                controller: controller.feeController,
                hintText: '',
                keyboardType: const TextInputType.numberWithOptions(signed: true ),
                prefixIcon: Icon(Icons.currency_rupee, color: blackColor),
              ),
              50.h,
            ],
          ),
        ),
      ),
    );
  }
}
