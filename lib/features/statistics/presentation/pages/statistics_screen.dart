import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/statistics_providers.dart';
import '../../../../shared/widgets/app_button.dart';

class StatisticsScreen extends ConsumerStatefulWidget {
  const StatisticsScreen({super.key});

  @override
  ConsumerState<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends ConsumerState<StatisticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('학습 통계'),
        centerTitle: true,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '전체 요약'),
            Tab(text: 'Part별 분석'),
            Tab(text: '학습 기록'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _OverallSummaryTab(),
          _PartAnalysisTab(),
          _StudyHistoryTab(),
        ],
      ),
    );
  }
}

// 전체 요약 탭
class _OverallSummaryTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statisticsAsync = ref.watch(statisticsDataProvider);
    
    return statisticsAsync.when(
      data: (statistics) => SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 주요 지표 카드들
            _MainStatsGrid(statistics: statistics),
            
            const SizedBox(height: 24),
            
            // 최근 학습 성과 그래프
            _RecentPerformanceChart(statistics: statistics),
            
            const SizedBox(height: 24),
            
            // 학습 연속일 및 목표
            _StudyStreakCard(statistics: statistics),
            
            const SizedBox(height: 24),
            
            // 빠른 액션 버튼들
            _QuickActionButtons(),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('데이터를 불러오는 중 오류가 발생했습니다: $error'),
      ),
    );
  }
}

// Part별 분석 탭
class _PartAnalysisTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partStatsAsync = ref.watch(partStatisticsProvider(null));
    
    return partStatsAsync.when(
      data: (partStats) => SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Part별 성과 비교
            _PartComparisonChart(partStats: partStats),
            
            const SizedBox(height: 24),
            
            // Part별 상세 통계
            _PartDetailedStats(partStats: partStats),
            
            const SizedBox(height: 24),
            
            // 약점 분석 및 추천
            _WeaknessAnalysis(partStats: partStats),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('데이터를 불러오는 중 오류가 발생했습니다: $error'),
      ),
    );
  }
}

// 학습 기록 탭
class _StudyHistoryTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentResultsAsync = ref.watch(recentQuizResultsProvider);
    final weeklyProgressAsync = ref.watch(weeklyProgressProvider);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 월별 학습 활동
          weeklyProgressAsync.when(
            data: (weeklyProgress) => _MonthlyActivityChart(weeklyProgress: weeklyProgress),
            loading: () => const SizedBox(height: 200, child: Center(child: CircularProgressIndicator())),
            error: (error, stack) => SizedBox(height: 200, child: Center(child: Text('차트 로딩 실패: $error'))),
          ),
          
          const SizedBox(height: 24),
          
          // 최근 퀴즈 결과 목록
          recentResultsAsync.when(
            data: (recentResults) => _RecentQuizResults(recentResults: recentResults),
            loading: () => const SizedBox(height: 200, child: Center(child: CircularProgressIndicator())),
            error: (error, stack) => SizedBox(height: 200, child: Center(child: Text('퀴즈 결과 로딩 실패: $error'))),
          ),
          
          const SizedBox(height: 24),
          
          // 학습 시간 분석
          _StudyTimeAnalysis(),
        ],
      ),
    );
  }
}

// 주요 통계 그리드
class _MainStatsGrid extends StatelessWidget {
  final StatisticsData statistics;
  
  const _MainStatsGrid({required this.statistics});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.3,
      children: [
        _StatCard(
          title: '총 문제 수',
          value: '${statistics.totalQuestions}',
          subtitle: '지금까지 풀어본 문제',
          icon: Icons.quiz,
          color: Colors.blue,
          trend: '+12%',
        ),
        _StatCard(
          title: '평균 정답률',
          value: '${(statistics.averageAccuracy * 100).round()}%',
          subtitle: '최근 30일 기준',
          icon: Icons.trending_up,
          color: Colors.green,
          trend: '+5%',
        ),
        _StatCard(
          title: '학습 연속일',
          value: '${statistics.studyStreak}일',
          subtitle: '현재 연속 기록',
          icon: Icons.local_fire_department,
          color: Colors.orange,
          trend: 'NEW',
        ),
        _StatCard(
          title: '예상 점수',
          value: '${statistics.estimatedScore}점',
          subtitle: '현재 실력 수준',
          icon: Icons.school,
          color: Colors.purple,
          trend: '+30점',
        ),
      ],
    );
  }
}

// 통계 카드 위젯
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String trend;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.trend,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.1),
              color.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    trend,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 최근 성과 차트
class _RecentPerformanceChart extends StatelessWidget {
  final StatisticsData statistics;
  
  const _RecentPerformanceChart({required this.statistics});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '최근 7일 성과',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}%',
                            style: Theme.of(context).textTheme.bodySmall,
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final days = ['월', '화', '수', '목', '금', '토', '일'];
                          if (value.toInt() < days.length) {
                            return Text(
                              days[value.toInt()],
                              style: Theme.of(context).textTheme.bodySmall,
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 65),
                        FlSpot(1, 72),
                        FlSpot(2, 78),
                        FlSpot(3, 75),
                        FlSpot(4, 82),
                        FlSpot(5, 88),
                        FlSpot(6, 85),
                      ],
                      isCurved: true,
                      color: Theme.of(context).colorScheme.primary,
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Theme.of(context).colorScheme.primary,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                  minY: 0,
                  maxY: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 학습 연속일 카드
class _StudyStreakCard extends StatelessWidget {
  final StatisticsData statistics;
  
  const _StudyStreakCard({required this.statistics});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              Colors.orange.withValues(alpha: 0.1),
              Colors.red.withValues(alpha: 0.1),
            ],
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: Colors.orange,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '학습 연속일',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '꾸준한 학습으로 실력을 향상시키세요!',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StreakItem(label: '현재', value: '${statistics.studyStreak}일', color: Colors.orange),
                _StreakItem(label: '최고', value: '23일', color: Colors.red),
                _StreakItem(label: '이번 달', value: '18일', color: Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StreakItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StreakItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

// 빠른 액션 버튼들
class _QuickActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '빠른 액션',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: '오답 노트',
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {
                  // 오답 노트로 이동
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton.outline(
                text: '약점 보완',
                icon: const Icon(Icons.psychology),
                onPressed: () {
                  // 약점 보완 문제로 이동
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Part별 비교 차트
class _PartComparisonChart extends StatelessWidget {
  final List<PartStatistics> partStats;
  
  const _PartComparisonChart({required this.partStats});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Part별 정답률 비교',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}%',
                            style: Theme.of(context).textTheme.bodySmall,
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('Part 5');
                            case 1:
                              return const Text('Part 6');
                            case 2:
                              return const Text('Part 7');
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: 82,
                          color: Colors.blue,
                          width: 20,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 75,
                          color: Colors.orange,
                          width: 20,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: 68,
                          color: Colors.purple,
                          width: 20,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ],
                  maxY: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Part별 상세 통계
class _PartDetailedStats extends StatelessWidget {
  final List<PartStatistics> partStats;
  
  const _PartDetailedStats({required this.partStats});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PartStatCard(
          partName: 'Part 5 - 문법 및 어휘',
          accuracy: 82,
          totalQuestions: 456,
          averageTime: '45초',
          weakPoints: ['관계대명사', '동명사', '가정법'],
          color: Colors.blue,
        ),
        const SizedBox(height: 12),
        _PartStatCard(
          partName: 'Part 6 - 장문 빈칸추론',
          accuracy: 75,
          totalQuestions: 248,
          averageTime: '1분 20초',
          weakPoints: ['문맥 파악', '접속사', '어휘 선택'],
          color: Colors.orange,
        ),
        const SizedBox(height: 12),
        _PartStatCard(
          partName: 'Part 7 - 독해',
          accuracy: 68,
          totalQuestions: 544,
          averageTime: '2분 15초',
          weakPoints: ['함축 의미', '세부 정보', '주제 파악'],
          color: Colors.purple,
        ),
      ],
    );
  }
}

class _PartStatCard extends StatelessWidget {
  final String partName;
  final int accuracy;
  final int totalQuestions;
  final String averageTime;
  final List<String> weakPoints;
  final Color color;

  const _PartStatCard({
    required this.partName,
    required this.accuracy,
    required this.totalQuestions,
    required this.averageTime,
    required this.weakPoints,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    partName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '$accuracy%',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatItem(
                    label: '총 문제',
                    value: '$totalQuestions개',
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    label: '평균 시간',
                    value: averageTime,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '약점 영역',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: weakPoints.map((point) {
                return Chip(
                  label: Text(
                    point,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  backgroundColor: color.withValues(alpha: 0.1),
                  side: BorderSide(color: color.withValues(alpha: 0.3)),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// 약점 분석
class _WeaknessAnalysis extends StatelessWidget {
  final List<PartStatistics> partStats;
  
  const _WeaknessAnalysis({required this.partStats});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.psychology,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'AI 약점 분석',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '현재 가장 취약한 영역',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Part 7의 함축 의미 파악 문제에서 정답률이 낮습니다. '
                    '긴 지문을 읽을 때 핵심 내용과 숨겨진 의미를 파악하는 연습이 필요해요.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    text: '맞춤 문제 풀기',
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      // 맞춤 문제로 이동
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 월별 활동 차트
class _MonthlyActivityChart extends StatelessWidget {
  final Map<String, double> weeklyProgress;
  
  const _MonthlyActivityChart({required this.weeklyProgress});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '월별 학습 활동',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // 여기에 히트맵 스타일의 활동 차트를 구현할 수 있습니다.
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('월별 활동 히트맵 (구현 예정)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 최근 퀴즈 결과
class _RecentQuizResults extends StatelessWidget {
  final List<RecentQuizResult> recentResults;
  
  const _RecentQuizResults({required this.recentResults});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '최근 퀴즈 결과',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(5, (index) {
              final results = [
                {'part': 'Part 5', 'score': 85, 'date': '오늘', 'color': Colors.blue},
                {'part': 'Part 7', 'score': 72, 'date': '어제', 'color': Colors.purple},
                {'part': 'Part 6', 'score': 78, 'date': '2일 전', 'color': Colors.orange},
                {'part': 'Part 5', 'score': 90, 'date': '3일 전', 'color': Colors.blue},
                {'part': 'Part 7', 'score': 65, 'date': '4일 전', 'color': Colors.purple},
              ];
              
              final result = results[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _QuizResultItem(
                  partName: result['part'] as String,
                  score: result['score'] as int,
                  date: result['date'] as String,
                  color: result['color'] as Color,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _QuizResultItem extends StatelessWidget {
  final String partName;
  final int score;
  final String date;
  final Color color;

  const _QuizResultItem({
    required this.partName,
    required this.score,
    required this.date,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  partName,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$score%',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// 학습 시간 분석
class _StudyTimeAnalysis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '학습 시간 분석',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _TimeStatCard(
                    title: '이번 주',
                    time: '4시간 30분',
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _TimeStatCard(
                    title: '이번 달',
                    time: '18시간 45분',
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _TimeStatCard(
                    title: '일일 평균',
                    time: '38분',
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _TimeStatCard(
                    title: '목표까지',
                    time: '22분 부족',
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeStatCard extends StatelessWidget {
  final String title;
  final String time;
  final Color color;

  const _TimeStatCard({
    required this.title,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
