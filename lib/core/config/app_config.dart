/// Central application configuration.
/// The app name and core metadata are defined here so they can be changed in one place.
class AppConfig {
  static const String appName = 'Ember';
  static const String appTagline = 'Master Your Discipline, Reclaim Your Flame';
  static const String appVersion = '1.0.0';
  static const String iosBundleId = 'com.emberdiscipline.ember';
  static const String androidPackageName = 'com.emberdiscipline.ember';

  // Support and disclaimer
  static const String disclaimer =
      'Ember is a self-help and personal discipline tool. It does not replace professional medical advice, clinical diagnosis, or psychotherapy. If you are experiencing severe addiction, physical withdrawal, or crisis, please consult a qualified healthcare professional or use the Get Help directory.';

  // Default auto-lock threshold
  static const int defaultBackgroundLockSeconds = 30;
}
