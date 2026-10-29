import 'package:flutter/material.dart';

const Color backgroundColor = Color(0xFF080C19);
const Color cardColor = Color(0xFF1B2545);
const Color accentColor = Color(0xFF00D9E8);

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Learn ISL',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          _category(
            context,
            icon: Icons.abc,
            title: 'Alphabet (A-Z)',
            subtitle: 'Learn Indian Sign Language alphabets',
            color: Colors.blue,
            page: const AlphabetListScreen(),
          ),
          _category(
            context,
            icon: Icons.looks_one,
            title: 'Numbers (0-9)',
            subtitle: 'Learn numbers using ISL',
            color: Colors.green,
            page: const NumbersScreen(),
          ),
          _category(
            context,
            icon: Icons.waving_hand,
            title: 'Greetings',
            subtitle: 'Hello, Thank You, Sorry and more',
            color: Colors.orange,
            page: const PhraseListScreen(
              title: 'Greetings',
              phrases: [
                'Hello',
                'Thank you',
                'Sorry',
                'Please',
                'Good morning',
                'Good night',
                'Goodbye',
                'Welcome',
              ],
            ),
          ),
          _category(
            context,
            icon: Icons.chat,
            title: 'Daily Conversations',
            subtitle: 'Common words and sentences',
            color: Colors.purple,
            page: const PhraseListScreen(
              title: 'Daily Conversations',
              phrases: [
                'What is your name?',
                'My name is Santhosh',
                'How are you?',
                'I am happy',
                'I am hungry',
                'Please help me',
                'Where are you going?',
                'See you tomorrow',
              ],
            ),
          ),
          _category(
            context,
            icon: Icons.local_hospital,
            title: 'Emergency Signs',
            subtitle: 'Medical and emergency communication',
            color: Colors.red,
            page: const PhraseListScreen(
              title: 'Emergency Signs',
              phrases: [
                'Help',
                'Emergency',
                'Call an ambulance',
                'I need a doctor',
                'I need medical help',
                'Call the police',
                'Where is the hospital?',
                'I am in danger',
              ],
            ),
          ),
          _category(
            context,
            icon: Icons.school,
            title: 'Practice Quiz',
            subtitle: 'Test your ISL knowledge',
            color: Colors.teal,
            page: const PracticeQuizScreen(),
          ),
        ],
      ),
    );
  }

  Widget _category(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required Widget page,
  }) {
    return Card(
      color: cardColor,
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
        leading: CircleAvatar(
          radius: 27,
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(icon, color: color, size: 30),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 22,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
      ),
    );
  }
}

// ============================================================
// ALPHABET LIST A-Z
// ============================================================

class AlphabetListScreen extends StatelessWidget {
  const AlphabetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final letters = List.generate(
      26,
      (index) => String.fromCharCode(65 + index),
    );

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        title: const Text('Alphabet (A-Z)'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: letters.length,
        itemBuilder: (context, index) {
          final letter = letters[index];

          return Card(
            color: cardColor,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                backgroundColor: Colors.blue.withValues(alpha: 0.15),
                child: Text(
                  letter,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                letter,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              subtitle: const Text(
                'ISL learning lesson',
                style: TextStyle(color: Colors.white70),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 28,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AlphabetDetailScreen(
                      letter: letter,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// ALPHABET DETAIL
// ============================================================

class AlphabetDetailScreen extends StatelessWidget {
  final String letter;

  const AlphabetDetailScreen({
    super.key,
    required this.letter,
  });

  @override
  Widget build(BuildContext context) {
    final index = letter.codeUnitAt(0) - 65;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        title: Text('Letter $letter'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                letter,
                style: const TextStyle(
                  fontSize: 110,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Learn the letter $letter',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Alphabet learning lesson',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              'Practice identifying this letter. Look at a verified '
              'Indian Sign Language reference and carefully observe '
              'the handshape, finger positions and movement.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'ISL Sign Reference',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 190,
            decoration: BoxDecoration(
              color: const Color(0xFF11182D),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white24),
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Your verified ISL handshape image or video '
                  'will appear here when you add the learning media.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    height: 1.5,
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
    );
  }
}

// ============================================================
// NUMBERS 0-9
// ============================================================

class NumbersScreen extends StatelessWidget {
  const NumbersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        title: const Text('Numbers (0-9)'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1.25,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NumberDetailScreen(number: index),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 58,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NumberDetailScreen extends StatelessWidget {
  final int number;

  const NumberDetailScreen({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        title: Text('Number $number'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 120,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Number lesson',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Add a verified ISL number sign image or video '
                'to learn the correct handshape.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// GREETINGS, CONVERSATIONS AND EMERGENCY PHRASES
// ============================================================

class PhraseListScreen extends StatelessWidget {
  final String title;
  final List<String> phrases;

  const PhraseListScreen({
    super.key,
    required this.title,
    required this.phrases,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        title: Text(title),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: phrases.length,
        itemBuilder: (context, index) {
          final phrase = phrases[index];

          return Card(
            color: cardColor,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: accentColor.withValues(alpha: 0.15),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                phrase,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'ISL learning reference',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PhraseDetailScreen(
                      phrase: phrase,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class PhraseDetailScreen extends StatelessWidget {
  final String phrase;

  const PhraseDetailScreen({
    super.key,
    required this.phrase,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        title: const Text('Phrase Lesson'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                phrase,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Practice this expression using a verified ISL '
              'reference. Some English phrases require multiple '
              'signs rather than one sign.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    'Add the corresponding verified ISL image '
                    'or video here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PRACTICE QUIZ
// ============================================================

class PracticeQuizScreen extends StatefulWidget {
  const PracticeQuizScreen({super.key});

  @override
  State<PracticeQuizScreen> createState() => _PracticeQuizScreenState();
}

class _PracticeQuizScreenState extends State<PracticeQuizScreen> {
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Which letter comes first in the English alphabet?',
      'options': ['A', 'B', 'C', 'D'],
      'answer': 'A',
    },
    {
      'question': 'Which number comes after 4?',
      'options': ['3', '5', '6', '7'],
      'answer': '5',
    },
    {
      'question': 'How should you learn an ISL handshape?',
      'options': [
        'Guess the movement',
        'Use a verified ISL reference',
        'Ignore finger positions',
        'Copy any random gesture',
      ],
      'answer': 'Use a verified ISL reference',
    },
    {
      'question': 'What should you do if you need emergency help?',
      'options': [
        'Stay silent',
        'Communicate your need for help',
        'Walk away',
        'Ignore the situation',
      ],
      'answer': 'Communicate your need for help',
    },
    {
      'question': 'What does ISL stand for?',
      'options': [
        'Indian Sign Language',
        'International Sound List',
        'Indian Speech Learning',
        'Internet Sign Link',
      ],
      'answer': 'Indian Sign Language',
    },
  ];

  int currentQuestion = 0;
  int score = 0;
  String? selectedAnswer;
  bool answered = false;

  void chooseAnswer(String answer) {
    if (answered) return;

    setState(() {
      selectedAnswer = answer;
      answered = true;

      if (answer == questions[currentQuestion]['answer']) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (!answered) return;

    if (currentQuestion == questions.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => QuizResultScreen(
            score: score,
            total: questions.length,
          ),
        ),
      );
      return;
    }

    setState(() {
      currentQuestion++;
      selectedAnswer = null;
      answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];
    final List<String> options =
        List<String>.from(question['options'] as List);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        title: const Text('Practice Quiz'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: (currentQuestion + 1) / questions.length,
              backgroundColor: cardColor,
              color: accentColor,
              minHeight: 7,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 18),
            Text(
              'Question ${currentQuestion + 1} of ${questions.length}',
              style: const TextStyle(
                color: accentColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              question['question'] as String,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            ...options.map((option) {
              Color tileColor = cardColor;

              if (answered && option == question['answer']) {
                tileColor = Colors.green.shade800;
              } else if (answered && option == selectedAnswer) {
                tileColor = Colors.red.shade800;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  tileColor: tileColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  title: Text(
                    option,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  trailing: answered && option == question['answer']
                      ? const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        )
                      : null,
                  onTap: () => chooseAnswer(option),
                ),
              );
            }),
            const Spacer(),
            ElevatedButton(
              onPressed: answered ? nextQuestion : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(16),
              ),
              child: Text(
                currentQuestion == questions.length - 1
                    ? 'See Results'
                    : 'Next Question',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const QuizResultScreen({
    super.key,
    required this.score,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        title: const Text('Quiz Results'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.emoji_events,
                color: Colors.amber,
                size: 90,
              ),
              const SizedBox(height: 24),
              const Text(
                'Quiz Completed!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '$score / $total',
                style: const TextStyle(
                  color: accentColor,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                score == total
                    ? 'Excellent work!'
                    : 'Keep practising Indian Sign Language!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PracticeQuizScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.popUntil(
                    context,
                    (route) => route.isFirst,
                  );
                },
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
