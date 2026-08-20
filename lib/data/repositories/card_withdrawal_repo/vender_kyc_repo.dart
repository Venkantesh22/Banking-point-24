import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lekra/data/api/api_client.dart';
import 'package:lekra/services/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VenderKycRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  VenderKycRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> venderKycBasicDetails({
    required Map<String, dynamic> data,
  }) async {
    final apiToken = sharedPreferences.getString(AppConstants.apiToken) ?? '';

    return await apiClient.postData(
      AppConstants.postVenderKycBasicDetails,
      "venderKycBasicDetails",
      data,
      contentType: 'application/json',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      },
    );
  }

  Future<Response> venderKycKYCDocUpload({
    required Map<String, dynamic> data,
  }) async {
    final apiToken = sharedPreferences.getString(AppConstants.apiToken) ?? '';

    return await apiClient.postData(
      AppConstants.postVenderKycKYCDocUpload,
      "venderKycKYCDocUpload",
      data,
      contentType: 'application/json',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      },
    );
  }

  Future<Response> venderKycDocumentDetails({
    required Map<String, dynamic> data,
  }) async {
    final apiToken = sharedPreferences.getString(AppConstants.apiToken) ?? '';

    return await apiClient.postData(
      AppConstants.postVenderKycDocumentDetails,
      "venderKycDocumentDetails",
      data,
      contentType: 'application/json',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiToken',
      },
    );
  }

  Future<Response> venderKycBasicStatus() async {
    final apiToken = sharedPreferences.getString(AppConstants.apiToken) ?? '';

    return await apiClient.getData(
      AppConstants.getVenderKycStatus,
      "venderKycBasicStatus",
      contentType: 'application/json',
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $apiToken',
        'Content-Type': 'application/json',
      },
    );
  }
}
