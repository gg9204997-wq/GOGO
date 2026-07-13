import 'package:joojo_chat/core/constants/app_constants.dart';
import 'package:joojo_chat/core/extensions/string_extensions.dart';

abstract final class InputValidators {
  const InputValidators._();

  static bool isValidDisplayName(String value) {
    final String normalizedValue = value.normalized;
    return normalizedValue.length >= AppConstants.minDisplayNameLength &&
        normalizedValue.length <= AppConstants.maxDisplayNameLength;
  }

  static bool isValidRoomName(String value) {
    final String normalizedValue = value.normalized;
    return normalizedValue.length >= AppConstants.minRoomNameLength &&
        normalizedValue.length <= AppConstants.maxRoomNameLength;
  }

  static bool isValidEmail(String value) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim());
  }
}
