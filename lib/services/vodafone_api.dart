import 'dart:convert';
import 'package:http/http.dart' as http;

class VodafoneApi {
  static const String _authUrl = 'http://mobile.vodafone.com.eg/checkSeamless/realms/vf-realm/protocol/openid-connect/auth';
  static const String _tokenUrl = 'https://mobile.vodafone.com.eg/auth/realms/vf-realm/protocol/openid-connect/token';
  static const String _orderUrl = 'https://mobile.vodafone.com.eg/services/dxl/pom/productOrder';

  static Future<Map<String, String>> getSeamlessAndMsisdn() async {
    final params = {'client_id': 'cash-app'};
    final headers = {
      'User-Agent': 'okhttp/4.12.0', 'Accept-Encoding': 'gzip',
      'x-agent-operatingsystem': '16', 'clientId': 'AnaVodafoneAndroid',
      'Accept-Language': 'ar', 'x-agent-device': 'Samsung SM-A165F',
      'x-agent-version': '2025.11.1', 'x-agent-build': '1063',
      'digitalId': '', 'device-id': 'b26ba335813fad21',
      'If-Modified-Since': 'Thu, 02 Apr 2026 09:09:07 GMT',
    };
    final uri = Uri.parse(_authUrl).replace(queryParameters: params);
    final response = await http.get(uri, headers: headers);
    if (response.statusCode != 200) throw Exception('\u0641\u0634\u0644 seamlessToken');
    final data = jsonDecode(response.body);
    String? rawMsisdn = data['msisdn'];
    if (rawMsisdn != null && rawMsisdn.startsWith('1')) rawMsisdn = '0$rawMsisdn';
    return {'seamlessToken': data['seamlessToken'], 'msisdn': rawMsisdn ?? ''};
  }

  static Future<String> getAccessToken(String seamlessToken) async {
    final payload = {
      'grant_type': 'password',
      'client_secret': 'b86e30a8-ae29-467a-a71f-65c73f2ff5e3',
      'client_id': 'cash-app',
    };
    final headers = {
      'User-Agent': 'okhttp/4.12.0', 'Accept': 'application/json',
      'Accept-Encoding': 'gzip', 'silentLogin': 'true', 'CRP': 'false',
      'seamlessToken': seamlessToken, 'firstTimeLogin': 'true',
      'x-agent-operatingsystem': '16', 'clientId': 'AnaVodafoneAndroid',
      'Accept-Language': 'ar', 'x-agent-device': 'Samsung SM-A165F',
      'x-agent-version': '2025.11.1', 'x-agent-build': '1063',
      'digitalId': '', 'device-id': 'b26ba335813fad21',
    };
    final response = await http.post(Uri.parse(_tokenUrl), body: payload, headers: headers);
    if (response.statusCode != 200) throw Exception('\u0641\u0634\u0644 access_token');
    return jsonDecode(response.body)['access_token'];
  }

  static Future<Map<String, dynamic>> placeOrder({
    required String productId, required String senderMsisdn,
    required String receiverMsisdn, required String pin,
    required String accessToken,
  }) async {
    final payload = {
      'channel': {'name': 'MobileApp'},
      'orderItem': [{
        'action': 'insert', 'id': productId, 'product': productId,
        '@type': 'CashFakkaAndMared', 'eCode': 0,
        'characteristic': [
          {'name': 'PaymentMethod', 'value': 'VFCash'},
          {'name': 'USE_EMONEY', 'value': 'False'},
          {'name': 'MerchantCode', 'value': ''},
        ],
        'relatedParty': [
          {'id': senderMsisdn, 'name': 'MSISDN', 'role': 'Subscriber'},
          {'id': receiverMsisdn, 'name': 'Receiver', 'role': 'Receiver'},
        ],
      }],
      'relatedParty': [{'id': pin, 'name': 'pin', 'role': 'Requestor'}],
      '@type': 'CashFakkaAndMared',
    };
    final headers = {
      'User-Agent': 'okhttp/4.12.0', 'Accept': 'application/json',
      'Accept-Encoding': 'gzip', 'api-host': 'ProductOrderingManagement',
      'useCase': 'CashFakkaAndMared', 'X-Request-ID': 'bb81cbe5-0c77-4673-945e-d2c0de90007a',
      'device-id': 'b26ba335813fad21', 'api-version': 'v2',
      'msisdn': senderMsisdn, 'Authorization': 'Bearer $accessToken',
      'Accept-Language': 'ar', 'x-agent-operatingsystem': '16',
      'clientId': 'AnaVodafoneAndroid', 'x-agent-device': 'Samsung SM-A165F',
      'x-agent-version': '2025.11.1', 'x-agent-build': '1063',
      'digitalId': '', 'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.post(Uri.parse(_orderUrl), headers: headers, body: jsonEncode(payload));
    if (response.statusCode == 200) {
      try { return jsonDecode(response.body); } catch (_) { return {'status': 'success'}; }
    } else {
      return {'status': 'error', 'message': '\u0641\u0634\u0644: ${response.statusCode}'};
    }
  }
}