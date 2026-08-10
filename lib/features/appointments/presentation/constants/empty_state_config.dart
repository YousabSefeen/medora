class EmptyStateConfig {
  final double padding;
  final double lottieSize;
  final double titleSize;
  final double subtitleSize;

  const EmptyStateConfig({
    this.padding = 45,
    this.lottieSize = 200,
    this.titleSize = 18,
    this.subtitleSize = 14,
  });

  // Predefined configurations
  static const appointment = EmptyStateConfig();
  static const booking = EmptyStateConfig(
    padding: 0,
    lottieSize: 100,
    titleSize: 15,
    subtitleSize: 12,
  );
}
