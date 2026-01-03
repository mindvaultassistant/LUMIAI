import 'package:http/http.dart' as http;
import '../core/api_config.dart';

class HealthService {
  static Future<bool> ping() async {
    final res = await http.get(Uri.parse(ApiConfig.baseUrl));
    return res.statusCode == 200;
  }
}
