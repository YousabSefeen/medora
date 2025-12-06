/// Configuration class to customize the appearance and behavior of DoctorCard / DoctorSearchCard
class DoctorCardConfig {
  final double imageSize;
  final double imageRadius;

  final bool showFavoriteButton;

  final double nameFontSize;

  final double specialtiesFontSize;

  final double ratingIconSize;

  final double ratingFontSize;

  final int specialtiesMaxLines;

  final int footerMaxLines;

  const DoctorCardConfig({
    required this.imageSize,
    required this.imageRadius,
    required this.showFavoriteButton,
    required this.nameFontSize,
    required this.specialtiesFontSize,
    required this.ratingIconSize,
    required this.ratingFontSize,
    this.specialtiesMaxLines = 2,
    this.footerMaxLines = 1,
  });
}
