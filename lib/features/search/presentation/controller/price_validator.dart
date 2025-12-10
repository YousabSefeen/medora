class PriceValidator {
  static const double minPrice = 50;
  static const double maxPrice = 1500;

  static String? validatePrice(String? value, {required bool isMinPrice}) {
    if (value == null || value.isEmpty) {
      return 'يجب إدخال قيمة';
    }

    final price = double.tryParse(value);
    if (price == null) {
      return 'قيمة غير صالحة';
    }

    if (isMinPrice) {
      return _validateMinPrice(price);
    } else {
      return _validateMaxPrice(price);
    }
  }

  static String? validatePriceRange(double minPrice, double maxPrice) {
    if (minPrice >= maxPrice) {
      return 'الحد الأدنى يجب أن يكون أقل من الحد الأقصى';
    }
    return null;
  }

  static String? _validateMinPrice(double price) {
    if (price < minPrice) {
      return 'الحد الأدنى هو $minPrice جنيهاً';
    }
    if (price > maxPrice) {
      return 'الحد الأقصى هو $maxPrice جنيهاً';
    }
    return null;
  }

  static String? _validateMaxPrice(double price) {
    if (price > maxPrice) {
      return 'الحد الأقصى هو $maxPrice جنيهاً';
    }
    if (price < minPrice) {
      return 'الحد الأدنى هو $minPrice جنيهاً';
    }
    return null;
  }
}
