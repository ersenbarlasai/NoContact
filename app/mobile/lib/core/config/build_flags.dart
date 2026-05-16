/// Build-time flags injected via --dart-define.
///
/// NOSTO_INTERNAL_TEST=true  → internal / closed-test build (test toggle visible)
/// (default: false)           → production build (test toggle hidden)
///
/// Usage:
///   flutter build apk --release --dart-define=NOSTO_INTERNAL_TEST=true
///   flutter build appbundle --release --dart-define=NOSTO_INTERNAL_TEST=true
class BuildFlags {
  const BuildFlags._();

  /// True only when built with --dart-define=NOSTO_INTERNAL_TEST=true
  static const bool isInternalTest =
      bool.fromEnvironment('NOSTO_INTERNAL_TEST', defaultValue: false);
}
