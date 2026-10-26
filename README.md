# 🔥 Ember — Master Your Discipline, Reclaim Your Flame

Ember is a privacy-first, gamified self-discipline application designed for iOS and Android. Built with Flutter, Ember turns beating addictions and building resilience into an empowering 12-month, 4-stage quest rather than a fleeting 30-day challenge.

The streak is merely the scoreboard. Ember targets the true root causes of compulsive habits: stress, poor sleep, boredom, emotional loneliness, and low self-worth.

---

## 🧭 Core Philosophy & Tone
- **Data, Not Failure**: A slip is never a reason to shame the user. Ember treats slips as valuable insight into triggers.
- **100% Offline & Private**: Zero cloud backend, zero accounts, zero trackers, zero analytics, zero ads, zero network calls. Everything remains securely on your device.
- **Kind, Calm, Resilient**: No guilt trips, no fake urgency, no self-punishment mechanisms.

---

## ⚡ Features Overview

### 1. Streaks & The Scoreboard
- **Multi-Habit Tracking**: Track porn/lust, social media, smoking, vaping, alcohol, junk food, gaming, gambling, procrastination, or custom habits.
- **Total Clean Days Never Reset**: Even if you slip, your lifetime clean days and best records are permanent proof of progress.
- **Milestone Badges**: Celebrations at 1, 3, 7, 14, 30, 60, 90, 180, and 365 days.
- **Streak Shields**: Earned by completing weekly challenges (up to 2 stored). When a slip occurs, use a shield to preserve the streak while logging the event for honest learning.

### 2. The Urge (SOS) Tool
- Prominent one-tap floating emergency button.
- Urge intensity audit (1–5 scale).
- Instant reflection of your personal **"Why"** anchor and photo.
- Guided 10-minute countdown with a calm **breathing circle** (Inhale 4s, Hold 4s, Exhale 6s).
- Constructive physical reset actions (pushups, walk outside, water on face) and matching **Playbook** plans.

### 3. Missions, XP & Gamified Journey
- **Data-Driven Missions**: Sourced from modular JSON files (`assets/missions/stage1.json`).
- **Structured Tiers**: Daily Core (consistency), Growth (skill building), and Bonus (gratitude/momentum).
- **Skill Tree**: Level up 9 disciplines: *Self-Awareness, Sleep Control, Urge Surfing, Energy, Trigger Control, Replacement Habits, Stress Handling, Connection, and Identity*.
- **Stage Boss Battles**: Week 8 culminates in the Stage 1 Boss challenge to unlock elite badges.

### 4. Insights & The Life Wheel
- **Trigger Map**: Automatically categorizes high-risk times of day, days of the week, and top triggers.
- **Trends**: Correlation charts comparing sleep, stress, and mood against urge intensity.
- **Monthly Life Wheel**: 7-dimensional balance radar (Health, Mind, Relationships, Work/Study, Money, Purpose, Fun).
- **Playbook & Letters**: If-Then tactical plans and letters written to your future self.

### 5. Security & Privacy
- **App Lock**: Passcode (hashed & stored in secure hardware storage) + Biometrics (Face ID / Fingerprint via `local_auth`).
- **Auto-Lock on Background**: Configurable background lock timeout (default 30 seconds).
- **App Switcher Privacy Blur**: Blurs the UI when switching apps.
- **Encrypted Backup & Restore**: AES-GCM encrypted backup with PBKDF2 key derivation.
- **Quick Wipe**: Instant emergency data wipe.

---

## 🛠️ Tech Stack
- **Framework**: Flutter (Channel Stable), Dart (Null-Safe)
- **Architecture**: Feature-first with Riverpod 2.x
- **Navigation**: `go_router`
- **Database**: `drift` (SQLite) with encrypted on-device storage
- **Key-Value & Secrets**: `shared_preferences`, `flutter_secure_storage`
- **Typography**: Sora (headings & streak counters) and Inter (body typography) bundled locally in `assets/fonts/`

---

## 🚀 Running Locally

### Prerequisites
1. Install the [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.24+ recommended).
2. Xcode (for iOS simulator or device) and Android Studio (for Android emulator or device).

### Steps
```bash
# 1. Clone repository
git clone https://github.com/LordLyam77/Ember-Discipline.git
cd Ember-Discipline

# 2. Install dependencies
flutter pub get

# 3. Generate Drift SQLite database code
dart run build_runner build --delete-conflicting-outputs

# 4. Run static analyzer and tests
flutter analyze
flutter test

# 5. Launch the app
flutter run
```

---

## 📱 iOS IPA Build & Installation

### How the IPA is Built (GitHub Actions CI)
Every push to the `main` branch triggers `.github/workflows/build.yml`.
The CI workflow runs on a macOS runner and executes:
```bash
flutter build ios --release --no-codesign
```
It then packages `build/ios/iphoneos/Runner.app` into an unsigned IPA archive `App-unsigned.ipa` and uploads it as a workflow artifact.

### How to Download the IPA
1. Open the GitHub repository: [LordLyam77/Ember-Discipline](https://github.com/LordLyam77/Ember-Discipline).
2. Click the **Actions** tab at the top.
3. Select the latest completed workflow run.
4. Scroll down to the **Artifacts** section at the bottom.
5. Click **`ios-unsigned-ipa`** to download the ZIP file containing `App-unsigned.ipa`.

### Why the IPA is Unsigned & How to Sign/Install It
iOS requires every app running on physical hardware to be signed by an Apple Developer certificate. Because this repository does not embed private developer certificates, the IPA is produced unsigned so you can sign it yourself for free using your own Apple ID:

#### Method A: Sideloadly (Recommended — Windows & Mac)
1. Download and install [Sideloadly](https://sideloadly.io/).
2. Connect your iPhone to your computer via USB.
3. Drag and drop `App-unsigned.ipa` into Sideloadly.
4. Enter your Apple ID email.
5. Click **Start**. Sideloadly will sign the IPA with your free Apple developer provisioning profile and install it onto your iPhone.
6. On your iPhone, go to **Settings → General → VPN & Device Management**, tap your Apple ID, and select **Trust**.

#### Method B: AltStore (Mac & Windows)
1. Install [AltServer](https://altstore.io/) on your computer and install AltStore on your iPhone.
2. Send `App-unsigned.ipa` to your iPhone (via AirDrop, iCloud Drive, or local file sharing).
3. Open AltStore on your phone, go to **My Apps**, tap the **+** button, and select `App-unsigned.ipa`.

---

## 🔧 Customization Guide

### 1. How to Rename the App
The app name is centralized in **`lib/core/config/app_config.dart`**:
```dart
class AppConfig {
  static const String appName = 'Ember'; // <-- Change name here
}
```
For native system display names:
- **iOS**: Edit `<key>CFBundleDisplayName</key>` in `ios/Runner/Info.plist`.
- **Android**: Edit `android:label` in `android/app/src/main/AndroidManifest.xml`.

### 2. How to Add Verified Helplines
Crisis helplines are stored in **`assets/helplines.json`**.
> **TODO for Maintainer**: Review `assets/helplines.json` and replace or augment the seed helplines with officially verified national crisis numbers for your specific target country/region.

```json
[
  {
    "country": "Your Country",
    "name": "Local Crisis Support Line",
    "phone": "123-456",
    "note": "24/7 free and confidential mental health support."
  }
]
```

### 3. How to Add Stage 2–4 Missions
Stage 1 missions are located in **`assets/missions/stage1.json`**.
To add Stages 2, 3, or 4:
1. Create `assets/missions/stage2.json` (or stage3/stage4).
2. Follow the JSON schema:
```json
{
  "id": "s2_w1_core",
  "stage": 2,
  "week": 9,
  "tier": "core",
  "title": "Mission Title",
  "description": "Short, clear instructions.",
  "durationMin": 15,
  "xp": 30,
  "skillId": "awareness",
  "easyVersion": "Easier fallback version if missed 3 days."
}
```
3. Register the file in `pubspec.yaml` under `assets:`.

---

## 🔒 Privacy & Architecture Notes
- All persistent relational data is stored in SQLite via **Drift** (`lib/data/local/database/app_database.dart`).
- Passcodes and sensitive cryptographic keys are protected by the operating system keychain via **`flutter_secure_storage`**.
- Optional future enhancement: SQLCipher encryption layer for the SQLite database.

---

## ⚠️ Medical & Safety Disclaimer
**Ember is an educational and personal discipline tracking tool. It does NOT provide medical advice, psychiatric assessment, therapy, or emergency crisis intervention.**
Stopping certain substances suddenly (such as alcohol, benzodiazepines, or opioids) can cause life-threatening physical withdrawal symptoms. Always consult a licensed medical doctor or certified healthcare practitioner before making drastic medical or chemical changes.
