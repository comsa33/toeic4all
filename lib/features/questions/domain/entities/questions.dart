// Part 5 Question Entity
class Part5Question {
  final String id;
  final String text;
  final List<Choice> choices;
  final int correctAnswer;
  final String explanation;
  final String difficulty;
  final List<String> tags;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Part5Question({
    required this.id,
    required this.text,
    required this.choices,
    required this.correctAnswer,
    required this.explanation,
    required this.difficulty,
    this.tags = const [],
    this.createdAt,
    this.updatedAt,
  });

  Part5Question copyWith({
    String? id,
    String? text,
    List<Choice>? choices,
    int? correctAnswer,
    String? explanation,
    String? difficulty,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Part5Question(
      id: id ?? this.id,
      text: text ?? this.text,
      choices: choices ?? this.choices,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      explanation: explanation ?? this.explanation,
      difficulty: difficulty ?? this.difficulty,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// Part 6 Question Set Entity
class Part6QuestionSet {
  final String id;
  final String passage;
  final List<Part6Question> questions;
  final String difficulty;
  final List<String> tags;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Part6QuestionSet({
    required this.id,
    required this.passage,
    required this.questions,
    required this.difficulty,
    this.tags = const [],
    this.createdAt,
    this.updatedAt,
  });

  Part6QuestionSet copyWith({
    String? id,
    String? passage,
    List<Part6Question>? questions,
    String? difficulty,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Part6QuestionSet(
      id: id ?? this.id,
      passage: passage ?? this.passage,
      questions: questions ?? this.questions,
      difficulty: difficulty ?? this.difficulty,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class Part6Question {
  final int questionNumber;
  final String text;
  final List<Choice> choices;
  final int correctAnswer;
  final String explanation;

  const Part6Question({
    required this.questionNumber,
    required this.text,
    required this.choices,
    required this.correctAnswer,
    required this.explanation,
  });

  Part6Question copyWith({
    int? questionNumber,
    String? text,
    List<Choice>? choices,
    int? correctAnswer,
    String? explanation,
  }) {
    return Part6Question(
      questionNumber: questionNumber ?? this.questionNumber,
      text: text ?? this.text,
      choices: choices ?? this.choices,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      explanation: explanation ?? this.explanation,
    );
  }
}

// Part 7 Question Set Entity
class Part7QuestionSet {
  final String id;
  final String passage;
  final List<Part7Question> questions;
  final String difficulty;
  final List<String> tags;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Part7QuestionSet({
    required this.id,
    required this.passage,
    required this.questions,
    required this.difficulty,
    this.tags = const [],
    this.createdAt,
    this.updatedAt,
  });

  Part7QuestionSet copyWith({
    String? id,
    String? passage,
    List<Part7Question>? questions,
    String? difficulty,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Part7QuestionSet(
      id: id ?? this.id,
      passage: passage ?? this.passage,
      questions: questions ?? this.questions,
      difficulty: difficulty ?? this.difficulty,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class Part7Question {
  final int questionNumber;
  final String text;
  final List<Choice> choices;
  final int correctAnswer;
  final String explanation;

  const Part7Question({
    required this.questionNumber,
    required this.text,
    required this.choices,
    required this.correctAnswer,
    required this.explanation,
  });

  Part7Question copyWith({
    int? questionNumber,
    String? text,
    List<Choice>? choices,
    int? correctAnswer,
    String? explanation,
  }) {
    return Part7Question(
      questionNumber: questionNumber ?? this.questionNumber,
      text: text ?? this.text,
      choices: choices ?? this.choices,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      explanation: explanation ?? this.explanation,
    );
  }
}

// Choice Entity
class Choice {
  final String text;
  final String? explanation;

  const Choice({
    required this.text,
    this.explanation,
  });

  Choice copyWith({
    String? text,
    String? explanation,
  }) {
    return Choice(
      text: text ?? this.text,
      explanation: explanation ?? this.explanation,
    );
  }
}

// Vocabulary Entity
class Vocabulary {
  final String id;
  final String word;
  final String meaning;
  final String pronunciation;
  final String partOfSpeech;
  final List<String> examples;
  final String difficulty;
  final List<String> synonyms;
  final List<String> antonyms;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Vocabulary({
    required this.id,
    required this.word,
    required this.meaning,
    required this.pronunciation,
    required this.partOfSpeech,
    this.examples = const [],
    required this.difficulty,
    this.synonyms = const [],
    this.antonyms = const [],
    this.createdAt,
    this.updatedAt,
  });

  Vocabulary copyWith({
    String? id,
    String? word,
    String? meaning,
    String? pronunciation,
    String? partOfSpeech,
    List<String>? examples,
    String? difficulty,
    List<String>? synonyms,
    List<String>? antonyms,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Vocabulary(
      id: id ?? this.id,
      word: word ?? this.word,
      meaning: meaning ?? this.meaning,
      pronunciation: pronunciation ?? this.pronunciation,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      examples: examples ?? this.examples,
      difficulty: difficulty ?? this.difficulty,
      synonyms: synonyms ?? this.synonyms,
      antonyms: antonyms ?? this.antonyms,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
