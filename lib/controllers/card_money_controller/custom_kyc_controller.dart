import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomKycController extends GetxController
    implements GetxService {
  // ============================================================
  // CONTROLLERS
  // ============================================================

  final TextEditingController mobileNumberController =
      TextEditingController();

  // ============================================================
  // STATE
  // ============================================================

  bool isCheckingKyc = false;

  String? mobileError;

  // ============================================================
  // VALIDATE MOBILE NUMBER
  // ============================================================

  bool validateMobileNumber() {
    final String mobile =
        mobileNumberController.text.trim();

    if (mobile.isEmpty) {
      mobileError = 'Please enter customer mobile number';
      update();
      return false;
    }

    if (!RegExp(r'^[6-9][0-9]{9}$').hasMatch(mobile)) {
      mobileError = 'Please enter a valid 10 digit mobile number';
      update();
      return false;
    }

    mobileError = null;
    update();

    return true;
  }

  // ============================================================
  // CHECK CUSTOMER KYC
  // ============================================================

  Future<bool?> checkCustomerKyc() async {
    if (!validateMobileNumber()) {
      return null;
    }

    try {
      isCheckingKyc = true;
      update();

      final String mobile =
          mobileNumberController.text.trim();

      debugPrint(
        'Checking customer KYC for mobile: $mobile',
      );

      /*
       * ========================================================
       * API CALL WILL COME HERE
       * ========================================================
       *
       * Example:
       *
       * final response =
       *     await cardMoneyRepo.checkCustomerKyc(mobile);
       *
       * if (response.isSuccess) {
       *   return response.data['kyc_done'] == true;
       * }
       *
       * ========================================================
       */

      // Temporary value until API is connected.
      //
      // false = KYC not completed
      // true  = KYC already completed
      //
      // Replace this with your API response.
      final bool isKycCompleted = false;

      return isKycCompleted;
    } catch (e) {
      debugPrint(
        'Check Customer KYC Error: $e',
      );

      return null;
    } finally {
      isCheckingKyc = false;
      update();
    }
  }

  // ============================================================
  // CLEAR
  // ============================================================

  void clearMobile() {
    mobileNumberController.clear();
    mobileError = null;
    update();
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void onClose() {
    mobileNumberController.dispose();
    super.onClose();
  }
}