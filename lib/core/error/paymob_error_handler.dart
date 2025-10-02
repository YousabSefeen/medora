class PaymobErrorHandler {
  static String getErrorMessage(String? rawMessage) {
    print(rawMessage); //Invalid card number
    if (rawMessage == null || rawMessage.isEmpty) {
      return "An unknown error occurred. Please try again.";
    }

    // Decode the message
    String decodedMessage = Uri.decodeComponent(rawMessage);

    switch (decodedMessage) {
      // This case occurs when an invalid card number is entered, and the message starts with a capital letter "Invalid Card Number".
      case 'Invalid Card Number':
        return 'The Card Number you entered is invalid. Please check and try again.';
      // This case indicates an expired card or incorrect card details, and the message starts with lowercase letters "Invalid card number".
      case 'Invalid card number':
        return 'Your bank declined the transaction due to an invalid or incorrectly entered card number. Please check the card details ( Number, Expiration Date, and CVV ) and ensure the card is activated.';

      case 'Insufficient Funds':
        return 'You have insufficient funds to complete this transaction.';
      case 'Expired Card':
        return 'Your card has expired. Please use another payment method.';
      case 'Transaction Not Allowed':
        return 'This transaction is not allowed for your card. Please contact your bank.';
      case 'Authentication Failed':
        return 'Authentication failed. Please verify your card details.';
      case 'Invalid CVV':
        return 'The CVV code you entered is incorrect. Please check and try again.';
      case 'Card Blocked':
        return 'Your card is blocked. Please contact your bank for support.';
      default:
        return 'An error occurred during payment. Please try again or use another payment method.';
    }
  }
}
