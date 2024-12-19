import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexpay/constant/AppUi.dart';
import 'package:flexpay/constant/constant.dart';
import 'package:flexpay/models/user_model.dart';
import 'package:get/get.dart';

class FirebaseAuthService {
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      AppUi.showSnackBar(
        title: 'Login Failed',
        message: e.message.toString(),
      );
      throw e.message ?? "Login failed. Please try again.";
    }
  }
  Future<void> addUser(UserModel user) async {
    try {
      await fireStore.collection(userCollectionName).add(user.toJson());
    } catch (e) {
      rethrow;
    }
  }
  Future<bool?> updateUser(UserModel user) async {
    bool isSuccess = false;
    try {
      final userDoc = fireStore.collection(userCollectionName).doc(user.id);
      final snapshot = await userDoc.get();
      if (snapshot.exists) {
        await userDoc.update(user.toJson());
        AppUi.showSnackBar(
          title: 'Success',
          message: 'Member updated successfully!',
          isError: false,
        );
        isSuccess = true;
      } else {
        AppUi.showSnackBar(
          title: 'Warning!',
          message: 'This member does not exist. Please try again.',
        );
        isSuccess = false;
      }
    } catch (e) {
      isSuccess = false;
      AppUi.showSnackBar(
        title: 'Error!',
        message: 'Error updating user: $e',
      );
      rethrow;
    }
    return isSuccess;
  }
  Future<void> updateUserField({
    required String userId,
    Map<String, dynamic>? data
  }) async {
    try {
      await fireStore
          .collection(userCollectionName)
          .doc(userId)
          .update(data!);
    } catch (e) {
      rethrow;
    }
  }
  Future deleteUser(String userId) async {
    try {
      await fireStore.collection(userCollectionName).doc(userId).delete();
      Get.back();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
