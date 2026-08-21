import 'dart:developer';

import 'package:get/get.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/models/vender_kyc/vender_kyc_status_model.dart';
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

  final List<String> sectionKeys = [
    'basic_details',
    'document_numbers',
    'business_info',
    'shop_live',
    'bank_details',
    'kyc_documents',
    'bank_documents',
    'self_live',
    'review',
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

  void applyKycStatus() {
    final verifiedSections =
        venderKycStatusModel?.correctionRemarks?.verifiedSections ?? [];

    for (int i = 0; i < completed.length; i++) {
      completed[i] = verifiedSections.contains(sectionKeys[i]);
    }

    selectedIndex = getNextIncompleteStep();

    update();
  }

  int getNextIncompleteStep() {
    final verifiedSections =
        venderKycStatusModel?.correctionRemarks?.verifiedSections ?? [];

    for (int i = 0; i < sectionKeys.length; i++) {
      if (!verifiedSections.contains(sectionKeys[i])) {
        return i;
      }
    }

    return sectionKeys.length - 1;
  }

  // ============================================================
  //! Api Call
  // ============================================================
  VenderKycStatusModel? venderKycStatusModel;

  Future<ResponseModel> venderKycStatus() async {
    log('----------- venderKycStatus Called ----------');

    isLoading = true;
    update();

    try {
      final response = await venderKycRepo.venderKycStatus();

      log('STATUS CODE: ${response.statusCode}');
      log('RESPONSE BODY: ${response.body}');
      log('RESPONSE TYPE: ${response.body.runtimeType}');

      final body = response.body;

      if (response.statusCode == 200 &&
          body is Map &&
          body['status']?.toString().toLowerCase() == 'success') {
        venderKycStatusModel = VenderKycStatusModel.fromJson(
          Map<String, dynamic>.from(body),
        );

        applyKycStatus();

        return ResponseModel(
          true,
          body['message']?.toString() ?? 'KYC status fetched successfully',
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
        'Error while fetching KYC status: $e',
      );
    } finally {
      isLoading = false;
      update();
    }
  }
}
