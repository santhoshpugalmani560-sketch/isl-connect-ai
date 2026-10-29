import 'package:flutter/material.dart';

class AIAssistantScreen extends StatefulWidget {
  const AIAssistantScreen({super.key});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, String>> messages = [
    {
      "sender": "AI",
      "message":
          "Hello! 👋 I am your ISL CONNECT AI Assistant.\n\n"
          "I can help you understand Indian Sign Language, "
          "translation features, camera detection, learning, "
          "Emergency SOS, reports and other features of this app.\n\n"
          "Ask me anything about the app.",
    },
  ];

  // ============================================================
  // OFFLINE KNOWLEDGE BASE
  // ============================================================

  String getAIResponse(String question) {
    final text = question.toLowerCase().trim();

    // ==========================================================
    // GREETINGS
    // ==========================================================

    if (text == "hi" ||
        text == "hello" ||
        text == "hey" ||
        text.contains("good morning") ||
        text.contains("good evening")) {
      return "Hello! 👋\n\n"
          "Welcome to ISL CONNECT AI.\n\n"
          "I am your offline assistant. I can explain the "
          "features of this application, Indian Sign Language, "
          "translation modes, camera detection, learning, "
          "Emergency SOS and patient reports.\n\n"
          "What would you like to know?";
    }

    // ==========================================================
    // ABOUT ISL
    // ==========================================================

    if (text.contains("what is isl") ||
        text.contains("what does isl mean") ||
        text.contains("indian sign language") ||
        text.contains("tell me about isl")) {
      return "Indian Sign Language (ISL) is a visual language "
          "used by the Deaf and hard-of-hearing community in India.\n\n"
          "ISL uses hand movements, gestures, facial expressions "
          "and body movements to communicate.\n\n"
          "ISL CONNECT AI is designed to reduce communication "
          "barriers by providing AI-assisted sign recognition, "
          "translation and learning features.";
    }

    // ==========================================================
    // PURPOSE / OBJECTIVE
    // ==========================================================

    if (text.contains("objective") ||
        text.contains("purpose of this project") ||
        text.contains("aim of this project") ||
        text.contains("why this app") ||
        text.contains("why isl connect")) {
      return "The main objective of ISL CONNECT AI is to reduce "
          "communication barriers between Deaf and hearing people.\n\n"
          "The application provides:\n\n"
          "• Speech → Sign\n"
          "• Text → Sign\n"
          "• Camera Sign Detection\n"
          "• Sign → Text\n"
          "• Sign → Speech\n"
          "• ISL Learning\n"
          "• AI Assistant\n"
          "• Patient Activity Reports\n"
          "• Emergency SOS\n"
          "• Relay Support\n\n"
          "The overall goal is to make communication more "
          "accessible and convenient.";
    }

    // ==========================================================
    // WHAT CAN APP DO
    // ==========================================================

    if (text.contains("what can this app do") ||
        text.contains("features") ||
        text.contains("app features") ||
        text.contains("what does this app do") ||
        text.contains("how does this app work")) {
      return "ISL CONNECT AI is an accessibility application "
          "for Indian Sign Language communication.\n\n"
          "Main features include:\n\n"
          "1. Speech to Sign – converts spoken language into ISL.\n"
          "2. Text to Sign – converts typed text into ISL.\n"
          "3. Camera Sign Detection – recognizes supported signs "
          "using the camera and AI model.\n"
          "4. Sign to Text – converts recognized signs into text.\n"
          "5. Sign to Speech – speaks the detected sign.\n"
          "6. Learn – helps users practice ISL signs.\n"
          "7. AI Assistant – provides offline app and ISL guidance.\n"
          "8. Emergency SOS – provides quick emergency assistance.\n"
          "9. Patient Activity Report – records learning and "
          "translation activity.\n"
          "10. Relay – provides live communication support.";
    }

    // ==========================================================
    // SPEECH TO SIGN
    // ==========================================================

    if (text.contains("speech to sign") ||
        text.contains("speech-to-sign") ||
        text.contains("voice to sign") ||
        text.contains("how does speech work")) {
      return "Speech to Sign converts a person's spoken words "
          "into Indian Sign Language.\n\n"
          "Basic process:\n\n"
          "1. The user speaks into the microphone.\n"
          "2. Speech is converted into text.\n"
          "3. The application identifies the supported words.\n"
          "4. The corresponding ISL representation is displayed.\n\n"
          "This feature can help hearing users communicate with "
          "people who use ISL.";
    }

    // ==========================================================
    // TEXT TO SIGN
    // ==========================================================

    if (text.contains("text to sign") ||
        text.contains("text-to-sign") ||
        text.contains("convert text") ||
        text.contains("typed text")) {
      return "Text to Sign converts written text into an "
          "Indian Sign Language representation.\n\n"
          "The user enters a word or sentence, and the application "
          "processes the text and displays the supported ISL signs.\n\n"
          "Open:\n"
          "Translate → Text to Sign";
    }

    // ==========================================================
    // CAMERA SIGN DETECTION
    // ==========================================================

    if (text.contains("camera") ||
        text.contains("camera detection") ||
        text.contains("sign detection") ||
        text.contains("detect sign") ||
        text.contains("how camera works")) {
      return "Camera Sign Detection uses your device camera "
          "to capture a hand gesture.\n\n"
          "The normal AI detection process is:\n\n"
          "1. Camera captures the hand gesture.\n"
          "2. The image is resized to the model's input size.\n"
          "3. The image is passed to the TFLite AI model.\n"
          "4. The model predicts a sign class.\n"
          "5. The application finds the corresponding label.\n"
          "6. The predicted sign and confidence are displayed.\n\n"
          "For real detection, the application must contain a "
          "properly trained ISL TFLite model.";
    }

    // ==========================================================
    // TFLITE / AI MODEL
    // ==========================================================

    if (text.contains("tflite") ||
        text.contains("tensorflow") ||
        text.contains("ai model") ||
        text.contains("machine learning model") ||
        text.contains("how ai detects signs")) {
      return "The TFLite model is the machine-learning model "
          "used for sign recognition.\n\n"
          "It receives an image from the camera and predicts "
          "which trained sign class is present.\n\n"
          "The model is stored inside:\n\n"
          "assets/models/isl_sign_model.tflite\n\n"
          "The corresponding class names are stored in:\n\n"
          "assets/models/labels.txt\n\n"
          "Important: adding a new name to labels.txt does not "
          "teach the AI a new sign. The sign must be included "
          "when the model is trained.";
    }

    // ==========================================================
    // 500+ SIGNS
    // ==========================================================

    if (text.contains("500") ||
        text.contains("500 signs") ||
        text.contains("more signs") ||
        text.contains("add signs") ||
        text.contains("1000 signs")) {
      return "The application can be designed to support 500+ "
          "ISL signs, but the AI model itself must be trained "
          "with those sign classes.\n\n"
          "For a 500-sign model:\n\n"
          "• Collect a suitable ISL dataset.\n"
          "• Organize images/videos by sign class.\n"
          "• Train the machine-learning model.\n"
          "• Export the trained model as TFLite.\n"
          "• Put the model in assets/models/.\n"
          "• Create labels.txt in exactly the same class order.\n"
          "• Connect the model to CameraSignScreen.\n\n"
          "Simply adding 500 labels to labels.txt will not create "
          "a 500-sign AI model.";
    }

    // ==========================================================
    // SIGN TO TEXT
    // ==========================================================

    if (text.contains("sign to text") ||
        text.contains("sign-to-text")) {
      return "Sign to Text converts a recognized ISL gesture "
          "into written text.\n\n"
          "The camera captures the gesture, the AI model predicts "
          "the sign, and the detected word is displayed as text.\n\n"
          "This can help an ISL user communicate with someone "
          "who does not understand sign language.";
    }

    // ==========================================================
    // SIGN TO SPEECH
    // ==========================================================

    if (text.contains("sign to speech") ||
        text.contains("sign-to-speech") ||
        text.contains("speak detected sign") ||
        text.contains("speak result")) {
      return "Sign to Speech converts a recognized sign into "
          "spoken audio.\n\n"
          "The process is:\n\n"
          "Camera → AI Detection → Text → Text-to-Speech\n\n"
          "For example, if the AI recognizes 'Hello', the "
          "application can display 'Hello' and speak the word.";
    }

    // ==========================================================
    // HELLO
    // ==========================================================

    if (text == "hello" ||
        text.contains("hello sign") ||
        text.contains("sign for hello") ||
        text.contains("how to say hello")) {
      return "Hello is a common greeting sign in ISL.\n\n"
          "To learn the exact hand movement, open the Learn "
          "section and select the Hello lesson.\n\n"
          "The camera AI can recognize Hello only if the "
          "installed model has been trained for the Hello class.";
    }

    // ==========================================================
    // THANK YOU
    // ==========================================================

    if (text.contains("thank you") ||
        text.contains("thanks") ||
        text.contains("thank-you sign")) {
      return "Thank You is an important everyday ISL sign.\n\n"
          "You can practice it through the Learn section.\n\n"
          "For camera recognition, the AI model must contain "
          "a trained Thank You class.";
    }

    // ==========================================================
    // YES
    // ==========================================================

    if (text == "yes" ||
        text.contains("sign for yes") ||
        text.contains("how to say yes")) {
      return "Yes is a basic communication sign.\n\n"
          "Open Learn → Basic Signs → Yes to practice it.\n\n"
          "The camera model must be trained with the Yes class "
          "before real AI detection is possible.";
    }

    // ==========================================================
    // NO
    // ==========================================================

    if (text == "no" ||
        text.contains("sign for no") ||
        text.contains("how to say no")) {
      return "No is a basic communication sign.\n\n"
          "Open Learn → Basic Signs → No to practice it.\n\n"
          "The camera model must contain a trained No class "
          "for real-time recognition.";
    }

    // ==========================================================
    // WATER
    // ==========================================================

    if (text.contains("water") ||
        text.contains("water sign")) {
      return "Water is an important everyday ISL sign.\n\n"
          "You can find and practice Water in the Learn section.\n\n"
          "For AI camera detection, Water must be included "
          "in the trained model.";
    }

    // ==========================================================
    // FOOD
    // ==========================================================

    if (text.contains("food") ||
        text.contains("eat") ||
        text.contains("eating")) {
      return "Food and eating are useful everyday communication "
          "signs.\n\n"
          "You can add them to the ISL learning vocabulary and "
          "AI model when supported by your dataset.";
    }

    // ==========================================================
    // HELP
    // ==========================================================

    if (text == "help" ||
        text.contains("help sign") ||
        text.contains("how to ask for help")) {
      return "Help is an important everyday and emergency "
          "communication sign.\n\n"
          "You can practice the Help sign through Learn.\n\n"
          "If there is a real emergency, use the Emergency SOS "
          "feature rather than depending only on the AI assistant.";
    }

    // ==========================================================
    // DOCTOR
    // ==========================================================

    if (text.contains("doctor") ||
        text.contains("doctor sign")) {
      return "Doctor is a useful healthcare-related ISL sign.\n\n"
          "Healthcare vocabulary is especially useful for "
          "communication in hospitals and clinics.\n\n"
          "You can include Doctor in your learning content and "
          "AI model vocabulary.";
    }

    // ==========================================================
    // HOSPITAL
    // ==========================================================

    if (text.contains("hospital") ||
        text.contains("hospital sign")) {
      return "Hospital is an important healthcare communication "
          "term.\n\n"
          "ISL CONNECT AI can support hospital communication "
          "through camera detection, Speech to Sign, Sign to "
          "Speech and learning features.";
    }

    // ==========================================================
    // EMERGENCY
    // ==========================================================

    if (text.contains("emergency") ||
        text.contains("sos") ||
        text.contains("emergency help")) {
      return "Emergency SOS is a safety feature of ISL CONNECT AI.\n\n"
          "It is designed to help the user quickly notify "
          "emergency contacts and share their location when "
          "properly configured.\n\n"
          "For a real emergency, contact local emergency services "
          "as appropriate. The app should not be treated as a "
          "replacement for emergency services.";
    }

    // ==========================================================
    // LEARN
    // ==========================================================

    if (text.contains("learn") ||
        text.contains("learning") ||
        text.contains("lesson") ||
        text.contains("practice isl") ||
        text.contains("how can i learn")) {
      return "The Learn section is designed to help users "
          "practice Indian Sign Language.\n\n"
          "You can organize lessons into categories such as:\n\n"
          "• Basic signs\n"
          "• Greetings\n"
          "• Food\n"
          "• Healthcare\n"
          "• Emergency\n"
          "• Numbers\n"
          "• Everyday communication\n\n"
          "Start with basic signs and gradually increase the "
          "difficulty.";
    }

    // ==========================================================
    // RELAY
    // ==========================================================

    if (text.contains("relay") ||
        text.contains("live support")) {
      return "Relay is designed to provide live communication "
          "support.\n\n"
          "It can be useful when a user needs assistance "
          "communicating with another person in a situation "
          "where normal communication is difficult.";
    }

    // ==========================================================
    // HISTORY
    // ==========================================================

    if (text.contains("history") ||
        text.contains("recent history") ||
        text.contains("translation history")) {
      return "Recent History can show previous communication "
          "activities such as Speech to Sign, Camera Detection "
          "and Text to Sign.\n\n"
          "History helps users review previous translation activity.";
    }

    // ==========================================================
    // PATIENT REPORT
    // ==========================================================

    if (text.contains("patient report") ||
        text.contains("activity report") ||
        text.contains("learning report") ||
        text.contains("patient activity")) {
      return "Patient Activity & Learning Report is designed "
          "to summarize a patient's communication and learning "
          "activity.\n\n"
          "It can include:\n\n"
          "• Patient details\n"
          "• Learned signs\n"
          "• Learning progress\n"
          "• Translation history\n"
          "• Activity information\n\n"
          "The report can be exported as a PDF when the report "
          "and PDF functionality are configured.";
    }

    // ==========================================================
    // PDF
    // ==========================================================

    if (text.contains("pdf") ||
        text.contains("export report") ||
        text.contains("download report")) {
      return "The Patient Activity Report can be exported as a "
          "PDF using the report screen.\n\n"
          "The PDF can contain patient information, learned signs, "
          "translation history and activity details.\n\n"
          "The exact information depends on the data connected "
          "to the report.";
    }

    // ==========================================================
    // PROFILE
    // ==========================================================

    if (text.contains("profile") ||
        text.contains("my profile") ||
        text.contains("change password")) {
      return "The Profile section contains the user's profile "
          "information and application settings.\n\n"
          "Depending on your implementation, it can include:\n\n"
          "• Edit Profile\n"
          "• Change Password\n"
          "• Notifications\n"
          "• Dark Mode\n"
          "• About App\n"
          "• Logout";
    }

    // ==========================================================
    // DARK MODE
    // ==========================================================

    if (text.contains("dark mode") ||
        text.contains("dark theme")) {
      return "Dark Mode changes the application's appearance "
          "to a darker interface.\n\n"
          "It can make the interface more comfortable to use "
          "in low-light conditions.";
    }

    // ==========================================================
    // CAMERA TROUBLESHOOTING
    // ==========================================================

    if (text.contains("camera not working") ||
        text.contains("camera doesn't work") ||
        text.contains("camera does not work") ||
        text.contains("camera problem") ||
        text.contains("camera issue") ||
        text.contains("camera not opening")) {
      return "If the camera is not working, check these steps:\n\n"
          "1. Make sure camera permission is enabled.\n"
          "2. Close other apps using the camera.\n"
          "3. Restart the application.\n"
          "4. Check that your device has a working camera.\n"
          "5. Make sure the CameraController initializes correctly.\n"
          "6. Check the Flutter camera package configuration.\n\n"
          "If the camera opens but AI does not detect signs, "
          "the problem may be the TFLite model rather than "
          "the camera.";
    }

    // ==========================================================
    // NO SIGN DETECTED
    // ==========================================================

    if (text.contains("no sign detected") ||
        text.contains("not detecting") ||
        text.contains("sign is not detected")) {
      return "If the app shows 'No Sign Detected':\n\n"
          "• Make sure your hand is clearly visible.\n"
          "• Use good lighting.\n"
          "• Keep your hand inside the camera frame.\n"
          "• Avoid a very complicated background.\n"
          "• Hold the sign correctly.\n"
          "• Make sure the sign belongs to a class supported "
          "by the trained AI model.\n\n"
          "A label added to labels.txt alone cannot teach the "
          "AI a new sign.";
    }

    // ==========================================================
    // LOW CONFIDENCE
    // ==========================================================

    if (text.contains("low confidence") ||
        text.contains("confidence is low") ||
        text.contains("why confidence")) {
      return "Confidence represents how strongly the model "
          "supports its prediction.\n\n"
          "Low confidence can happen because of poor lighting, "
          "incorrect hand position, motion, background noise, "
          "an unfamiliar gesture or insufficient training data.\n\n"
          "Try performing the sign clearly in good lighting.";
    }

    // ==========================================================
    // AI MODEL NOT LOADED
    // ==========================================================

    if (text.contains("model not loaded") ||
        text.contains("model not connected") ||
        text.contains("ai model not connected") ||
        text.contains("model error")) {
      return "If the AI model is not loaded, check:\n\n"
          "1. The file exists at:\n"
          "assets/models/isl_sign_model.tflite\n\n"
          "2. The model path is included in pubspec.yaml.\n\n"
          "3. labels.txt exists in the same models folder.\n\n"
          "4. Run:\n"
          "flutter clean\n"
          "flutter pub get\n"
          "flutter run\n\n"
          "Also make sure the .tflite file is a real trained "
          "TensorFlow Lite model and not an empty file or folder.";
    }

    // ==========================================================
    // INTERNET / OFFLINE
    // ==========================================================

    if (text.contains("offline") ||
        text.contains("internet") ||
        text.contains("without internet")) {
      return "This AI Assistant works offline.\n\n"
          "It does not require an internet connection or an API key "
          "because its answers are built into the application.\n\n"
          "However, online services may still be required by other "
          "features if you connect them to external servers.";
    }

    // ==========================================================
    // API
    // ==========================================================

    if (text.contains("api") ||
        text.contains("api key") ||
        text.contains("chatgpt")) {
      return "The current AI Assistant is an offline assistant, "
          "so it does not require an AI API or API key.\n\n"
          "It uses a built-in knowledge base and keyword matching "
          "to answer common ISL CONNECT AI questions.";
    }

    // ==========================================================
    // TECHNOLOGY
    // ==========================================================

    if (text.contains("technology") ||
        text.contains("technologies used") ||
        text.contains("which technology")) {
      return "ISL CONNECT AI can use technologies such as:\n\n"
          "• Flutter – mobile application development\n"
          "• Dart – application programming language\n"
          "• Camera – image capture\n"
          "• TensorFlow Lite – on-device sign recognition\n"
          "• Text-to-Speech – spoken output\n"
          "• PDF generation – patient reports\n"
          "• Local offline knowledge – AI Assistant\n\n"
          "The exact implementation depends on the components "
          "configured in the project.";
    }

    // ==========================================================
    // ADVANTAGES
    // ==========================================================

    if (text.contains("advantages") ||
        text.contains("benefits")) {
      return "Major advantages of ISL CONNECT AI include:\n\n"
          "• Helps reduce communication barriers.\n"
          "• Supports multiple translation methods.\n"
          "• Provides ISL learning support.\n"
          "• Can perform AI inference locally when a compatible "
          "TFLite model is installed.\n"
          "• Provides Emergency SOS support.\n"
          "• Provides patient activity reporting.\n"
          "• Offers an offline application assistant.";
    }

    // ==========================================================
    // FUTURE SCOPE
    // ==========================================================

    if (text.contains("future scope") ||
        text.contains("future") ||
        text.contains("improvements")) {
      return "Possible future improvements include:\n\n"
          "• 500+ ISL word recognition.\n"
          "• Real-time continuous sign detection.\n"
          "• More accurate hand and pose tracking.\n"
          "• Animated 3D ISL avatar.\n"
          "• More healthcare vocabulary.\n"
          "• Multilingual speech support.\n"
          "• Improved patient analytics.\n"
          "• Cloud synchronization.\n"
          "• Personalized learning progress.\n"
          "• More advanced AI assistance.";
    }

    // ==========================================================
    // SECURITY / PRIVACY
    // ==========================================================

    if (text.contains("privacy") ||
        text.contains("security") ||
        text.contains("data")) {
      return "For an offline assistant, the built-in questions "
          "and answers are processed locally in the application.\n\n"
          "For other features, privacy depends on how your app "
          "stores camera images, patient information, reports "
          "and any external services you connect.";
    }

    // ==========================================================
    // PROJECT PRESENTATION
    // ==========================================================

    if (text.contains("explain project") ||
        text.contains("project explanation") ||
        text.contains("project presentation")) {
      return "ISL CONNECT AI is an accessibility-focused mobile "
          "application designed to support Indian Sign Language "
          "communication.\n\n"
          "The system combines translation, AI-based sign "
          "recognition, learning tools, communication support "
          "and emergency assistance in one application.\n\n"
          "Its main goal is to make communication easier between "
          "ISL users and people who do not know sign language.";
    }

    // ==========================================================
    // HOW TO USE APP
    // ==========================================================

    if (text.contains("how to use") ||
        text.contains("use the app") ||
        text.contains("getting started") ||
        text.contains("start using")) {
      return "To start using ISL CONNECT AI:\n\n"
          "1. Open the application.\n"
          "2. Use Translate for communication modes.\n"
          "3. Use Camera Sign Detection for camera-based signs.\n"
          "4. Use Learn to practice ISL.\n"
          "5. Use AI Assistant for app guidance.\n"
          "6. Use Recent History to review activities.\n"
          "7. Use Patient Activity Report for reports.\n"
          "8. Use Emergency SOS during emergency situations.\n\n"
          "Start with the Learn section if you are new to ISL.";
    }

    // ==========================================================
    // THANK YOU / BYE
    // ==========================================================

    if (text.contains("bye") ||
        text.contains("goodbye")) {
      return "Goodbye! 👋\n\n"
          "Keep learning Indian Sign Language with ISL CONNECT AI.";
    }

    if (text.contains("thank you") ||
        text == "thanks") {
      return "You're welcome! 😊\n\n"
          "I'm always ready to explain ISL CONNECT AI features.";
    }

    // ==========================================================
    // DEFAULT
    // ==========================================================

    return "I couldn't find an exact answer for that question.\n\n"
        "I can explain these topics:\n\n"
        "📘 Indian Sign Language\n"
        "📱 ISL CONNECT AI features\n"
        "🎤 Speech → Sign\n"
        "⌨️ Text → Sign\n"
        "📷 Camera Sign Detection\n"
        "📝 Sign → Text\n"
        "🔊 Sign → Speech\n"
        "🧠 TFLite AI Model\n"
        "📚 ISL Learning\n"
        "🚨 Emergency SOS\n"
        "📊 Patient Activity Report\n"
        "📜 Translation History\n"
        "📞 Relay Support\n"
        "👤 Profile\n"
        "🔧 Troubleshooting\n"
        "💡 Project Objective & Future Scope\n\n"
        "Try asking: \"How does camera detection work?\"";
  }

  // ============================================================
  // SEND MESSAGE
  // ============================================================

  void sendMessage() {
    final question = _controller.text.trim();

    if (question.isEmpty) return;

    final response = getAIResponse(question);

    setState(() {
      messages.add({
        "sender": "You",
        "message": question,
      });

      messages.add({
        "sender": "AI",
        "message": response,
      });
    });

    _controller.clear();

    _scrollToBottom();
  }

  // ============================================================
  // SCROLL TO BOTTOM
  // ============================================================

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ============================================================
  // UI
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070B18),

      appBar: AppBar(
        backgroundColor: const Color(0xFF070B18),
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "AI Assistant",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [

          // ==========================================================
          // CHAT
          // ==========================================================

          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,

              itemBuilder: (context, index) {
                final msg = messages[index];

                final isUser =
                    msg["sender"] == "You";

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,

                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                    ),

                    padding: const EdgeInsets.all(14),

                    constraints:
                        const BoxConstraints(
                      maxWidth: 330,
                    ),

                    decoration: BoxDecoration(
                      color: isUser
                          ? const Color(0xFF00BCD4)
                          : const Color(0xFFE5E7EB),

                      borderRadius:
                          BorderRadius.circular(16),
                    ),

                    child: Text(
                      msg["message"]!,

                      style: TextStyle(
                        color: isUser
                            ? Colors.white
                            : Colors.black87,

                        fontSize: 15,

                        height: 1.45,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ==========================================================
          // INPUT
          // ==========================================================

          Container(
            padding: const EdgeInsets.fromLTRB(
              10,
              10,
              10,
              12,
            ),

            decoration: const BoxDecoration(
              color: Color(0xFF101936),
            ),

            child: Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: _controller,

                    style: const TextStyle(
                      color: Colors.white,
                    ),

                    textInputAction:
                        TextInputAction.send,

                    onSubmitted: (_) {
                      sendMessage();
                    },

                    decoration:
                        InputDecoration(
                      hintText:
                          "Ask something about ISL...",

                      hintStyle:
                          const TextStyle(
                        color: Colors.white70,
                      ),

                      filled: true,

                      fillColor:
                          const Color(0xFF18213F),

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),

                        borderSide:
                            BorderSide.none,
                      ),

                      contentPadding:
                          const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Container(
                  width: 52,
                  height: 52,

                  decoration:
                      const BoxDecoration(
                    color: Color(0xFF00BCD4),
                    shape: BoxShape.circle,
                  ),

                  child: IconButton(
                    onPressed: sendMessage,

                    icon: const Icon(
                      Icons.send,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}