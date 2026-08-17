import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/state_manager.dart';
import 'package:lekra/controllers/card_money_controller/bank_controller.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/kyc_form/components/screen/document_details_screen/document_details_screen.dart';
import 'package:lekra/views/screens/widget/text_box/app_text_box.dart';

class MedSectionOfAccount extends StatelessWidget {
  const MedSectionOfAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BankController>(builder: (bankController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextFieldWithHeading(
            controller: bankController.accountHolderController,
            heading: 'Account Holder Name',
            hindText: 'Enter account holder name',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            preFixWidget: Icon(
              Icons.person_outline,
              color: grey,
            ),
            borderRadius: 12.r,
            borderWidth: 1,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z ]'),
              ),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Place enter a Account Holder Name";
              }
              return null;
            },
          ),
          sizedBoxHeight(height: 16),
          AppTextFieldWithHeading(
            controller: bankController.accountNumberController,
            heading: 'Account Number',
            hindText: 'Enter account number',
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            borderRadius: 12.r,
            borderWidth: 1,
            preFixWidget: Icon(
              Icons.account_balance,
              color: grey,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(18),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Place enter a Account Number";
              }
              if (value.length < 9) {
                return "Place enter a proper account Number";
              }
              return null;
            },
          ),
          sizedBoxHeight(height: 16),
          AppTextFieldWithHeading(
            controller: bankController.ifscController,
            heading: 'IFSC Code',
            hindText: 'Enter IFSC code',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            borderRadius: 12.r,
            borderWidth: 1,
            preFixWidget: Icon(
              Icons.location_on_outlined,
              color: grey,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9]'),
              ),
              UpperCaseTextFormatter(),
              LengthLimitingTextInputFormatter(11),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Place enter a IFSC Code";
              }

              return null;
            },
          ),
          sizedBoxHeight(height: 16),
          AppTextFieldWithHeading(
            controller: bankController.ifscController,
            heading: 'Bank Name',
            hindText: 'Bank name',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            borderRadius: 12.r,
            borderWidth: 1,
            preFixWidget: Icon(
              Icons.account_balance_outlined,
              color: grey,
            ),
          ),
          sizedBoxHeight(height: 26),
        ],
      );
    });
  }
}
