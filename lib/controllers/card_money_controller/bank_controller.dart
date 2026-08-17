import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankController extends GetxController implements GetxService {
  final isLoading = false;

  final TextEditingController accountHolderController = TextEditingController(
    text: 'Rahul Kumar',
  );

  final TextEditingController accountNumberController = TextEditingController(
    text: '123456789012',
  );

  final TextEditingController ifscController = TextEditingController(
    text: 'HDFC0001234',
  );

  final TextEditingController bankNameController = TextEditingController(
    text: 'HDFC Bank',
  );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    accountHolderController.dispose();
    accountNumberController.dispose();
    ifscController.dispose();
    bankNameController.dispose();
  }
}
