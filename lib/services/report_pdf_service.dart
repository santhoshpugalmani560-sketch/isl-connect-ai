import '../models/patient_report.dart';

class ReportPdfService {
  // PDF generation has been disabled.
  // This class remains temporarily to prevent import errors.
  // Report information will be displayed directly in the app.

  static Map<String, dynamic> getReportData(
    PatientReport report,
  ) {
    return {
      'patientName': report.patientName,
      'patientId': report.patientId,
      'age': report.age,
      'gender': report.gender,
      'contact': report.contact,
      'hospital': report.hospital,
      'totalSigns': report.totalSigns,
      'signsLearned': report.signsLearned,
      'translationSessions': report.translationSessions,
      'lessonsCompleted': report.lessonsCompleted,
      'totalLessons': report.totalLessons,
      'learningProgress': report.learningProgress,
      'learnedSigns': report.learnedSigns,
      'translations': report.translations,
    };
  }
}