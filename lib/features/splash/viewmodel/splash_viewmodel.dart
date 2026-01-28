import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/hive_service.dart';

final splashProvider = FutureProvider<bool>((ref) async {
  final hive = HiveService();
  final token = await hive.getToken();
  return token != null;
});
