import 'package:flutter/material.dart';

import '../../models/patient_report.dart';

class ReportScreen extends StatelessWidget {
  final PatientReport report;

  const ReportScreen({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    final progress = report.learningProgress.clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity & Learning Report'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Patient Details'),
            _infoCard([
              _infoRow('Patient Name', report.patientName),
              _infoRow('Patient ID', report.patientId),
              _infoRow('Age', report.age),
              _infoRow('Gender', report.gender),
              _infoRow('Contact', report.contact),
              _infoRow('Hospital / Institution', report.hospital),
            ]),

            const SizedBox(height: 24),

            _sectionTitle('Sign Language Activity'),
            _infoCard([
              _infoRow(
                'Total Signs Detected',
                '${report.totalSigns}',
              ),
              _infoRow(
                'Signs Learned',
                '${report.signsLearned}',
              ),
              _infoRow(
                'Translation Sessions',
                '${report.translationSessions}',
              ),
            ]),

            const SizedBox(height: 24),

            _sectionTitle('Learning Progress'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lessons Completed: '
                      '${report.lessonsCompleted} / '
                      '${report.totalLessons}',
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Learning Progress: '
                      '${(progress * 100).toStringAsFixed(1)}%',
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Learned Signs',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (report.learnedSigns.isEmpty)
                      const Text('No learned signs recorded.')
                    else
                      ...report.learnedSigns.map(
                        (sign) => ListTile(
                          leading: const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          title: Text(sign),
                          dense: true,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            _sectionTitle('Translation History'),
            if (report.translations.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No translation history available.'),
                ),
              )
            else
              ...report.translations.map(
                (item) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(Icons.translate),
                    title: Text(item.translation),
                    subtitle: Text(
                      'Date: ${item.date}\n'
                      'Input: ${item.input}\n'
                      'Mode: ${item.mode}\n'
                      'Status: ${item.status}',
                    ),
                    isThreeLine: true,
                  ),
                ),
              ),

            const SizedBox(height: 24),

            _sectionTitle('Summary'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'The user has completed '
                  '${report.lessonsCompleted} lessons and learned '
                  '${report.signsLearned} signs. '
                  'A total of ${report.translationSessions} '
                  'translation sessions were recorded.',
                ),
              ),
            ),

            const SizedBox(height: 12),

            Card(
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Recommendation: Continue practicing frequently '
                  'used signs and complete the remaining learning '
                  'modules to improve Indian Sign Language skills.',
                ),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoCard(List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: children),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}