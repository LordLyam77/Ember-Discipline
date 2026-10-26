import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class SecurityService {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  static final LocalAuthentication _localAuth = LocalAuthentication();

  static const _pinHashKey = 'user_pin_hash';
  static const _pinSaltKey = 'user_pin_salt';

  /// Save new 4-digit PIN securely
  static Future<void> savePin(String pin) async {
    final salt = DateTime.now().microsecondsSinceEpoch.toString();
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 20000,
      bits: 256,
    );
    final secretKey = SecretKey(utf8.encode(pin));
    final derived = await pbkdf2.deriveKey(
      secretKey: secretKey,
      nonce: utf8.encode(salt),
    );
    final hashBytes = await derived.extractBytes();
    final hashHex = hashBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

    await _secureStorage.write(key: _pinSaltKey, value: salt);
    await _secureStorage.write(key: _pinHashKey, value: hashHex);
  }

  /// Verify entered PIN against stored hash
  static Future<bool> verifyPin(String enteredPin) async {
    final storedSalt = await _secureStorage.read(key: _pinSaltKey);
    final storedHash = await _secureStorage.read(key: _pinHashKey);

    if (storedSalt == null || storedHash == null) {
      return false;
    }

    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 20000,
      bits: 256,
    );
    final secretKey = SecretKey(utf8.encode(enteredPin));
    final derived = await pbkdf2.deriveKey(
      secretKey: secretKey,
      nonce: utf8.encode(storedSalt),
    );
    final hashBytes = await derived.extractBytes();
    final hashHex = hashBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

    return hashHex == storedHash;
  }

  /// Clear stored PIN
  static Future<void> clearPin() async {
    await _secureStorage.delete(key: _pinSaltKey);
    await _secureStorage.delete(key: _pinHashKey);
  }

  /// Check if device supports biometrics
  static Future<bool> canAuthenticateBiometrics() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isSupported = await _localAuth.isDeviceSupported();
      return canCheck || isSupported;
    } catch (_) {
      return false;
    }
  }

  /// Authenticate using Face ID / Fingerprint
  static Future<bool> authenticateBiometrics({String reason = 'Unlock Ember'}) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }
}
