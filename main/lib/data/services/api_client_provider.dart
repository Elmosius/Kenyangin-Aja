import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/data/services/api_client.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());
