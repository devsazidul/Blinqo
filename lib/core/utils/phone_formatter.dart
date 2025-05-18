import 'package:blinqo/core/common/widgets/logger_view.dart';

class PhoneNumberFormatResult {
  final bool isValid;
  final String? formattedNumber;
  final String? errorMessage;

  PhoneNumberFormatResult({
    required this.isValid,
    this.formattedNumber,
    this.errorMessage,
  });
}

String? formatToE164(String phoneNumber) {
  final _logger = createLogger();

  try {
    // First, let's clean the number thoroughly
    String cleanNumber = phoneNumber
        .replaceAll(
          RegExp(r'[\s\-\(\)]'),
          '',
        ) // Remove spaces, hyphens, parentheses
        .replaceAll(
          RegExp(r'[^\d+]'),
          '',
        ); // Then remove any remaining non-digit chars except +

    // If the number starts with 00, replace it with +
    if (cleanNumber.startsWith('00')) {
      cleanNumber = '+${cleanNumber.substring(2)}';
    }

    // If number doesn't start with +, assume it's a BD number
    if (!cleanNumber.startsWith('+')) {
      // Remove leading 0 if present
      if (cleanNumber.startsWith('0')) {
        cleanNumber = cleanNumber.substring(1);
      }

      // Add BD country code if not present
      if (!cleanNumber.startsWith('880')) {
        cleanNumber = '880$cleanNumber';
      }

      cleanNumber = '+$cleanNumber';
    }

    // Basic validation
    final digitsOnly = cleanNumber.substring(1); // Remove the + for counting
    if (digitsOnly.length < 10 || digitsOnly.length > 15) {
      _logger.w('Invalid number length: ${digitsOnly.length} digits');
      return null;
    }

    _logger.i('Successfully formatted number: $cleanNumber');
    return cleanNumber;
  } catch (e) {
    _logger.e('Error formatting phone number: $e');
    return null;
  }
}
