import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/question_filter.dart';
import '../providers/questions_providers.dart';
import '../pages/part7_quiz_screen.dart';
import '../../../../shared/widgets/app_button.dart';

class Part7FilterScreen extends ConsumerStatefulWidget {
  const Part7FilterScreen({super.key});

  @override
  ConsumerState<Part7FilterScreen> createState() => _Part7FilterScreenState();
}

class _Part7FilterScreenState extends ConsumerState<Part7FilterScreen> {
  String? selectedSetType;
  List<String> selectedPassageTypes = [];
  String? selectedDifficulty;
  int questionCount = 8; // Part 7 typically has 8+ questions

  @override
  Widget build(BuildContext context) {
    final setTypesAsync = ref.watch(part7SetTypesProvider);
    final passageTypesAsync = ref.watch(part7PassageTypesProvider(selectedSetType));
    final difficultiesAsync = ref.watch(part7DifficultiesProvider(selectedSetType));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Part 7 설정'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.library_books,
                    color: Colors.purple,
                    size: 32,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Part 7 - 독해',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      Text(
                        '긴 지문을 읽고 답하는 문제',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.purple.shade700,
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
                    // Set Type Selection
                    _FilterSection(
                      title: '문제 세트 유형',
                      child: setTypesAsync.when(
                        data: (setTypes) => _buildSetTypeSelection(setTypes),
                        loading: () => const _FilterSkeleton(),
                        error: (error, stack) => _ErrorWidget(error: error.toString()),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Passage Type Selection
                    _FilterSection(
                      title: '지문 유형 (복수 선택 가능)',
                      child: passageTypesAsync.when(
                        data: (passageTypes) => _buildPassageTypeSelection(passageTypes),
                        loading: () => const _FilterSkeleton(),
                        error: (error, stack) => _ErrorWidget(error: error.toString()),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Difficulty Selection
                    _FilterSection(
                      title: '난이도',
                      child: difficultiesAsync.when(
                        data: (difficulties) => _buildDifficultySelection(difficulties),
                        loading: () => const _FilterSkeleton(),
                        error: (error, stack) => _ErrorWidget(error: error.toString()),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Question Count
                    _FilterSection(
                      title: '문제 수',
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

  Widget _buildSetTypeSelection(List<String> setTypes) {
    if (setTypes.isEmpty) {
      return const Text('사용 가능한 세트 유형이 없습니다.');
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: setTypes.map((setType) {
        final isSelected = selectedSetType == setType;
        return FilterChip(
          label: Text(setType),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              selectedSetType = selected ? setType : null;
              selectedPassageTypes.clear(); // Reset dependent filters
              selectedDifficulty = null;
            });
          },
          selectedColor: Colors.purple.withOpacity(0.2),
          checkmarkColor: Colors.purple,
        );
      }).toList(),
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
        final isSelected = selectedPassageTypes.contains(passageType);
        return FilterChip(
          label: Text(passageType),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                selectedPassageTypes.add(passageType);
              } else {
                selectedPassageTypes.remove(passageType);
              }
              selectedDifficulty = null; // Reset dependent filter
            });
          },
          selectedColor: Colors.purple.withOpacity(0.2),
          checkmarkColor: Colors.purple,
        );
      }).toList(),
    );
  }

  Widget _buildDifficultySelection(List<String> difficulties) {
    if (difficulties.isEmpty) {
      return Text(
        selectedSetType == null 
          ? '세트 유형을 먼저 선택해주세요.'
          : '사용 가능한 난이도가 없습니다.',
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
          selectedColor: Colors.purple.withOpacity(0.2),
          checkmarkColor: Colors.purple,
        );
      }).toList(),
    );
  }

  Widget _buildQuestionCountSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '문제 수: $questionCount개',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '(권장: 8-15개)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: questionCount.toDouble(),
          min: 5,
          max: 30,
          divisions: 25,
          activeColor: Colors.purple,
          onChanged: (value) {
            setState(() {
              questionCount = value.round();
            });
          },
        ),
      ],
    );
  }

  bool _canStart() {
    return selectedSetType != null && selectedDifficulty != null;
  }

  void _startQuiz() {
    final filter = QuestionFilter(
      setType: selectedSetType,
      passageTypes: selectedPassageTypes.isNotEmpty ? selectedPassageTypes : null,
      difficulty: selectedDifficulty,
      limit: questionCount,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Part7QuizScreen(filter: filter),
      ),
    );
  }
}

// Reusable components
class _FilterSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _FilterSection({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
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
      children: List.generate(4, (index) {
        return Container(
          width: 70 + (index * 25),
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
        style: TextStyle(
          color: Theme.of(context).colorScheme.onErrorContainer,
        ),
      ),
    );
  }
}
