import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:lekra/data/models/response/response_model.dart';
import 'package:lekra/data/repositories/card_withdrawal_repo/vender_kyc_repo.dart';

class KycDocumentUploadController extends GetxController
    implements GetxService {
  final VenderKycRepo venderKycRepo;

  KycDocumentUploadController({required this.venderKycRepo});

  // ============================================================
  // DOCUMENT CONFIGURATION
  // ============================================================

  bool isLoading = false;

  final List<String> kycDocumentNames = [
    'Aadhaar Front',
    'Aadhaar Back',
    'PAN Card',
    'Passport-size Photo',
    'GST Certificate',
    'Trade Licence',
    'MSME / Udyam Certificate',
  ];

  final List<String> kycDocumentDescriptions = [
    'Upload front side',
    'Upload back side',
    'Upload PAN card',
    'Upload passport-size photo',
    'Upload GST certificate',
    'Upload trade licence',
    'Upload Udyam certificate',
  ];

  // ============================================================
  // SELECTED FILES
  // ============================================================

  final List<File?> kycDocuments = List<File?>.filled(
    7,
    null,
  );

  // ============================================================
  // UPLOADING STATE
  // ============================================================

  int? uploadingDocumentIndex;

  bool get isUploadingDocument => uploadingDocumentIndex != null;

  // ============================================================
  // PICK DOCUMENT
  // ============================================================

  Future<void> pickKycDocument(int index) async {
    if (index < 0 || index >= kycDocuments.length) {
      return;
    }

    if (isUploadingDocument) {
      return;
    }

    try {
      uploadingDocumentIndex = index;
      update();

      final bool isPassportPhoto = index == 3;

      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: isPassportPhoto
            ? [
                'jpg',
                'jpeg',
                'png',
              ]
            : [
                'pdf',
                'jpg',
                'jpeg',
                'png',
              ],
      );

      if (result == null ||
          result.files.isEmpty ||
          result.files.first.path == null) {
        return;
      }

      final String path = result.files.first.path!;

      final File file = File(path);

      // ========================================================
      // FILE SIZE VALIDATION
      // ========================================================

      const int maxFileSize = 10 * 1024 * 1024;

      final int fileSize = await file.length();

      if (fileSize > maxFileSize) {
        Get.snackbar(
          'File too large',
          'Please select a file smaller than 10 MB.',
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      // ========================================================
      // SAVE FILE
      // ========================================================

      kycDocuments[index] = file;

      update();
    } catch (e) {
      log(
        'ERROR pickKycDocument(): $e',
      );

      Get.snackbar(
        'Error',
        'Unable to select document.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      uploadingDocumentIndex = null;
      update();
    }
  }

  // ============================================================
  // REMOVE DOCUMENT
  // ============================================================

  void removeKycDocument(int index) {
    if (index < 0 || index >= kycDocuments.length) {
      return;
    }

    kycDocuments[index] = null;

    update();
  }

  // ============================================================
  // DOCUMENT STATUS
  // ============================================================

  bool isDocumentUploaded(int index) {
    if (index < 0 || index >= kycDocuments.length) {
      return false;
    }

    return kycDocuments[index] != null;
  }

  // ============================================================
  // FILE NAME
  // ============================================================

  String getDocumentFileName(int index) {
    if (index < 0 || index >= kycDocuments.length) {
      return '';
    }

    final File? file = kycDocuments[index];

    if (file == null) {
      return '';
    }

    return file.path
        .split(
          Platform.pathSeparator,
        )
        .last;
  }

  // ============================================================
  // DOCUMENT COUNT
  // ============================================================

  int get uploadedDocumentCount {
    return kycDocuments.where((file) => file != null).length;
  }

  int get totalDocuments {
    return kycDocuments.length;
  }

  // ============================================================
  // REQUIRED DOCUMENTS
  // ============================================================

  bool isDocumentRequired(int index) {
    // First 4 are currently required.
    return index >= 0 && index <= 3;
  }

  // ============================================================
  // CHECK REQUIRED DOCUMENTS
  // ============================================================

  bool get allRequiredDocumentsUploaded {
    for (int i = 0; i < kycDocuments.length; i++) {
      if (isDocumentRequired(i) && kycDocuments[i] == null) {
        return false;
      }
    }

    return true;
  }

  // ============================================================
  // COMPLETE SCREEN
  // ============================================================

  bool validateAndComplete() {
    return allRequiredDocumentsUploaded;
  }

  // ============================================================
  // CLEAR FORM
  // ============================================================

  void clearForm() {
    for (int i = 0; i < kycDocuments.length; i++) {
      kycDocuments[i] = null;
    }

    uploadingDocumentIndex = null;

    update();
  }

  // ============================================================
  // Call Api
  // ============================================================

  //* submit Vender kyc Document upload  venderKycKYCDocUpload()
  Future<ResponseModel> venderKycKYCDocUpload({
    required File? cancelledChequeImage,
    required File? bankStatementImage,
    required File? liveSelfieImage,
  }) async {
    log('----------- venderKycKYCDocUpload Called ----------');

    isLoading = true;
    update();

    try {
      // ----------------------------------------------------------
      // CHECK REQUIRED DOCUMENTS
      // ----------------------------------------------------------

      if (!allRequiredDocumentsUploaded) {
        return ResponseModel(
          false,
          'Please upload all required documents.',
        );
      }

      // ----------------------------------------------------------
      // LOG SELECTED FILES
      // ----------------------------------------------------------

      for (int i = 0; i < kycDocuments.length; i++) {
        final file = kycDocuments[i];

        log(
          'Document[$i] ${kycDocumentNames[i]} = '
          '${file?.path ?? 'NOT SELECTED'}',
        );
      }

      log('Cancelled Cheque: ${cancelledChequeImage?.path ?? ""}');
      log('Bank Statement: ${bankStatementImage?.path}');
      log('Live Selfie: ${liveSelfieImage?.path}');

      // ----------------------------------------------------------
      // BUILD MULTIPART DATA
      // ----------------------------------------------------------

      final Map<String, dynamic> data = {};

      // 0 - Aadhaar Front
      if (kycDocuments[0] != null) {
        data['aadhaar_front'] = MultipartFile(
          kycDocuments[0]!.path,
          filename: _getFileName(kycDocuments[0]!),
        );
      }

      // 1 - Aadhaar Back
      if (kycDocuments[1] != null) {
        data['aadhaar_back'] = MultipartFile(
          kycDocuments[1]!.path,
          filename: _getFileName(kycDocuments[1]!),
        );
      }

      // 2 - PAN Card
      if (kycDocuments[2] != null) {
        data['pan_card'] = MultipartFile(
          kycDocuments[2]!.path,
          filename: _getFileName(kycDocuments[2]!),
        );
      }

      // 3 - Passport Photo
      if (kycDocuments[3] != null) {
        data['passport_photo'] = MultipartFile(
          kycDocuments[3]!.path,
          filename: _getFileName(kycDocuments[3]!),
        );
      }

      // 4 - GST Certificate
      if (kycDocuments[4] != null) {
        data['gst_certificate'] = MultipartFile(
          kycDocuments[4]!.path,
          filename: _getFileName(kycDocuments[4]!),
        );
      }

      // 5 - Trade Licence
      if (kycDocuments[5] != null) {
        data['trade_licence'] = MultipartFile(
          kycDocuments[5]!.path,
          filename: _getFileName(kycDocuments[5]!),
        );
      }

      // 6 - MSME / Udyam Certificate
      if (kycDocuments[6] != null) {
        data['msme_certificate'] = MultipartFile(
          kycDocuments[6]!.path,
          filename: _getFileName(kycDocuments[6]!),
        );
      }

      // ----------------------------------------------------------
      // EXTRA REQUIRED FILES
      // ----------------------------------------------------------

      // Cancelled Cheque
      data['cancelled_cheque'] = MultipartFile(
        cancelledChequeImage?.path,
        filename: _getFileName(cancelledChequeImage),
      );

      // Bank Statement
      data['bank_statement'] = MultipartFile(
        bankStatementImage?.path,
        filename: _getFileName(bankStatementImage),
      );

      // Live Selfie
      data['self_live_photo'] = MultipartFile(
        liveSelfieImage?.path,
        filename: _getFileName(liveSelfieImage),
      );

      // ----------------------------------------------------------
      // CREATE FORM DATA
      // ----------------------------------------------------------

      final FormData formData = FormData(data);

      log(
        'KYC multipart fields: '
        '${formData.fields.map((e) => '${e.key}=${e.value}').toList()}',
      );

      // ----------------------------------------------------------
      // API CALL
      // ----------------------------------------------------------

      final response = await venderKycRepo.venderKycKYCDocUpload(
        data: formData,
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
          body['message']?.toString() ?? 'KYC documents uploaded successfully',
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
        'ERROR AT venderKycKYCDocUpload(): $e',
        stackTrace: stackTrace,
      );

      return ResponseModel(
        false,
        'Error while uploading KYC documents: $e',
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  String _getFileName(File? file) {
    return file?.path.split(Platform.pathSeparator).last ?? "";
  }
}
