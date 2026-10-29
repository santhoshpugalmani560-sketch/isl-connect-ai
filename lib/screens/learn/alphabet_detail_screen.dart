import 'package:flutter/material.dart';

class AlphabetDetailScreen extends StatelessWidget {
  final String letter;

  const AlphabetDetailScreen({
    super.key,
    required this.letter,
  });

  @override
  Widget build(BuildContext context) {
    final int index = letter.codeUnitAt(0) - 65;

    return Scaffold(
      appBar: AppBar(
        title: Text('ISL Letter $letter'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFF1B2545),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  letter,
                  style: const TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Letter $letter',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Indian Sign Language lesson',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1B2545),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'Learn the correct handshape and movement for this '
                'letter using a verified Indian Sign Language '
                'reference image or video.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Sign reference',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Add a verified ISL sign image here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: index > 0
                        ? () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AlphabetDetailScreen(
                                  letter: String.fromCharCode(
                                    65 + index - 1,
                                  ),
                                ),
                              ),
                            );
                          }
                        : null,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: index < 25
                        ? () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AlphabetDetailScreen(
                                  letter: String.fromCharCode(
                                    65 + index + 1,
                                  ),
                                ),
                              ),
                            );
                          }
                        : null,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Next'),
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