import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/question_filter.dart';
import '../providers/questions_providers.dart';
import '../pages/part6_quiz_screen.dart';
import '../../../../shared/widgets/app_button.dart';

class Part6FilterScreen extends ConsumerStatefulWidget {
  const Part6FilterScreen({super.key});

  @override
  ConsumerState<Part6FilterScreen> createState() => _Part6FilterScreenState();
}

class _Part6FilterScreenState extends ConsumerState<Part6FilterScreen> {
  String? selectedPassageType;
  String? selectedDifficulty;
  int questionCount = 2; // 수정: 기본값을 2로 변경 (백엔드 기본값과 일치)

  @override
  Widget build(BuildContext context) {
    final passageTypesAsync = ref.watch(part6PassageTypesProvider);
    final difficultiesAsync = ref.watch(
      part6DifficultiesProvider(selectedPassageType),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Part 6 설정'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.article, color: Colors.orange, size: 32),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Part 6 - 장문 빈칸 추론',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        '지문과 문맥을 파악하는 문제',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.orange.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Passage Type Selection
                    _FilterSection(
                      title: '지문 유형',
                      child: passageTypesAsync.when(
                        data: (passageTypes) =>
                            _buildPassageTypeSelection(passageTypes),
                        loading: () => const _FilterSkeleton(),
                        error: (error, stack) =>
                            _ErrorWidget(error: error.toString()),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Difficulty Selection
                    _FilterSection(
                      title: '난이도',
                      child: difficultiesAsync.when(
                        data: (difficulties) =>
                            _buildDifficultySelection(difficulties),
                        loading: () => const _FilterSkeleton(),
                        error: (error, stack) =>
                            _ErrorWidget(error: error.toString()),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Question Count - 수정: 백엔드 API limit 범위에 맞게 조정
                    _FilterSection(
                      title: '문제 세트 수',
                      child: _buildQuestionCountSlider(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Start Button
            AppButton(
              text: '문제 풀이 시작',
              isFullWidth: true,
              onPressed: _canStart() ? _startQuiz : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPassageTypeSelection(List<String> passageTypes) {
    if (passageTypes.isEmpty) {
      return const Text('사용 가능한 지문 유형이 없습니다.');
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: passageTypes.map((passageType) {
        final isSelected = selectedPassageType == passageType;
        return FilterChip(
          label: Text(passageType),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              selectedPassageType = selected ? passageType : null;
              selectedDifficulty = null; // Reset dependent filter
            });
          },
          selectedColor: Colors.orange.withOpacity(0.2),
          checkmarkColor: Colors.orange,
        );
      }).toList(),
    );
  }

  Widget _buildDifficultySelection(List<String> difficulties) {
    if (difficulties.isEmpty) {
      return Text(
        selectedPassageType == null ? '지문 유형을 먼저 선택해주세요.' : '사용 가능한 난이도가 없습니다.',
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: difficulties.map((difficulty) {
        final isSelected = selectedDifficulty == difficulty;
        return FilterChip(
          label: Text(difficulty),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              selectedDifficulty = selected ? difficulty : null;
            });
          },
          selectedColor: Colors.orange.withOpacity(0.2),
          checkmarkColor: Colors.orange,
        );
      }).toList(),
    );
  }

  // 수정: 백엔드 API 제한사항에 맞게 1~4 범위로 조정
  Widget _buildQuestionCountSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '문제 세트 수: $questionCount개',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '(최대: 4개)', // 수정: 권장 개수를 최대 개수로 변경
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: questionCount.toDouble(),
          min: 1, // 수정: 최소값을 1로 변경
          max: 4, // 수정: 최대값을 4로 변경 (백엔드 API 제한사항)
          divisions: 3, // 수정: divisions 조정 (1, 2, 3, 4)
          activeColor: Colors.orange,
          onChanged: (value) {
            setState(() {
              questionCount = value.round();
            });
          },
        ),
        // 추가: 설명 텍스트
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            'Part 6는 한 세트당 4개의 문제를 포함합니다.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  bool _canStart() {
    return selectedPassageType != null && selectedDifficulty != null;
  }

  void _startQuiz() {
    final filter = QuestionFilter(
      passageType: selectedPassageType,
      difficulty: selectedDifficulty,
      limit: questionCount,
      requestId: const Uuid().v4(), // 고유 ID 추가
    );

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Part6QuizScreen(filter: filter)),
    );
  }
}

// Reusable components
class _FilterSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _FilterSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class _FilterSkeleton extends StatelessWidget {
  const _FilterSkeleton();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(3, (index) {
        return Container(
          width: 80 + (index * 20),
          height: 32,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(16),
          ),
        );
      }),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String error;

  const _ErrorWidget({required this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '오류: $error',
        style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
      ),
    );
  }
}
