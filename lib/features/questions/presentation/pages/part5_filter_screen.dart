import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/question_filter.dart';
import '../providers/questions_providers.dart';
import '../pages/part5_quiz_screen.dart'; // 추가: Part5QuizScreen import
import '../../../../shared/widgets/app_button.dart';

class Part5FilterScreen extends ConsumerStatefulWidget {
  const Part5FilterScreen({super.key});

  @override
  ConsumerState<Part5FilterScreen> createState() => _Part5FilterScreenState();
}

class _Part5FilterScreenState extends ConsumerState<Part5FilterScreen> {
  String? selectedCategory;
  String? selectedSubtype;
  String? selectedDifficulty;
  int questionCount = 10;

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(part5CategoriesProvider);
    final subtypesAsync = ref.watch(part5SubtypesProvider(selectedCategory));
    final difficultiesAsync = ref.watch(
      part5DifficultiesProvider((
        category: selectedCategory,
        subtype: selectedSubtype,
      )),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Part 5 설정'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.text_fields, color: Colors.blue, size: 32),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Part 5 - 문법 및 어휘',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        '단문 빈칸 추론 문제',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Question count
                    _FilterCard(
                      title: '문제 수',
                      child: Row(
                        children: [
                          Expanded(
                            child: Slider(
                              value: questionCount.toDouble(),
                              min: 5,
                              max: 30,
                              divisions: 9,
                              label: '$questionCount문제',
                              onChanged: (value) {
                                setState(() {
                                  questionCount = value.round();
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '$questionCount',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Category filter
                    _FilterCard(
                      title: '카테고리',
                      child: categoriesAsync.when(
                        data: (categories) => _DropdownFilter(
                          value: selectedCategory,
                          items: categories,
                          hint: '카테고리 선택',
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value;
                              selectedSubtype =
                                  null; // Reset subtype when category changes
                              selectedDifficulty = null; // Reset difficulty
                            });
                          },
                        ),
                        loading: () => const _LoadingDropdown(),
                        error: (error, stack) =>
                            _ErrorMessage(error.toString()),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Subtype filter
                    _FilterCard(
                      title: '세부 유형',
                      child: subtypesAsync.when(
                        data: (subtypes) => _DropdownFilter(
                          value: selectedSubtype,
                          items: subtypes,
                          hint: '세부 유형 선택',
                          enabled: selectedCategory != null,
                          onChanged: (value) {
                            setState(() {
                              selectedSubtype = value;
                              selectedDifficulty = null; // Reset difficulty
                            });
                          },
                        ),
                        loading: () => const _LoadingDropdown(),
                        error: (error, stack) =>
                            _ErrorMessage(error.toString()),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Difficulty filter
                    _FilterCard(
                      title: '난이도',
                      child: difficultiesAsync.when(
                        data: (difficulties) => _DropdownFilter(
                          value: selectedDifficulty,
                          items: difficulties,
                          hint: '난이도 선택',
                          onChanged: (value) {
                            setState(() {
                              selectedDifficulty = value;
                            });
                          },
                        ),
                        loading: () => const _LoadingDropdown(),
                        error: (error, stack) =>
                            _ErrorMessage(error.toString()),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: AppButton.outline(
                    text: '초기화',
                    onPressed: () {
                      setState(() {
                        selectedCategory = null;
                        selectedSubtype = null;
                        selectedDifficulty = null;
                        questionCount = 10;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: AppButton(
                    text: '문제 시작',
                    onPressed: () {
                      final filter = QuestionFilter(
                        category: selectedCategory,
                        subtype: selectedSubtype,
                        difficulty: selectedDifficulty,
                        limit: questionCount,
                        requestId: const Uuid().v4(), // 고유 ID 추가
                      );

                      // 수정: Navigator.push 사용 (파트6, 파트7과 동일한 방식)
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Part5QuizScreen(filter: filter),
                        ),
                      );
                    },
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

class _FilterCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _FilterCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
        ),
      ),
    );
  }
}

class _DropdownFilter extends StatelessWidget {
  final String? value;
  final List<String> items;
  final String hint;
  final bool enabled;
  final ValueChanged<String?> onChanged;

  const _DropdownFilter({
    required this.value,
    required this.items,
    required this.hint,
    this.enabled = true,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: [
        DropdownMenuItem(
          value: null,
          child: Text(
            '전체',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        ...items.map(
          (item) => DropdownMenuItem(value: item, child: Text(item)),
        ),
      ],
      onChanged: enabled ? onChanged : null,
    );
  }
}

class _LoadingDropdown extends StatelessWidget {
  const _LoadingDropdown();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  final String message;

  const _ErrorMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.onErrorContainer,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '데이터를 불러올 수 없습니다',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
