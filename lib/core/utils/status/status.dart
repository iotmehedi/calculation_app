import 'package:logger/logger.dart';

enum ValidationStatus {
  none,
  all,
  invalidUserId,
  invalidPassword,
}
final logger = Logger();