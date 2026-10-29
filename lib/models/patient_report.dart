class PatientReport {
  final String patientName;
  final String patientId;
  final String age;
  final String gender;
  final String contact;
  final String hospital;

  final int totalSigns;
  final int signsLearned;
  final int lessonsCompleted;
  final int totalLessons;
  final int translationSessions;

  final List<String> learnedSigns;
  final List<TranslationRecord> translations;

  PatientReport({
    required this.patientName,
    required this.patientId,
    required this.age,
    required this.gender,
    required this.contact,
    required this.hospital,
    required this.totalSigns,
    required this.signsLearned,
    required this.lessonsCompleted,
    required this.totalLessons,
    required this.translationSessions,
    required this.learnedSigns,
    required this.translations,
  });

  double get learningProgress {
    if (totalLessons == 0) {
      return 0;
    }

    return lessonsCompleted / totalLessons;
  }
}

class TranslationRecord {
  final String date;
  final String input;
  final String translation;
  final String mode;
  final String status;

  TranslationRecord({
    required this.date,
    required this.input,
    required this.translation,
    required this.mode,
    required this.status,
  });
}