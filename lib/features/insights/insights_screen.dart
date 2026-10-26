import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/local/database/app_database.dart';
import '../../data/repositories/ember_repository.dart';
import '../../widgets/ember_card.dart';

class InsightsScreen extends ConsumerStatefulWidget {
  const InsightsScreen({super.key});

  @override
  ConsumerState<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends ConsumerState<InsightsScreen> {
  // Monthly Life Wheel scores (1 to 10)
  final Map<String, int> _lifeWheelScores = {
    'Health': 7,
    'Mind': 6,
    'Relationships': 8,
    'Work/Study': 7,
    'Money': 6,
    'Purpose': 8,
    'Fun': 6,
  };

  @override
  Widget build(BuildContext context) {
    final urgesAsync = ref.watch(urgesStreamProvider);
    final slipsAsync = ref.watch(slipsStreamProvider);
    final checkinsAsync = ref.watch(checkinsStreamProvider);

    final urges = urgesAsync.value ?? [];
    final slips = slipsAsync.value ?? [];
    final checkins = checkinsAsync.value ?? [];

    // Compute top triggers
    final triggerCounts = <String, int>{};
    for (final s in slips) {
      triggerCounts[s.trigger] = (triggerCounts[s.trigger] ?? 0) + 1;
    }
    for (final u in urges) {
      if (u.triggerTag != null && u.triggerTag!.isNotEmpty) {
        triggerCounts[u.triggerTag!] = (triggerCounts[u.triggerTag!] ?? 0) + 1;
      }
    }

    final sortedTriggers = triggerCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Urges by hour of day (0 to 23)
    final hourlyCounts = List<int>.filled(24, 0);
    for (final u in urges) {
      hourlyCounts[u.at.hour]++;
    }
    for (final s in slips) {
      hourlyCounts[s.at.hour]++;
    }

    // Weekly report summary message
    String hardestWindow = 'late evening hours (10 PM - 1 AM)';
    int maxHourCount = 0;
    int peakHour = 22;
    for (int h = 0; h < 24; h++) {
      if (hourlyCounts[h] > maxHourCount) {
        maxHourCount = hourlyCounts[h];
        peakHour = h;
      }
    }
    if (maxHourCount > 0) {
      hardestWindow = '${peakHour % 12 == 0 ? 12 : peakHour % 12} ${peakHour >= 12 ? 'PM' : 'AM'}';
    }

    return Scaffold(
      backgroundColor: EmberColors.background,
      appBar: AppBar(
        title: const Text('Local Insights & Blueprint'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_book_outlined),
            tooltip: 'Playbook',
            onPressed: () => context.push('/playbook'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI / Analytical Coaching Summary
            EmberCard(
              backgroundColor: EmberColors.cardElevated,
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.auto_awesome, color: EmberColors.primaryOrange, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'WEEKLY PATTERN REPORT',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: EmberColors.primaryOrange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your highest urge vulnerability appears around $hardestWindow. Ensure your phone is charged in another room and your replacement hobby is prepared in advance.',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: EmberColors.textPrimary,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () => context.push('/playbook'),
                        icon: const Icon(Icons.add_task, size: 16, color: EmberColors.primaryOrange),
                        label: const Text(
                          'Configure Playbook Plans',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: EmberColors.primaryOrange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 1. Urges by Time of Day Chart
            _buildSectionTitle('Urges by Time of Day', 'Distribution across 24 hours'),
            const SizedBox(height: 14),
            _buildHourlyChart(hourlyCounts),
            const SizedBox(height: 28),

            // 2. Top Triggers Breakdown
            _buildSectionTitle('Top Triggers Encountered', 'Identified root precursors'),
            const SizedBox(height: 12),
            _buildTopTriggersList(sortedTriggers),
            const SizedBox(height: 28),

            // 3. Mood, Stress & Sleep Correlations
            _buildSectionTitle('Check-In Trends', 'Mood vs Stress over recent days'),
            const SizedBox(height: 14),
            _buildTrendsChart(checkins),
            const SizedBox(height: 28),

            // 4. Life Wheel (Monthly Radar / Balance)
            _buildSectionTitle('The Life Wheel (Monthly Balance)', 'Rate 1 to 10 across fundamental life pillars'),
            const SizedBox(height: 12),
            _buildLifeWheelSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Sora',
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: EmberColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            color: EmberColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildHourlyChart(List<int> hourlyCounts) {
    return EmberCard(
      padding: const EdgeInsets.fromLTRB(12, 20, 16, 12),
      child: SizedBox(
        height: 160,
        child: BarChart(
          BarChartData(
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final h = value.toInt();
                    if (h == 0) return const Text('12a', style: TextStyle(fontSize: 10, color: EmberColors.textTertiary));
                    if (h == 6) return const Text('6a', style: TextStyle(fontSize: 10, color: EmberColors.textTertiary));
                    if (h == 12) return const Text('12p', style: TextStyle(fontSize: 10, color: EmberColors.textTertiary));
                    if (h == 18) return const Text('6p', style: TextStyle(fontSize: 10, color: EmberColors.textTertiary));
                    if (h == 23) return const Text('11p', style: TextStyle(fontSize: 10, color: EmberColors.textTertiary));
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            barGroups: List.generate(24, (i) {
              return BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: (hourlyCounts[i]).toDouble(),
                    color: hourlyCounts[i] > 0 ? EmberColors.primaryOrange : EmberColors.cardElevated,
                    width: 7,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildTopTriggersList(List<MapEntry<String, int>> sortedTriggers) {
    if (sortedTriggers.isEmpty) {
      return EmberCard(
        backgroundColor: EmberColors.cardElevated,
        padding: const EdgeInsets.all(16),
        child: const Center(
          child: Text(
            'No triggers logged yet. As you use the SOS tool or check-ins, patterns emerge here.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: EmberColors.textSecondary),
          ),
        ),
      );
    }

    return Column(
      children: sortedTriggers.take(4).map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: EmberCard(
            backgroundColor: EmberColors.cardElevated,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: EmberColors.textPrimary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: EmberColors.primaryOrange.withAlpha(40),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${entry.value}x',
                    style: const TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: EmberColors.primaryOrange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTrendsChart(List<Checkin> checkins) {
    if (checkins.isEmpty) {
      return EmberCard(
        backgroundColor: EmberColors.cardElevated,
        padding: const EdgeInsets.all(16),
        child: const Center(
          child: Text(
            'Complete daily check-ins to view mood & stress correlations.',
            style: TextStyle(fontSize: 13, color: EmberColors.textSecondary),
          ),
        ),
      );
    }

    final recentCheckins = checkins.take(7).toList().reversed.toList();
    final moodSpots = <FlSpot>[];
    final stressSpots = <FlSpot>[];

    for (int i = 0; i < recentCheckins.length; i++) {
      moodSpots.add(FlSpot(i.toDouble(), recentCheckins[i].mood.toDouble()));
      stressSpots.add(FlSpot(i.toDouble(), recentCheckins[i].stress.toDouble()));
    }

    return EmberCard(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildLegend(color: EmberColors.success, label: 'Mood'),
              const SizedBox(width: 16),
              _buildLegend(color: EmberColors.slipWarning, label: 'Stress'),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 150,
            child: LineChart(
              LineChartData(
                minY: 1,
                maxY: 5,
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: moodSpots,
                    isCurved: true,
                    color: EmberColors.success,
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                  ),
                  LineChartBarData(
                    spots: stressSpots,
                    isCurved: true,
                    color: EmberColors.slipWarning,
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: EmberColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildLifeWheelSection() {
    return EmberCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ..._lifeWheelScores.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      entry.key,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: EmberColors.textPrimary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      value: entry.value.toDouble(),
                      min: 1,
                      max: 10,
                      divisions: 9,
                      activeColor: EmberColors.primaryOrange,
                      inactiveColor: EmberColors.cardElevated,
                      onChanged: (val) {
                        setState(() => _lifeWheelScores[entry.key] = val.round());
                      },
                    ),
                  ),
                  SizedBox(
                    width: 32,
                    child: Text(
                      '${entry.value}/10',
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontFamily: 'Sora',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: EmberColors.primaryOrange,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
