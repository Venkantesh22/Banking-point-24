import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lekra/data/api/api_client.dart';
import 'package:lekra/services/constants.dart';

class CreditCardRepo {
  final ApiClient apiClient;

  CreditCardRepo({required this.apiClient});

  Future<Response> submitCreditCardInfo({required FormData data}) async =>
      await apiClient.postData(
        AppConstants.postSubmitCreditCardInfo,
        "submitCreditCardInfo",
        data,
      );

  Future<Response> submitCreditCardWithdrawalAmount(
          {required FormData data}) async =>
      await apiClient.postData(
        AppConstants.postSubmitCreditCardWithdrawalAmount,
        "submitCreditCardWithdrawalAmount",
        data,
      );

  Future<Response> sendCreditCardOTP({required FormData data}) async =>
      await apiClient.postData(
        AppConstants.postSendCreditCardOTP,
        "sendCreditCardOTP",
        data,
      );
      
  Future<Response> creditCardOTPVerify({required FormData data}) async =>
      await apiClient.postData(
        AppConstants.postCreditCardOTPVerify,
        "creditCardOTPVerify",
        data,
      );
}
