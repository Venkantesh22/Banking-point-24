import 'dart:developer';

import 'package:get/get.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/repositories/card_withdrawal_repo/vender_kyc_repo.dart';

class FormController extends GetxController implements GetxService {
  final VenderKycRepo venderKycRepo;

  FormController({required this.venderKycRepo});

  // ============================================================
  // KYC STEP CONFIGURATION
  // ============================================================

  bool isLoading = false;

  static const int totalSteps = 9;
  int selectedIndex = 0;

  final List<String> headings = [
    'Basic',
    'KYC Info',
    'Business',
    'Shop',
    'Bank',
    'KYC Doc',
    'Bank Doc',
    'Selfie',
    'Review',
  ];

  /// Completion status for each step.
  final List<bool> completed = List<bool>.filled(totalSteps, false);

  // ============================================================
  // NAVIGATION
  // ============================================================

  void selectIndex(int index) {
    if (index < 0 || index >= totalSteps) {
      return;
    }

    selectedIndex = index;
    update();
  }

  void nextStep() {
    if (selectedIndex >= totalSteps - 1) {
      return;
    }

    completed[selectedIndex] = true;
    selectedIndex++;

    update();
  }

  void previousStep() {
    if (selectedIndex <= 0) {
      return;
    }

    selectedIndex--;

    update();
  }

  // ============================================================
  // COMPLETION
  // ============================================================

  void setComplete(
    int index,
    bool value, {
    bool advanceIfTrue = false,
  }) {
    if (index < 0 || index >= totalSteps) {
      return;
    }

    completed[index] = value;

    if (advanceIfTrue && value && selectedIndex < totalSteps - 1) {
      selectedIndex++;
    }

    update();
  }

  void toggleComplete(int index) {
    if (index < 0 || index >= totalSteps) {
      return;
    }

    completed[index] = !completed[index];

    update();
  }

  void markAllComplete() {
    for (int i = 0; i < completed.length; i++) {
      completed[i] = true;
    }

    update();
  }

  bool isStepCompleted(int index) {
    if (index < 0 || index >= completed.length) {
      return false;
    }

    return completed[index];
  }

  bool get allStepsCompleted {
    return completed.every((step) => step);
  }

  // ============================================================
  // RESET
  // ============================================================

  void resetForm() {
    selectedIndex = 0;

    for (int i = 0; i < completed.length; i++) {
      completed[i] = false;
    }

    update();
  }

  // ============================================================
  //! Api Call
  // ============================================================

  //* submit Vender kyc Status  venderKycStatus()
  Future<ResponseModel> venderKycStatus() async {
    log('----------- venderKycStatus Called ----------');

    isLoading = true;
    update();

    try {
      final response = await venderKycRepo.venderKycStatus();

      final body = response.body;

      if (response.statusCode == 200 &&
          body is Map &&
          body['status']?.toString().toLowerCase() == 'success') {
        return ResponseModel(
          true,
          body['message']?.toString() ??
              'venderKycStatus details submitted successfully',
        );
      }

      String message = 'Something went wrong';

      if (body is Map && body['message'] != null) {
        message = body['message'].toString();
      } else if (response.statusText != null &&
          response.statusText!.isNotEmpty) {
        message = response.statusText!;
      }

      return ResponseModel(false, message);
    } catch (e, stackTrace) {
      log(
        'ERROR AT venderKycStatus(): $e',
        stackTrace: stackTrace,
      );

      return ResponseModel(
        false,
        'Error while submitting venderKycStatus details: $e',
      );
    } finally {
      isLoading = false;
      update();
    }
  }
}
