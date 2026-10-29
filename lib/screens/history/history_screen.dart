import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> history = [
      {
        "title": "Speech to Sign",
        "result": "Hello, How are you?",
        "time": "Today, 10:30 AM",
      },
      {
        "title": "Sign to Text",
        "result": "Good Morning",
        "time": "Yesterday, 5:15 PM",
      },
      {
        "title": "AI Assistant",
        "result": "Explain Indian Sign Language",
        "time": "Yesterday, 2:40 PM",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
      ),
      body: history.isEmpty
          ? const Center(
              child: Text(
                "No history available.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        item["title"] == "AI Assistant"
                            ? Icons.smart_toy
                            : Icons.history,
                      ),
                    ),
                    title: Text(
                      item["title"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(item["result"]!),
                    trailing: Text(
                      item["time"]!,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                );
              },
            ),
    );
  }
}