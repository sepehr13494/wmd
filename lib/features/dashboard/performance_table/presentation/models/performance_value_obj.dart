class PerformanceValueObj {
  final String value;
  final bool shouldBlur;
  final bool showTooltip;

  PerformanceValueObj({
    required this.value,
    this.shouldBlur = true,
    this.showTooltip = false,
  });
}
