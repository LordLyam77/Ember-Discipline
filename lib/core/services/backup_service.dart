import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cryptography/cryptography.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../data/local/database/app_database.dart';

class BackupService {
  static const int _pbkdf2Iterations = 50000;

  /// Encrypt and export the entire database to a secure file
  static Future<String> createEncryptedBackupString(
    AppDatabase db,
    String password,
  ) async {
    // 1. Gather all table data
    final allHabits = await db.select(db.habits).get();
    final allStreakEvents = await db.select(db.streakEvents).get();
    final allUrges = await db.select(db.urges).get();
    final allSlips = await db.select(db.slips).get();
    final allCheckins = await db.select(db.checkins).get();
    final allMissionProgress = await db.select(db.missionProgress).get();
    final allUserState = await db.select(db.userState).get();
    final allSkills = await db.select(db.skills).get();
    final allBadges = await db.select(db.badges).get();
    final allPlaybook = await db.select(db.playbook).get();
    final allLetters = await db.select(db.letters).get();
    final allLifeWheel = await db.select(db.lifeWheel).get();

    final dataPayload = {
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'tables': {
        'habits': allHabits.map((e) => e.toJson()).toList(),
        'streakEvents': allStreakEvents.map((e) => e.toJson()).toList(),
        'urges': allUrges.map((e) => e.toJson()).toList(),
        'slips': allSlips.map((e) => e.toJson()).toList(),
        'checkins': allCheckins.map((e) => e.toJson()).toList(),
        'missionProgress': allMissionProgress.map((e) => e.toJson()).toList(),
        'userState': allUserState.map((e) => e.toJson()).toList(),
        'skills': allSkills.map((e) => e.toJson()).toList(),
        'badges': allBadges.map((e) => e.toJson()).toList(),
        'playbook': allPlaybook.map((e) => e.toJson()).toList(),
        'letters': allLetters.map((e) => e.toJson()).toList(),
        'lifeWheel': allLifeWheel.map((e) => e.toJson()).toList(),
      },
    };

    final plainJson = jsonEncode(dataPayload);

    // 2. Derive key with PBKDF2
    final random = Random.secure();
    final saltBytes = List<int>.generate(16, (_) => random.nextInt(256));

    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: _pbkdf2Iterations,
      bits: 256,
    );

    final secretKey = await pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(password)),
      nonce: saltBytes,
    );

    // 3. Encrypt with AES-GCM 256
    final aesGcm = AesGcm.with256bits();
    final nonce = aesGcm.newNonce();
    final secretBox = await aesGcm.encrypt(
      utf8.encode(plainJson),
      secretKey: secretKey,
      nonce: nonce,
    );

    // 4. Output envelope
    final envelope = {
      'cipher': 'aes-256-gcm',
      'kdf': 'pbkdf2-hmac-sha256',
      'iterations': _pbkdf2Iterations,
      'salt': base64Encode(saltBytes),
      'nonce': base64Encode(secretBox.nonce),
      'mac': base64Encode(secretBox.mac.bytes),
      'ciphertext': base64Encode(secretBox.cipherText),
    };

    return jsonEncode(envelope);
  }

  /// Save backup string to a file and prompt share dialog
  static Future<void> exportAndShareBackup(
    AppDatabase db,
    String password,
  ) async {
    final encryptedData = await createEncryptedBackupString(db, password);
    final tempDir = await getTemporaryDirectory();
    final timestamp = DateTime.now()
        .toIso8601String()
        .replaceAll(':', '-')
        .split('.')
        .first;
    final file = File('${tempDir.path}/ember_backup_$timestamp.ember');
    await file.writeAsString(encryptedData);

    await Share.shareXFiles(
      [XFile(file.path)],
      subject: 'Ember Encrypted Backup',
      text: 'Encrypted backup of Ember Discipline data.',
    );
  }

  /// Restore encrypted backup into the database
  static Future<bool> restoreBackupFromString(
    AppDatabase db,
    String backupJson,
    String password,
  ) async {
    try {
      final envelope = jsonDecode(backupJson) as Map<String, dynamic>;
      final iterations = envelope['iterations'] as int? ?? _pbkdf2Iterations;
      final saltBytes = base64Decode(envelope['salt'] as String);
      final nonceBytes = base64Decode(envelope['nonce'] as String);
      final macBytes = base64Decode(envelope['mac'] as String);
      final cipherBytes = base64Decode(envelope['ciphertext'] as String);

      final pbkdf2 = Pbkdf2(
        macAlgorithm: Hmac.sha256(),
        iterations: iterations,
        bits: 256,
      );

      final secretKey = await pbkdf2.deriveKey(
        secretKey: SecretKey(utf8.encode(password)),
        nonce: saltBytes,
      );

      final aesGcm = AesGcm.with256bits();
      final secretBox = SecretBox(
        cipherBytes,
        nonce: nonceBytes,
        mac: Mac(macBytes),
      );

      final decryptedBytes = await aesGcm.decrypt(
        secretBox,
        secretKey: secretKey,
      );

      final decryptedString = utf8.decode(decryptedBytes);
      final dataPayload = jsonDecode(decryptedString) as Map<String, dynamic>;
      final tables = dataPayload['tables'] as Map<String, dynamic>;

      // Perform atomic restore
      await db.transaction(() async {
        await db.wipeAllData();

        final habitsList = (tables['habits'] as List? ?? [])
            .map((j) => Habit.fromJson(j as Map<String, dynamic>))
            .toList();
        for (final item in habitsList) {
          await db.into(db.habits).insert(item);
        }

        final streakEventsList = (tables['streakEvents'] as List? ?? [])
            .map((j) => StreakEvent.fromJson(j as Map<String, dynamic>))
            .toList();
        for (final item in streakEventsList) {
          await db.into(db.streakEvents).insert(item);
        }

        final urgesList = (tables['urges'] as List? ?? [])
            .map((j) => Urge.fromJson(j as Map<String, dynamic>))
            .toList();
        for (final item in urgesList) {
          await db.into(db.urges).insert(item);
        }

        final slipsList = (tables['slips'] as List? ?? [])
            .map((j) => Slip.fromJson(j as Map<String, dynamic>))
            .toList();
        for (final item in slipsList) {
          await db.into(db.slips).insert(item);
        }

        final checkinsList = (tables['checkins'] as List? ?? [])
            .map((j) => Checkin.fromJson(j as Map<String, dynamic>))
            .toList();
        for (final item in checkinsList) {
          await db.into(db.checkins).insert(item);
        }

        final missionProgressList = (tables['missionProgress'] as List? ?? [])
            .map((j) => MissionProgressData.fromJson(j as Map<String, dynamic>))
            .toList();
        for (final item in missionProgressList) {
          await db.into(db.missionProgress).insert(item);
        }

        final userStateList = (tables['userState'] as List? ?? [])
            .map((j) => UserStateData.fromJson(j as Map<String, dynamic>))
            .toList();
        for (final item in userStateList) {
          await db.into(db.userState).insert(item);
        }

        final skillsList = (tables['skills'] as List? ?? [])
            .map((j) => Skill.fromJson(j as Map<String, dynamic>))
            .toList();
        for (final item in skillsList) {
          await db.into(db.skills).insert(item);
        }

        final badgesList = (tables['badges'] as List? ?? [])
            .map((j) => Badge.fromJson(j as Map<String, dynamic>))
            .toList();
        for (final item in badgesList) {
          await db.into(db.badges).insert(item);
        }

        final playbookList = (tables['playbook'] as List? ?? [])
            .map((j) => PlaybookData.fromJson(j as Map<String, dynamic>))
            .toList();
        for (final item in playbookList) {
          await db.into(db.playbook).insert(item);
        }

        final lettersList = (tables['letters'] as List? ?? [])
            .map((j) => Letter.fromJson(j as Map<String, dynamic>))
            .toList();
        for (final item in lettersList) {
          await db.into(db.letters).insert(item);
        }

        final lifeWheelList = (tables['lifeWheel'] as List? ?? [])
            .map((j) => LifeWheelData.fromJson(j as Map<String, dynamic>))
            .toList();
        for (final item in lifeWheelList) {
          await db.into(db.lifeWheel).insert(item);
        }
      });

      return true;
    } catch (_) {
      return false;
    }
  }

  /// Pick a backup file from device storage
  static Future<String?> pickBackupFileContent() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      return await file.readAsString();
    }
    return null;
  }
}
