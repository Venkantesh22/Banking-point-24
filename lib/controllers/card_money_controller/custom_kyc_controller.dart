import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/repositories/card_withdrawal_repo/custom_kyc_repo.dart';

enum KycStatus {
  pending,
  verified,
  rejected,
}

class CustomKycController extends GetxController implements GetxService {
  final CustomKycRepo customKycRepo;

  CustomKycController({required this.customKycRepo});

  bool isLoading = false;

  // ============================================================
  // CONTROLLERS
  // ============================================================

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController mobileNumberController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  // ============================================================
  // IMAGE PICKER
  // ============================================================

  final ImagePicker imagePicker = ImagePicker();

  // ============================================================
  // STATE
  // ============================================================

  bool isMobileVerified = false;
  bool isOtpVerified = false;
  bool isSubmitting = false;

  // ============================================================
  // OTP
  // ============================================================

  String otp = '';

  void updateOtp() {
    otp = otpControllers.map((controller) => controller.text).join();

    update();
  }

  void verifyOtp() {
    if (otp.length == 6) {
      isOtpVerified = true;
      update();
    }
  }

  // ============================================================
  // MOBILE
  // ============================================================

  void setMobileVerified(bool value) {
    isMobileVerified = value;
    update();
  }

  // ============================================================
  // FILES
  // ============================================================

  File? panCardImage;
  File? aadhaarFrontImage;
  File? aadhaarBackImage;
  File? livePhoto;

  // ============================================================
  // IMAGE SOURCE
  // ============================================================

  Future<ImageSource?> _selectImageSource(
    BuildContext context,
  ) async {
    return showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Select Image Source',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt_outlined,
                  ),
                  title: const Text('Camera'),
                  onTap: () {
                    Navigator.pop(
                      context,
                      ImageSource.camera,
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.photo_library_outlined,
                  ),
                  title: const Text('Gallery'),
                  onTap: () {
                    Navigator.pop(
                      context,
                      ImageSource.gallery,
                    );
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // PICK IMAGE
  // ============================================================

  Future<File?> _pickImage(
    BuildContext context, {
    required ImageSource source,
  }) async {
    final XFile? image = await imagePicker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image == null) {
      return null;
    }

    return File(image.path);
  }

  // ============================================================
  // PAN CARD
  // ============================================================

  Future<void> pickPanCardImage(
    BuildContext context,
  ) async {
    final ImageSource? source = await _selectImageSource(context);

    if (source == null) {
      return;
    }

    final File? image = await _pickImage(
      context,
      source: source,
    );

    if (image == null) {
      return;
    }

    panCardImage = image;
    update();
  }

  void removePanCardImage() {
    panCardImage = null;
    update();
  }

  // ============================================================
  // AADHAAR FRONT
  // ============================================================

  Future<void> pickAadhaarFrontImage(
    BuildContext context,
  ) async {
    final ImageSource? source = await _selectImageSource(context);

    if (source == null) {
      return;
    }

    final File? image = await _pickImage(
      context,
      source: source,
    );

    if (image == null) {
      return;
    }

    aadhaarFrontImage = image;
    update();
  }

  void removeAadhaarFrontImage() {
    aadhaarFrontImage = null;
    update();
  }

  // ============================================================
  // AADHAAR BACK
  // ============================================================

  Future<void> pickAadhaarBackImage(
    BuildContext context,
  ) async {
    final ImageSource? source = await _selectImageSource(context);

    if (source == null) {
      return;
    }

    final File? image = await _pickImage(
      context,
      source: source,
    );

    if (image == null) {
      return;
    }

    aadhaarBackImage = image;
    update();
  }

  void removeAadhaarBackImage() {
    aadhaarBackImage = null;
    update();
  }

  // ============================================================
  // LIVE PHOTO
  // ============================================================

  Future<void> captureLivePhoto(
    BuildContext context,
  ) async {
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.front,
    );

    if (image == null) {
      return;
    }

    livePhoto = File(image.path);
    update();
  }

  void removeLivePhoto() {
    livePhoto = null;
    update();
  }

  //* Call Submit custom Kyc Api submitCustomKyc()
  Future<ResponseModel> submitCustomKyc({
    required String? number,
  }) async {
    log('----------- submitCustomKyc Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "full_name": fullNameController.text.trim(),
        "mobile_number": mobileNumberController.text.trim(),
        "email": emailController.text.trim(),
        "dob": "",
      };
      Response response =
          await customKycRepo.submitCustomKyc(data: FormData(data));

      if (response.statusCode == 200 && response.body['status'] == "success") {
        responseModel = ResponseModel(true,
            response.body['message'] ?? " generateOTPForPrepaidCard success");
      } else {
        responseModel = ResponseModel(
            false,
            response.body['message'] ??
                "Error while generateOTPForPrepaidCard");
      }
    } catch (e) {
      log('ERROR AT generateOTPForPrepaidCard(): $e');
      responseModel =
          ResponseModel(false, "Error while generateOTPForPrepaidCard user $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  //* Call Submit custom Kyc Live photo Api submitCustomKycLivePhoto()
  Future<ResponseModel> submitCustomKycLivePhoto({
    required String? number,
  }) async {
    log('----------- submitCustomKycLivePhoto Called ----------');

    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "selfie": livePhoto,
      };
      Response response =
          await customKycRepo.submitCustomKycLivePhoto(data: FormData(data));

      if (response.statusCode == 200 && response.body['status'] == "success") {
        responseModel = ResponseModel(true,
            response.body['message'] ?? " submitCustomKycLivePhoto success");
      } else {
        responseModel = ResponseModel(false,
            response.body['message'] ?? "Error while submitCustomKycLivePhoto");
      }
    } catch (e) {
      log('ERROR AT submitCustomKycLivePhoto(): $e');
      responseModel =
          ResponseModel(false, "Error while submitCustomKycLivePhoto user $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  // ============================================================
  // CLEAR
  // ============================================================

  void clearForm() {
    fullNameController.clear();
    mobileNumberController.clear();
    emailController.clear();

    for (final controller in otpControllers) {
      controller.clear();
    }

    otp = '';

    isMobileVerified = false;
    isOtpVerified = false;
    isSubmitting = false;

    panCardImage = null;
    aadhaarFrontImage = null;
    aadhaarBackImage = null;
    livePhoto = null;

    update();
  }

  // ============================================================
  // STATE
  // ============================================================

  KycStatus status = KycStatus.pending;

  // ============================================================
  // STATUS
  // ============================================================

  void setStatus(KycStatus value) {
    status = value;
    update();
  }

  // ============================================================
  // RETRY
  // ============================================================

  void retryKyc() {
    isLoading = true;
    update();

    debugPrint('Retry KYC');

    // API will be added later.

    isLoading = false;
    update();
  }

  // ============================================================
  // RESET
  // ============================================================

  void resetStatus() {
    status = KycStatus.pending;
    isLoading = false;
    update();
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void onClose() {
    fullNameController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();

    for (final controller in otpControllers) {
      controller.dispose();
    }

    super.onClose();
  }
}
