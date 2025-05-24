
// Common Choice entity for all question types
class Choice {
  final String id;
  final String text;
  final String translation;

  const Choice({
    required this.id,
    required this.text,
    required this.translation,
  });

  Choice copyWith({
    String? id,
    String? text,
    String? translation,
  }) {
    return Choice(
      id: id ?? this.id,
      text: text ?? this.text,
      translation: translation ?? this.translation,
    );
  }
}

// Part 5 Question
class Part5Question {
  final String id;
  final String questionCategory;
  final String questionSubType;
  final String difficulty;
  final String questionText;
  final String questionTranslation;
  final List<Choice> choices;

  const Part5Question({
    required this.id,
    required this.questionCategory,
    required this.questionSubType,
    required this.difficulty,
    required this.questionText,
    required this.questionTranslation,
    required this.choices,
  });

  Part5Question copyWith({
    String? id,
    String? questionCategory,
    String? questionSubType,
    String? difficulty,
    String? questionText,
    String? questionTranslation,
    List<Choice>? choices,
  }) {
    return Part5Question(
      id: id ?? this.id,
      questionCategory: questionCategory ?? this.questionCategory,
      questionSubType: questionSubType ?? this.questionSubType,
      difficulty: difficulty ?? this.difficulty,
      questionText: questionText ?? this.questionText,
      questionTranslation: questionTranslation ?? this.questionTranslation,
      choices: choices ?? this.choices,
    );
  }
}

// Part 5 Answer
class Part5Answer {
  final String id;
  final String answer;
  final String explanation;
  final List<VocabularyItem>? vocabulary;

  const Part5Answer({
    required this.id,
    required this.answer,
    required this.explanation,
    this.vocabulary,
  });

  Part5Answer copyWith({
    String? id,
    String? answer,
    String? explanation,
    List<VocabularyItem>? vocabulary,
  }) {
    return Part5Answer(
      id: id ?? this.id,
      answer: answer ?? this.answer,
      explanation: explanation ?? this.explanation,
      vocabulary: vocabulary ?? this.vocabulary,
    );
  }
}

// Vocabulary Item
class VocabularyItem {
  final String word;
  final String meaning;
  final String partOfSpeech;
  final String example;
  final String exampleTranslation;

  const VocabularyItem({
    required this.word,
    required this.meaning,
    required this.partOfSpeech,
    required this.example,
    required this.exampleTranslation,
  });

  VocabularyItem copyWith({
    String? word,
    String? meaning,
    String? partOfSpeech,
    String? example,
    String? exampleTranslation,
  }) {
    return VocabularyItem(
      word: word ?? this.word,
      meaning: meaning ?? this.meaning,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      example: example ?? this.example,
      exampleTranslation: exampleTranslation ?? this.exampleTranslation,
    );
  }
}

// Part 6 Question
class Part6Question {
  final int blankNumber;
  final String questionType;
  final List<Choice> choices;

  const Part6Question({
    required this.blankNumber,
    required this.questionType,
    required this.choices,
  });

  Part6Question copyWith({
    int? blankNumber,
    String? questionType,
    List<Choice>? choices,
  }) {
    return Part6Question(
      blankNumber: blankNumber ?? this.blankNumber,
      questionType: questionType ?? this.questionType,
      choices: choices ?? this.choices,
    );
  }
}

// Part 6 Set
class Part6Set {
  final String id;
  final String passageType;
  final String difficulty;
  final String passage;
  final String passageTranslation;
  final List<Part6Question> questions;

  const Part6Set({
    required this.id,
    required this.passageType,
    required this.difficulty,
    required this.passage,
    required this.passageTranslation,
    required this.questions,
  });

  Part6Set copyWith({
    String? id,
    String? passageType,
    String? difficulty,
    String? passage,
    String? passageTranslation,
    List<Part6Question>? questions,
  }) {
    return Part6Set(
      id: id ?? this.id,
      passageType: passageType ?? this.passageType,
      difficulty: difficulty ?? this.difficulty,
      passage: passage ?? this.passage,
      passageTranslation: passageTranslation ?? this.passageTranslation,
      questions: questions ?? this.questions,
    );
  }
}

// Part 6 Answer
class Part6Answer {
  final String setId;
  final int questionSeq;
  final String answer;
  final String explanation;

  const Part6Answer({
    required this.setId,
    required this.questionSeq,
    required this.answer,
    required this.explanation,
  });

  Part6Answer copyWith({
    String? setId,
    int? questionSeq,
    String? answer,
    String? explanation,
  }) {
    return Part6Answer(
      setId: setId ?? this.setId,
      questionSeq: questionSeq ?? this.questionSeq,
      answer: answer ?? this.answer,
      explanation: explanation ?? this.explanation,
    );
  }
}

// Part 7 Passage
class Part7Passage {
  final int seq;
  final String type;
  final String text;
  final String translation;

  const Part7Passage({
    required this.seq,
    required this.type,
    required this.text,
    required this.translation,
  });

  Part7Passage copyWith({
    int? seq,
    String? type,
    String? text,
    String? translation,
  }) {
    return Part7Passage(
      seq: seq ?? this.seq,
      type: type ?? this.type,
      text: text ?? this.text,
      translation: translation ?? this.translation,
    );
  }
}

// Part 7 Question
class Part7Question {
  final int questionSeq;
  final String questionType;
  final String questionText;
  final String questionTranslation;
  final List<Choice> choices;

  const Part7Question({
    required this.questionSeq,
    required this.questionType,
    required this.questionText,
    required this.questionTranslation,
    required this.choices,
  });

  Part7Question copyWith({
    int? questionSeq,
    String? questionType,
    String? questionText,
    String? questionTranslation,
    List<Choice>? choices,
  }) {
    return Part7Question(
      questionSeq: questionSeq ?? this.questionSeq,
      questionType: questionType ?? this.questionType,
      questionText: questionText ?? this.questionText,
      questionTranslation: questionTranslation ?? this.questionTranslation,
      choices: choices ?? this.choices,
    );
  }
}

// Part 7 Set
class Part7Set {
  final String id;
  final String difficulty;
  final String questionSetType;
  final List<Part7Passage> passages;
  final List<Part7Question> questions;

  const Part7Set({
    required this.id,
    required this.difficulty,
    required this.questionSetType,
    required this.passages,
    required this.questions,
  });

  Part7Set copyWith({
    String? id,
    String? difficulty,
    String? questionSetType,
    List<Part7Passage>? passages,
    List<Part7Question>? questions,
  }) {
    return Part7Set(
      id: id ?? this.id,
      difficulty: difficulty ?? this.difficulty,
      questionSetType: questionSetType ?? this.questionSetType,
      passages: passages ?? this.passages,
      questions: questions ?? this.questions,
    );
  }
}

// Part 7 Answer
class Part7Answer {
  final String setId;
  final int questionSeq;
  final String answer;
  final String explanation;

  const Part7Answer({
    required this.setId,
    required this.questionSeq,
    required this.answer,
    required this.explanation,
  });

  Part7Answer copyWith({
    String? setId,
    int? questionSeq,
    String? answer,
    String? explanation,
  }) {
    return Part7Answer(
      setId: setId ?? this.setId,
      questionSeq: questionSeq ?? this.questionSeq,
      answer: answer ?? this.answer,
      explanation: explanation ?? this.explanation,
    );
  }
}
