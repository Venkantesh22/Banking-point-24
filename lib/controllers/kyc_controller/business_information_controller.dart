import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/repositories/card_withdrawal_repo/vender_kyc_repo.dart';

class BusinessInformationController extends GetxController
    implements GetxService {
  final VenderKycRepo venderKycRepo;

  BusinessInformationController({required this.venderKycRepo});

  bool isLoading = false;
  // ============================================================
  // BUSINESS INFORMATION
  // ============================================================

  String? businessCategory;

  String? natureOfBusiness;

  String? expectedMonthlyTransactionVolume;

  String? businessOwnershipType;

  // ============================================================
  // TEXT CONTROLLERS
  // ============================================================

  final TextEditingController businessDescriptionController =
      TextEditingController();

  final TextEditingController businessStartDateController =
      TextEditingController();

  // ============================================================
  // DROPDOWN LISTS
  // ============================================================

  final List<String> businessCategoryList = [];

  final List<String> natureOfBusinessList = [];

  final List<String> transactionVolumeList = [
    'Below ₹50,000',
    '₹50,000 - ₹1 Lakh',
    '₹1 Lakh - ₹5 Lakh',
    '₹5 Lakh - ₹10 Lakh',
    'Above ₹10 Lakh',
  ];

  final List<String> businessOwnershipTypeList = [
    'Owned',
    'Rented',
    'Other',
  ];

  // ============================================================
  // SETTERS
  // ============================================================

  void setBusinessCategory(String? value) {
    businessCategory = value;
    update();
  }

  void setNatureOfBusiness(String? value) {
    natureOfBusiness = value;
    update();
  }

  void setExpectedMonthlyTransactionVolume(String? value) {
    expectedMonthlyTransactionVolume = value;
    update();
  }

  void setBusinessOwnershipType(String? value) {
    businessOwnershipType = value;
    update();
  }

  // ============================================================
  // BUSINESS START DATE
  // ============================================================

  void setBusinessStartDate(DateTime date) {
    final String day = date.day.toString().padLeft(2, '0');

    final String month = date.month.toString().padLeft(2, '0');

    final String year = date.year.toString();

    businessStartDateController.text = '$day/$month/$year';

    update();
  }

  // ============================================================
  // VALIDATION
  // ============================================================

  bool validateBusinessInformation() {
    if (businessCategory == null || businessCategory!.trim().isEmpty) {
      return false;
    }

    if (natureOfBusiness == null || natureOfBusiness!.trim().isEmpty) {
      return false;
    }

    if (expectedMonthlyTransactionVolume == null ||
        expectedMonthlyTransactionVolume!.trim().isEmpty) {
      return false;
    }

    if (businessOwnershipType == null ||
        businessOwnershipType!.trim().isEmpty) {
      return false;
    }

    if (businessStartDateController.text.trim().isEmpty) {
      return false;
    }

    return true;
  }

  // ============================================================
  // FORM DATA
  // ============================================================

  Map<String, dynamic> toMap() {
    return {
      'business_category': businessCategory,
      'nature_of_business': natureOfBusiness,
      'expected_monthly_transaction_volume': expectedMonthlyTransactionVolume,
      'business_ownership_type': businessOwnershipType,
      'business_description': businessDescriptionController.text.trim(),
      'business_start_date': businessStartDateController.text.trim(),
    };
  }

  //* submit Vender kyc Business information  venderKycBusinessInfo()
  Future<ResponseModel> venderKycBusinessInfo() async {
    log('----------- venderKycBusinessInfo Called ----------');

    isLoading = true;
    update();

    try {
      final Map<String, dynamic> data = {
        "section": "business_info",
        "business_category": businessCategory,
        "nature_of_business": natureOfBusiness,
        "business_description": businessDescriptionController.text.trim(),
        "business_start_date": businessStartDateController.text.trim(),
        "expected_monthly_volume": expectedMonthlyTransactionVolume,
        "ownership_type": businessOwnershipType,
      };

      final response = await venderKycRepo.venderKycBusinessInfo(
        data: data,
      );

      log('STATUS CODE: ${response.statusCode}');
      log('RESPONSE BODY: ${response.body}');
      log('RESPONSE TYPE: ${response.body.runtimeType}');

      final body = response.body;

      if (response.statusCode == 200 &&
          body is Map &&
          body['status']?.toString().toLowerCase() == 'success') {
        return ResponseModel(
          true,
          body['message']?.toString() ??
              'venderKycBusinessInfo details submitted successfully',
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
        'ERROR AT venderKycBusinessInfo(): $e',
        stackTrace: stackTrace,
      );

      return ResponseModel(
        false,
        'Error while submitting venderKycBusinessInfo() : $e',
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  // ============================================================
  // CLEAR FORM
  // ============================================================

  void clearForm() {
    businessCategory = null;
    natureOfBusiness = null;
    expectedMonthlyTransactionVolume = null;
    businessOwnershipType = null;

    businessDescriptionController.clear();
    businessStartDateController.clear();

    update();
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void onClose() {
    businessDescriptionController.dispose();
    businessStartDateController.dispose();

    super.onClose();
  }
}
