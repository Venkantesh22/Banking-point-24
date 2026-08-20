import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lekra/data/api/api_client.dart';
import 'package:lekra/services/constants.dart';

class CustomKycRepo {
  final ApiClient apiClient;

  CustomKycRepo({required this.apiClient});

  Future<Response> submitCustomKyc({required FormData data}) async =>
      await apiClient.postData(
        AppConstants.postSubmitCustomKyc,
        "submitCustomKyc",
        data,
      );

  Future<Response> submitCustomKycLivePhoto({required FormData data}) async =>
      await apiClient.postData(
        AppConstants.postSubmitCustomKycLivePhoto,
        "submitCustomKycLivePhoto",
        data,
      );

  Future<Response> confirmAndTransaction({required FormData data}) async =>
      await apiClient.postData(
        AppConstants.postConfirmAndTransaction,
        "confirmAndTransaction",
        data,
      );

  Future<Response> creditCardCashWithdrawalTransactionStatus(
          {required String transactionId}) async =>
      await apiClient.getData(
        AppConstants.getCreditCardCashWithdrawalTransactionStatus(
            transactionId: transactionId),
        "creditCardCashWithdrawalTransactionStatus",
      );
}
