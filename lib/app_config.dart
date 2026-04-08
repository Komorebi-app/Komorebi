import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String apiUrl = dotenv.get('API_URL');
}
