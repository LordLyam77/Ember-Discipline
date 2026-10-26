import 'dart:convert';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../core/services/backup_service.dart';
import '../../core/services/security_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/gamification_calculator.dart';
import '../../data/local/database/app_database.dart';
import '../../data/repositories/ember_repository.dart';
import '../../widgets/ember_card.dart';
import '../../widgets/progress_bar_shine.dart';
import '../../widgets/streak_flame.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _canUseBiometrics = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricsSupport();
  }

  Future<void> _checkBiometricsSupport() async {
    final supported = await SecurityService.canAuthenticateBiometrics();
    if (mounted) {
      setState(() => _canUseBiometrics = supported);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userStateStreamProvider).value ??
        UserStateData(
          id: 'default',
          xp: 0,
          level: 1,
          currentStage: 1,
          currentWeek: 1,
          weekStartAt: DateTime(2026, 1, 1),
          shields: 1,
        );
    final badgesAsync = ref.watch(badgesStreamProvider);
    final playbookAsync = ref.watch(playbookStreamProvider);
    final lettersAsync = ref.watch(lettersStreamProvider);
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final progress = GamificationCalculator.levelProgress(userState.xp);
    final title = GamificationCalculator.titleForLevel(userState.level);

    return Scaffold(
      backgroundColor: EmberColors.background,
      appBar: AppBar(
        title: const Text('Discipline Profile & Sanctuary'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 90),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. User Header & Level
            _buildProfileHeader(userState, title, progress),
            const SizedBox(height: 24),

            // 2. Badges Showcase
            _buildBadgesSection(badgesAsync.value ?? []),
            const SizedBox(height: 24),

            // 3. Tactical Playbook
            _buildPlaybookSection(playbookAsync.value ?? []),
            const SizedBox(height: 24),

            // 4. Letters to Future Self
            _buildLettersSection(lettersAsync.value ?? []),
            const SizedBox(height: 24),

            // 5. Security & Privacy Sanctuary
            _buildSecuritySection(settings, settingsNotifier),
            const SizedBox(height: 24),

            // 6. Preferences
            _buildPreferencesSection(settings, settingsNotifier),
            const SizedBox(height: 24),

            // 7. Crisis Helplines
            _buildCrisisHelplineCard(),
            const SizedBox(height: 24),

            // 8. Encrypted Backup & Data Safety
            _buildDataManagementSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
    UserStateData userState,
    String title,
    ({double progress, int currentLevelXp, int nextLevelRequiredXp}) progress,
  ) {
    return EmberCard(
      hasGlow: true,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              const StreakFlame(size: 58),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: EmberColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Level ${userState.level} Warrior • Stage ${userState.currentStage}, Week ${userState.currentWeek}',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: EmberColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: EmberColors.cardElevated,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: EmberColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.shield, color: EmberColors.brightOrange, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${userState.shields} / 2',
                      style: const TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: EmberColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ProgressBarShine(
            progress: progress.progress,
            height: 8,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${userState.xp} Total XP',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: EmberColors.textSecondary,
                ),
              ),
              Text(
                '${progress.nextLevelRequiredXp - progress.currentLevelXp} XP to Level ${userState.level + 1}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: EmberColors.primaryOrange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadgesSection(List<Badge> earned) {
    final earnedIds = earned.map((b) => b.badgeId).toSet();

    final allBadges = [
      {'id': 'first_urge_survived', 'name': 'First Victory', 'desc': 'Survive your first urge with SOS or breathing', 'icon': Icons.bolt},
      {'id': '10_urges_survived', 'name': 'Iron Will', 'desc': 'Survive 10 difficult urges cleanly', 'icon': Icons.fitness_center},
      {'id': 'week_completed', 'name': 'Pillar of Light', 'desc': 'Complete a full 7-day stage week', 'icon': Icons.calendar_month},
      {'id': 'first_comeback', 'name': 'The Phoenix', 'desc': 'Log a slip honestly and immediately start anew', 'icon': Icons.replay},
      {'id': 'level_5', 'name': 'Apprentice Flame', 'desc': 'Reach Level 5 through missions and check-ins', 'icon': Icons.stars},
      {'id': 'level_10', 'name': 'Ember Adept', 'desc': 'Reach Level 10 of disciplined mastery', 'icon': Icons.auto_awesome},
      {'id': 'stage_1_boss', 'name': 'Dragon Slayer', 'desc': 'Conquer the Stage 1 final boss mission', 'icon': Icons.military_tech},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Honored Badges',
              style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: EmberColors.textPrimary,
              ),
            ),
            Text(
              '${earnedIds.length} / ${allBadges.length} Unlocked',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: EmberColors.primaryOrange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: allBadges.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final badge = allBadges[index];
              final isUnlocked = earnedIds.contains(badge['id']);
              return Tooltip(
                message: '${badge['name']}: ${badge['desc']}',
                child: Container(
                  width: 100,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isUnlocked ? EmberColors.cardElevated : EmberColors.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isUnlocked ? EmberColors.primaryOrange : EmberColors.border,
                      width: isUnlocked ? 1.5 : 0.8,
                    ),
                    boxShadow: isUnlocked
                        ? [
                            BoxShadow(
                              color: EmberColors.primaryOrange.withAlpha(50),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        badge['icon'] as IconData,
                        size: 32,
                        color: isUnlocked ? EmberColors.brightOrange : EmberColors.textTertiary,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        badge['name'] as String,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          fontWeight: isUnlocked ? FontWeight.bold : FontWeight.normal,
                          color: isUnlocked ? EmberColors.textPrimary : EmberColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPlaybookSection(List<PlaybookData> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Tactical Playbook (If-Then)',
              style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: EmberColors.textPrimary,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline, color: EmberColors.primaryOrange),
              onPressed: _showAddPlaybookDialog,
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (items.isEmpty)
          EmberCard(
            child: Row(
              children: [
                const Icon(Icons.psychology_outlined, color: EmberColors.textSecondary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'No battle plans yet. Create an If-Then rule to execute automatically when triggers appear.',
                    style: TextStyle(fontSize: 13, color: EmberColors.textSecondary.withAlpha(200)),
                  ),
                ),
              ],
            ),
          )
        else
          Column(
            children: items.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: EmberCard(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.shield_outlined, color: EmberColors.primaryOrange, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'IF: ${item.ifText}',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: EmberColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'THEN: ${item.thenText}',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                color: EmberColors.brightOrange,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, size: 18, color: EmberColors.textTertiary),
                        onPressed: () async {
                          final db = ref.read(databaseProvider);
                          await db.deletePlaybook(item.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  void _showAddPlaybookDialog() {
    final ifController = TextEditingController();
    final thenController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: EmberColors.card,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: const Text('Add Tactical If-Then Plan', style: TextStyle(fontFamily: 'Sora', fontSize: 18)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ifController,
                decoration: const InputDecoration(
                  labelText: 'IF (Specific Trigger or Context)',
                  hintText: 'e.g. Alone late at night with phone',
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: thenController,
                decoration: const InputDecoration(
                  labelText: 'THEN (Immediate physical action)',
                  hintText: 'e.g. Leave phone in living room & drink water',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel', style: TextStyle(color: EmberColors.textSecondary)),
            ),
            ElevatedButton(
              onPressed: () async {
                final ifText = ifController.text.trim();
                final thenText = thenController.text.trim();
                if (ifText.isNotEmpty && thenText.isNotEmpty) {
                  final db = ref.read(databaseProvider);
                  await db.insertPlaybook(
                    PlaybookCompanion(
                      id: drift.Value(const Uuid().v4()),
                      triggerTag: const drift.Value('custom'),
                      ifText: drift.Value(ifText),
                      thenText: drift.Value(thenText),
                    ),
                  );
                  if (ctx.mounted) Navigator.pop(ctx);
                }
              },
              child: const Text('Save Plan'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLettersSection(List<Letter> letters) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Letters to Future Self',
              style: TextStyle(
                fontFamily: 'Sora',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: EmberColors.textPrimary,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit_note_outlined, color: EmberColors.primaryOrange),
              onPressed: _showWriteLetterDialog,
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (letters.isEmpty)
          EmberCard(
            child: Row(
              children: [
                const Icon(Icons.mail_outline, color: EmberColors.textSecondary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Write a letter when you feel strong and clear. Open it when temptation strikes.',
                    style: TextStyle(fontSize: 13, color: EmberColors.textSecondary.withAlpha(200)),
                  ),
                ),
              ],
            ),
          )
        else
          Column(
            children: letters.map((letter) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: EmberCard(
                  onTap: () => _viewLetterDialog(letter),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.mark_email_read_outlined, color: EmberColors.primaryOrange),
                    title: Text(
                      letter.title,
                      style: const TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: EmberColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      'Written on ${letter.createdAt.month}/${letter.createdAt.day}/${letter.createdAt.year}',
                      style: const TextStyle(fontSize: 12, color: EmberColors.textSecondary),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: EmberColors.textTertiary),
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  void _showWriteLetterDialog() {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: EmberColors.card,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: const Text('Letter to My Future Self', style: TextStyle(fontFamily: 'Sora', fontSize: 18)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Subject / Title',
                    hintText: 'e.g. Read this when you feel weak',
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: bodyController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Message to Future You',
                    hintText: 'Remind yourself who you are, how far you have come, and why temporary numbness is a lie...',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel', style: TextStyle(color: EmberColors.textSecondary)),
            ),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text.trim();
                final body = bodyController.text.trim();
                if (title.isNotEmpty && body.isNotEmpty) {
                  final db = ref.read(databaseProvider);
                  await db.insertLetter(
                    LettersCompanion(
                      id: drift.Value(const Uuid().v4()),
                      createdAt: drift.Value(DateTime.now()),
                      title: drift.Value(title),
                      body: drift.Value(body),
                    ),
                  );
                  if (ctx.mounted) Navigator.pop(ctx);
                }
              },
              child: const Text('Seal Letter'),
            ),
          ],
        );
      },
    );
  }

  void _viewLetterDialog(Letter letter) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: EmberColors.card,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: Text(letter.title, style: const TextStyle(fontFamily: 'Sora', fontSize: 18)),
          content: SingleChildScrollView(
            child: Text(
              letter.body,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                height: 1.5,
                color: EmberColors.textPrimary,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSecuritySection(AppSettings settings, SettingsNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Security & Privacy',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        EmberCard(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Passcode (PIN) Lock', style: TextStyle(fontFamily: 'Sora', fontSize: 15)),
                subtitle: const Text('Require 4-digit PIN to open Ember', style: TextStyle(fontSize: 12, color: EmberColors.textSecondary)),
                value: settings.pinLockEnabled,
                activeTrackColor: EmberColors.primaryOrange,
                onChanged: (enabled) async {
                  if (enabled) {
                    _promptSetPin(notifier);
                  } else {
                    final verified = await _promptVerifyPin();
                    if (verified) {
                      await SecurityService.clearPin();
                      await notifier.setPinLockEnabled(false);
                    }
                  }
                },
              ),
              if (_canUseBiometrics && settings.pinLockEnabled) ...[
                const Divider(color: EmberColors.border, height: 1),
                SwitchListTile(
                  title: const Text('Biometric Unlock', style: TextStyle(fontFamily: 'Sora', fontSize: 15)),
                  subtitle: const Text('Unlock with Face ID or Fingerprint', style: TextStyle(fontSize: 12, color: EmberColors.textSecondary)),
                  value: settings.biometricsEnabled,
                  activeTrackColor: EmberColors.primaryOrange,
                  onChanged: (enabled) async {
                    if (enabled) {
                      final authenticated = await SecurityService.authenticateBiometrics(
                        reason: 'Verify identity to enable biometrics',
                      );
                      if (authenticated) {
                        await notifier.setBiometricsEnabled(true);
                      }
                    } else {
                      await notifier.setBiometricsEnabled(false);
                    }
                  },
                ),
              ],
              const Divider(color: EmberColors.border, height: 1),
              SwitchListTile(
                title: const Text('App Switcher Privacy Blur', style: TextStyle(fontFamily: 'Sora', fontSize: 15)),
                subtitle: const Text('Blur app content in recent apps preview', style: TextStyle(fontSize: 12, color: EmberColors.textSecondary)),
                value: settings.privacyBlurEnabled,
                activeTrackColor: EmberColors.primaryOrange,
                onChanged: (enabled) => notifier.setPrivacyBlur(enabled),
              ),
              const Divider(color: EmberColors.border, height: 1),
              ListTile(
                title: const Text('Auto-Lock Timeout', style: TextStyle(fontFamily: 'Sora', fontSize: 15)),
                subtitle: Text(
                  _formatAutoLock(settings.autoLockSeconds),
                  style: const TextStyle(fontSize: 12, color: EmberColors.textSecondary),
                ),
                trailing: DropdownButton<int>(
                  value: settings.autoLockSeconds,
                  dropdownColor: EmberColors.cardElevated,
                  underline: const SizedBox.shrink(),
                  items: const [
                    DropdownMenuItem(value: 0, child: Text('Immediately')),
                    DropdownMenuItem(value: 30, child: Text('30 Seconds')),
                    DropdownMenuItem(value: 60, child: Text('1 Minute')),
                    DropdownMenuItem(value: 300, child: Text('5 Minutes')),
                  ],
                  onChanged: (val) {
                    if (val != null) notifier.setAutoLockSeconds(val);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatAutoLock(int seconds) {
    if (seconds == 0) return 'Lock immediately when backgrounded';
    if (seconds < 60) return 'Lock after $seconds seconds';
    return 'Lock after ${seconds ~/ 60} minute(s)';
  }

  void _promptSetPin(SettingsNotifier notifier) {
    final pinController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: EmberColors.card,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: const Text('Set 4-Digit Passcode', style: TextStyle(fontFamily: 'Sora', fontSize: 18)),
          content: TextField(
            controller: pinController,
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 4,
            decoration: const InputDecoration(hintText: 'Enter 4 digits'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel', style: TextStyle(color: EmberColors.textSecondary)),
            ),
            ElevatedButton(
              onPressed: () async {
                final pin = pinController.text.trim();
                if (pin.length == 4) {
                  await SecurityService.savePin(pin);
                  await notifier.setPinLockEnabled(true);
                  if (ctx.mounted) Navigator.pop(ctx);
                }
              },
              child: const Text('Save PIN'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _promptVerifyPin() async {
    final pinController = TextEditingController();
    final verified = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: EmberColors.card,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: const Text('Confirm PIN', style: TextStyle(fontFamily: 'Sora', fontSize: 18)),
          content: TextField(
            controller: pinController,
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 4,
            decoration: const InputDecoration(hintText: 'Current 4-digit PIN'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel', style: TextStyle(color: EmberColors.textSecondary)),
            ),
            ElevatedButton(
              onPressed: () async {
                final ok = await SecurityService.verifyPin(pinController.text.trim());
                if (ctx.mounted) Navigator.pop(ctx, ok);
              },
              child: const Text('Verify'),
            ),
          ],
        );
      },
    );
    return verified ?? false;
  }

  Widget _buildPreferencesSection(AppSettings settings, SettingsNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'App Preferences',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        EmberCard(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Reduce Motion', style: TextStyle(fontFamily: 'Sora', fontSize: 15)),
                subtitle: const Text('Reduces flame and button shine animations', style: TextStyle(fontSize: 12, color: EmberColors.textSecondary)),
                value: settings.reduceMotion,
                activeTrackColor: EmberColors.primaryOrange,
                onChanged: (val) => notifier.setReduceMotion(val),
              ),
              const Divider(color: EmberColors.border, height: 1),
              ListTile(
                title: const Text('Daily Check-In Reminder', style: TextStyle(fontFamily: 'Sora', fontSize: 15)),
                subtitle: Text(
                  settings.notificationTime ?? 'Not set',
                  style: const TextStyle(fontSize: 12, color: EmberColors.textSecondary),
                ),
                trailing: const Icon(Icons.access_time, color: EmberColors.primaryOrange),
                onTap: () async {
                  final initial = settings.notificationTime != null
                      ? TimeOfDay(
                          hour: int.parse(settings.notificationTime!.split(':').first),
                          minute: int.parse(settings.notificationTime!.split(':').last),
                        )
                      : const TimeOfDay(hour: 20, minute: 30);

                  final picked = await showTimePicker(
                    context: context,
                    initialTime: initial,
                  );
                  if (picked != null) {
                    final formatted =
                        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                    await notifier.setNotificationTime(formatted);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCrisisHelplineCard() {
    return EmberCard(
      backgroundColor: EmberColors.cardElevated,
      onTap: _showHelplinesModal,
      child: const Row(
        children: [
          Icon(Icons.support_agent_rounded, color: EmberColors.primaryOrange, size: 28),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crisis Helplines & Support',
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: EmberColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Free, 24/7 confidential professional mental health resources',
                  style: TextStyle(fontSize: 12, color: EmberColors.textSecondary),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 14, color: EmberColors.textTertiary),
        ],
      ),
    );
  }

  Future<void> _showHelplinesModal() async {
    try {
      final jsonStr = await rootBundle.loadString('assets/helplines.json');
      final list = jsonDecode(jsonStr) as List;

      if (!mounted) return;
      showModalBottomSheet(
        context: context,
        backgroundColor: EmberColors.card,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (ctx) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '24/7 Crisis & Mental Health Helplines',
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: EmberColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'You are not alone. Reach out for confidential support anytime.',
                    style: TextStyle(fontSize: 13, color: EmberColors.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  ...list.map((item) {
                    final data = item as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: EmberCard(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data['name'] as String,
                                  style: const TextStyle(
                                    fontFamily: 'Sora',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: EmberColors.textPrimary,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: EmberColors.primaryOrange.withAlpha(40),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    data['phone'] as String,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.bold,
                                      color: EmberColors.brightOrange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${data['country']} • ${data['note']}',
                              style: const TextStyle(fontSize: 12, color: EmberColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        },
      );
    } catch (_) {}
  }

  Widget _buildDataManagementSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Data Sovereignty & Safety',
          style: TextStyle(
            fontFamily: 'Sora',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        EmberCard(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.lock_clock_outlined, color: EmberColors.primaryOrange),
                title: const Text('Export Encrypted Backup', style: TextStyle(fontFamily: 'Sora', fontSize: 15)),
                subtitle: const Text('AES-GCM 256-bit encrypted archive with password', style: TextStyle(fontSize: 12, color: EmberColors.textSecondary)),
                onTap: _exportBackupDialog,
              ),
              const Divider(color: EmberColors.border, height: 1),
              ListTile(
                leading: const Icon(Icons.restore_page_outlined, color: EmberColors.primaryOrange),
                title: const Text('Restore from Backup', style: TextStyle(fontFamily: 'Sora', fontSize: 15)),
                subtitle: const Text('Import encrypted .ember archive', style: TextStyle(fontSize: 12, color: EmberColors.textSecondary)),
                onTap: _restoreBackupDialog,
              ),
              const Divider(color: EmberColors.border, height: 1),
              ListTile(
                leading: const Icon(Icons.delete_forever_outlined, color: EmberColors.slipWarning),
                title: const Text('Emergency Data Wipe', style: TextStyle(fontFamily: 'Sora', fontSize: 15, color: EmberColors.slipWarning)),
                subtitle: const Text('Permanently deletes all records from device immediately', style: TextStyle(fontSize: 12, color: EmberColors.textSecondary)),
                onTap: _confirmEmergencyWipe,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _exportBackupDialog() {
    final passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: EmberColors.card,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: const Text('Export Encrypted Backup', style: TextStyle(fontFamily: 'Sora', fontSize: 18)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Enter a strong encryption passphrase. Without this password, the backup file cannot be decrypted.',
                style: TextStyle(fontSize: 13, color: EmberColors.textSecondary),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Passphrase'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel', style: TextStyle(color: EmberColors.textSecondary)),
            ),
            ElevatedButton(
              onPressed: () async {
                final pwd = passwordController.text.trim();
                if (pwd.isNotEmpty) {
                  Navigator.pop(ctx);
                  final db = ref.read(databaseProvider);
                  await BackupService.exportAndShareBackup(db, pwd);
                }
              },
              child: const Text('Export & Share'),
            ),
          ],
        );
      },
    );
  }

  void _restoreBackupDialog() async {
    final fileContent = await BackupService.pickBackupFileContent();
    if (fileContent == null || !mounted) return;

    final passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: EmberColors.card,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: const Text('Restore Backup', style: TextStyle(fontFamily: 'Sora', fontSize: 18)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Enter the encryption passphrase used when exporting this backup.',
                style: TextStyle(fontSize: 13, color: EmberColors.textSecondary),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Passphrase'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel', style: TextStyle(color: EmberColors.textSecondary)),
            ),
            ElevatedButton(
              onPressed: () async {
                final pwd = passwordController.text.trim();
                if (pwd.isNotEmpty) {
                  Navigator.pop(ctx);
                  final db = ref.read(databaseProvider);
                  final ok = await BackupService.restoreBackupFromString(db, fileContent, pwd);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(ok ? '✨ Data restored successfully!' : '❌ Decryption failed: Invalid password or corrupt file.'),
                        backgroundColor: ok ? EmberColors.success : EmberColors.slipWarning,
                      ),
                    );
                  }
                }
              },
              child: const Text('Decrypt & Restore'),
            ),
          ],
        );
      },
    );
  }

  void _confirmEmergencyWipe() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: EmberColors.card,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: const Text('Confirm Emergency Wipe', style: TextStyle(fontFamily: 'Sora', fontSize: 18, color: EmberColors.slipWarning)),
          content: const Text(
            'This action is IRREVERSIBLE.\nAll streaks, check-ins, letters, and settings will be permanently erased immediately.',
            style: TextStyle(fontSize: 13, color: EmberColors.textPrimary, height: 1.4),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel', style: TextStyle(color: EmberColors.textSecondary)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: EmberColors.slipWarning),
              onPressed: () async {
                Navigator.pop(ctx);
                final manager = ref.read(emberManagerProvider);
                await manager.wipeEverything();
                if (mounted) {
                  context.go('/onboarding');
                }
              },
              child: const Text('Permanently Wipe Everything'),
            ),
          ],
        );
      },
    );
  }
}
