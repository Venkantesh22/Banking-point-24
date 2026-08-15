import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditCardController extends GetxController
    implements GetxService {
  // ============================================================
  // CONTROLLERS
  // ============================================================

  final TextEditingController amountController =
      TextEditingController();

  final TextEditingController cardNumberController =
      TextEditingController();

  final TextEditingController expiryDateController =
      TextEditingController();

  final TextEditingController cvvController =
      TextEditingController();

  final TextEditingController cardHolderNameController =
      TextEditingController();

  final List<TextEditingController> otpControllers =
      List.generate(
    6,
    (index) => TextEditingController(),
  );

  // ============================================================
  // WITHDRAWAL DATA
  // ============================================================

  double minimumAmount = 1000;
  double maximumAmount = 100000;
  double availableLimit = 150000;

  double processingFeePercentage = 2.0;
  double gstPercentage = 18.0;

  double processingFee = 0;
  double gst = 0;
  double totalDebit = 0;
  double willGet = 0;

  // ============================================================
  // STATE
  // ============================================================

  bool isAmountValid = false;
  bool isCardValid = false;
  bool isOtpVerified = false;
  bool isProcessing = false;

  // ============================================================
  // OTP
  // ============================================================

  String otp = '';

  void updateOtp() {
    otp = otpControllers
        .map((controller) => controller.text)
        .join();

    isOtpVerified = otp.length == 6;

    update();
  }

  void verifyOtp() {
    if (otp.length != 6) {
      return;
    }

    isOtpVerified = true;
    update();
  }

  // ============================================================
  // AMOUNT
  // ============================================================

  void calculateAmount() {
    final String value =
        amountController.text.trim();

    if (value.isEmpty) {
      processingFee = 0;
      gst = 0;
      totalDebit = 0;
      willGet = 0;
      isAmountValid = false;

      update();
      return;
    }

    final double? amount =
        double.tryParse(value);

    if (amount == null) {
      isAmountValid = false;
      update();
      return;
    }

    isAmountValid =
        amount >= minimumAmount &&
        amount <= maximumAmount &&
        amount <= availableLimit;

    processingFee =
        amount * processingFeePercentage / 100;

    gst =
        processingFee * gstPercentage / 100;

    totalDebit =
        amount + processingFee + gst;

    willGet = amount;

    update();
  }

  // ============================================================
  // CARD VALIDATION
  // ============================================================

  bool validateCard() {
    final String cardNumber =
        cardNumberController.text
            .replaceAll(' ', '')
            .trim();

    final String expiry =
        expiryDateController.text.trim();

    final String cvv =
        cvvController.text.trim();

    final String holder =
        cardHolderNameController.text
            .trim();

    if (cardNumber.length != 16) {
      return false;
    }

    if (expiry.length != 5) {
      return false;
    }

    if (cvv.length != 3) {
      return false;
    }

    if (holder.isEmpty) {
      return false;
    }

    return true;
  }

  // ============================================================
  // SUBMIT WITHDRAWAL
  // ============================================================

  void submitWithdrawal() {
    if (!isAmountValid) {
      return;
    }

    if (!validateCard()) {
      return;
    }

    isCardValid = true;

    debugPrint(
      'Withdrawal amount: ${amountController.text}',
    );

    debugPrint(
      'Card number: ${cardNumberController.text}',
    );

    debugPrint(
      'Expiry date: ${expiryDateController.text}',
    );

    debugPrint(
      'CVV: ${cvvController.text}',
    );

    debugPrint(
      'Card holder: '
      '${cardHolderNameController.text}',
    );

    // API will be added later.

    update();
  }

  // ============================================================
  // TRANSACTION
  // ============================================================

  void completeTransaction() {
    isProcessing = true;
    update();

    debugPrint(
      'Transaction completed locally',
    );

    // API will be added later.

    isProcessing = false;
    update();
  }

  // ============================================================
  // CLEAR
  // ============================================================

  void clearForm() {
    amountController.clear();
    cardNumberController.clear();
    expiryDateController.clear();
    cvvController.clear();
    cardHolderNameController.clear();

    for (final controller in otpControllers) {
      controller.clear();
    }

    processingFee = 0;
    gst = 0;
    totalDebit = 0;
    willGet = 0;

    isAmountValid = false;
    isCardValid = false;
    isOtpVerified = false;
    isProcessing = false;

    otp = '';

    update();
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void onClose() {
    amountController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    cardHolderNameController.dispose();

    for (final controller in otpControllers) {
      controller.dispose();
    }

    super.onClose();
  }
}