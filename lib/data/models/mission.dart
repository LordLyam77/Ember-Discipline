import 'dart:convert';
import 'package:flutter/services.dart';

class Mission {
  final String id;
  final int stage;
  final int week;
  final String tier; // core, growth, bonus, weekly, boss
  final String title;
  final String description;
  final int durationMin;
  final int xp;
  final String skillId;
  final String? easyVersion;

  const Mission({
    required this.id,
    required this.stage,
    required this.week,
    required this.tier,
    required this.title,
    required this.description,
    required this.durationMin,
    required this.xp,
    required this.skillId,
    this.easyVersion,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      id: json['id'] as String,
      stage: json['stage'] as int,
      week: json['week'] as int,
      tier: json['tier'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      durationMin: json['durationMin'] as int,
      xp: json['xp'] as int,
      skillId: json['skillId'] as String,
      easyVersion: json['easyVersion'] as String?,
    );
  }

  static Future<List<Mission>> loadStageMissions(int stage) async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/missions/stage$stage.json');
      final List<dynamic> list = jsonDecode(jsonString);
      return list.map((item) => Mission.fromJson(item as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }
}
