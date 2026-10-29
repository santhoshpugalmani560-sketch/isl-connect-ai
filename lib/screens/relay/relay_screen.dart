import 'package:flutter/material.dart';

class RelayScreen extends StatefulWidget {
  const RelayScreen({super.key});

  @override
  State<RelayScreen> createState() => _RelayScreenState();
}

class _RelayScreenState extends State<RelayScreen> {
  bool _isRelayActive = false;
  bool _isListening = false;
  bool _isSpeaking = false;

  String _detectedSign = "Hello";
  String _translatedText = "Hello, how can I help you?";

  // ============================================================
  // START / STOP RELAY
  // ============================================================

  void _toggleRelay() {
    setState(() {
      _isRelayActive = !_isRelayActive;
    });

    _showMessage(
      _isRelayActive
          ? "Live Relay started."
          : "Live Relay stopped.",
    );
  }

  // ============================================================
  // VOICE LISTENING
  // ============================================================

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
    });

    if (_isListening) {
      _showMessage("Listening for voice input...");
    } else {
      _showMessage("Voice input stopped.");
    }
  }

  // ============================================================
  // SPEAK RESULT
  // ============================================================

  void _speakResult() {
    if (_isSpeaking) return;

    setState(() {
      _isSpeaking = true;
    });

    _showMessage("Speaking translated message...");

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() {
        _isSpeaking = false;
      });
    });
  }

  // ============================================================
  // EMERGENCY RELAY
  // ============================================================

  void _emergencyRelay() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF151F3A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.warning_rounded,
                color: Colors.redAccent,
              ),
              SizedBox(width: 10),
              Text(
                "Emergency Relay",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            "Send the current translated message as an emergency communication?",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white60,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);

                _showMessage(
                  "Emergency relay message sent.",
                );
              },
              child: const Text(
                "SEND",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // RESET
  // ============================================================

  void _resetRelay() {
    setState(() {
      _isRelayActive = false;
      _isListening = false;
      _isSpeaking = false;
      _detectedSign = "Hello";
      _translatedText = "Hello, how can I help you?";
    });

    _showMessage("Relay session reset.");
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08111F),

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: const Color(0xFF08111F),
        elevation: 0,

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),

        title: const Text(
          "Relay Service",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        actions: [
          IconButton(
            tooltip: "Reset",
            onPressed: _resetRelay,
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: Container(
        width: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF08111F),
              Color(0xFF0B1736),
              Color(0xFF111C44),
            ],
          ),
        ),

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ==================================================
              // HEADER
              // ==================================================

              const Text(
                "Live Communication Relay",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                "Bridge communication between Indian Sign Language and spoken language.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // CONNECTION STATUS
              // ==================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),

                decoration: BoxDecoration(
                  color: _isRelayActive
                      ? Colors.green.withValues(alpha: .12)
                      : Colors.white.withValues(alpha: .06),

                  borderRadius:
                      BorderRadius.circular(15),

                  border: Border.all(
                    color: _isRelayActive
                        ? Colors.green.withValues(alpha: .35)
                        : Colors.white12,
                  ),
                ),

                child: Row(
                  children: [

                    Container(
                      width: 10,
                      height: 10,

                      decoration: BoxDecoration(
                        color: _isRelayActive
                            ? Colors.greenAccent
                            : Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        _isRelayActive
                            ? "LIVE RELAY ACTIVE"
                            : "RELAY READY",
                        style: TextStyle(
                          color: _isRelayActive
                              ? Colors.greenAccent
                              : Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),

                    Icon(
                      _isRelayActive
                          ? Icons.wifi
                          : Icons.wifi_off,
                      color: _isRelayActive
                          ? Colors.greenAccent
                          : Colors.white54,
                      size: 20,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // MODE SELECTOR
              // ==================================================

              Row(
                children: [

                  Expanded(
                    child: _modeCard(
                      icon: Icons.pan_tool_rounded,
                      title: "ISL → Voice",
                      subtitle: "Sign to speech",
                      active: true,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _modeCard(
                      icon: Icons.mic_rounded,
                      title: "Voice → ISL",
                      subtitle: "Speech to sign",
                      active: false,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // ==================================================
              // ISL AVATAR / CAMERA AREA
              // ==================================================

              Container(
                width: double.infinity,
                height: 285,

                decoration: BoxDecoration(
                  color: const Color(0xFF121D38),
                  borderRadius:
                      BorderRadius.circular(24),

                  border: Border.all(
                    color: Colors.white12,
                  ),
                ),

                child: Stack(
                  children: [

                    // Background pattern
                    Positioned(
                      top: -30,
                      right: -30,

                      child: Container(
                        width: 150,
                        height: 150,

                        decoration: BoxDecoration(
                          color:
                              const Color(0xFF00BCD4)
                                  .withValues(alpha: .07),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: -50,
                      left: -40,

                      child: Container(
                        width: 170,
                        height: 170,

                        decoration: BoxDecoration(
                          color:
                              const Color(0xFF3F51B5)
                                  .withValues(alpha: .08),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    // Avatar
                    Center(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [

                          Container(
                            width: 145,
                            height: 145,

                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFF1D2B4D),
                              shape: BoxShape.circle,

                              border: Border.all(
                                color:
                                    const Color(0xFF00BCD4)
                                        .withValues(alpha: .4),
                                width: 2,
                              ),
                            ),

                            child: const Icon(
                              Icons.accessibility_new_rounded,
                              color:
                                  Color(0xFF00BCD4),
                              size: 90,
                            ),
                          ),

                          const SizedBox(height: 14),

                          const Text(
                            "ISL AVATAR",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            _isRelayActive
                                ? "Performing sign..."
                                : "Avatar ready",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Camera label
                    Positioned(
                      top: 15,
                      left: 15,

                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius:
                              BorderRadius.circular(10),
                        ),

                        child: const Row(
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white70,
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "ISL INPUT",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Live indicator
                    if (_isRelayActive)
                      Positioned(
                        top: 15,
                        right: 15,

                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.redAccent
                                .withValues(alpha: .15),
                            borderRadius:
                                BorderRadius.circular(10),
                          ),

                          child: const Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.redAccent,
                                size: 9,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "LIVE",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // DETECTION RESULT
              // ==================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: const Color(0xFF1A254B),
                  borderRadius:
                      BorderRadius.circular(20),

                  border: Border.all(
                    color:
                        const Color(0xFF00BCD4)
                            .withValues(alpha: .18),
                  ),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Row(
                      children: [

                        Container(
                          padding:
                              const EdgeInsets.all(9),

                          decoration: BoxDecoration(
                            color:
                                const Color(0x3300BCD4),
                            borderRadius:
                                BorderRadius.circular(11),
                          ),

                          child: const Icon(
                            Icons.sign_language_rounded,
                            color:
                                Color(0xFF00BCD4),
                            size: 21,
                          ),
                        ),

                        const SizedBox(width: 10),

                        const Text(
                          "Detected Sign",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),

                        const Spacer(),

                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.green
                                .withValues(alpha: .12),
                            borderRadius:
                                BorderRadius.circular(8),
                          ),

                          child: const Text(
                            "96% Confidence",
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Text(
                      _detectedSign,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      _translatedText,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // SPEAK RESULT
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF00BCD4),
                    foregroundColor: Colors.white,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                  ),

                  onPressed:
                      _isSpeaking
                          ? null
                          : _speakResult,

                  icon: Icon(
                    _isSpeaking
                        ? Icons.volume_up
                        : Icons.volume_up_outlined,
                  ),

                  label: Text(
                    _isSpeaking
                        ? "Speaking..."
                        : "Speak Result",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ==================================================
              // RELAY BUTTONS
              // ==================================================

              Row(
                children: [

                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                          color:
                              const Color(0xFF00BCD4)
                                  .withValues(alpha: .5),
                        ),

                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 15,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15),
                        ),
                      ),

                      onPressed:
                          _toggleListening,

                      icon: Icon(
                        _isListening
                            ? Icons.mic
                            : Icons.mic_none,
                        color:
                            const Color(0xFF00BCD4),
                      ),

                      label: Text(
                        _isListening
                            ? "Listening"
                            : "Voice Input",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isRelayActive
                                ? Colors.redAccent
                                : const Color(0xFF3949AB),

                        foregroundColor:
                            Colors.white,

                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 15,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15),
                        ),
                      ),

                      onPressed:
                          _toggleRelay,

                      icon: Icon(
                        _isRelayActive
                            ? Icons.stop_circle_outlined
                            : Icons.play_circle_outline,
                      ),

                      label: Text(
                        _isRelayActive
                            ? "Stop Relay"
                            : "Start Relay",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ==================================================
              // EMERGENCY BUTTON
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 54,

                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.redAccent,

                    side: BorderSide(
                      color: Colors.redAccent
                          .withValues(alpha: .55),
                    ),

                    backgroundColor:
                        Colors.redAccent
                            .withValues(alpha: .06),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                  ),

                  onPressed:
                      _emergencyRelay,

                  icon: const Icon(
                    Icons.emergency,
                  ),

                  label: const Text(
                    "Emergency Relay",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ==================================================
              // INFORMATION CARD
              // ==================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .04),
                  borderRadius:
                      BorderRadius.circular(16),

                  border: Border.all(
                    color: Colors.white10,
                  ),
                ),

                child: const Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Icon(
                      Icons.info_outline,
                      color: Colors.white54,
                      size: 20,
                    ),

                    SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        "Relay Service enables real-time communication between ISL users and hearing individuals through AI-assisted translation.",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // ==================================================
              // FOOTER
              // ==================================================

              const Center(
                child: Text(
                  "ISL CONNECT AI • Accessible Communication",
                  style: TextStyle(
                    color: Colors.white30,
                    fontSize: 11,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MODE CARD
  // ============================================================

  Widget _modeCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool active,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: active
            ? const Color(0xFF00BCD4).withValues(alpha: .10)
            : Colors.white.withValues(alpha: .04),

        borderRadius:
            BorderRadius.circular(18),

        border: Border.all(
          color: active
              ? const Color(0xFF00BCD4)
                  .withValues(alpha: .35)
              : Colors.white10,
        ),
      ),

      child: Row(
        children: [

          Container(
            width: 42,
            height: 42,

            decoration: BoxDecoration(
              color: active
                  ? const Color(0x3300BCD4)
                  : Colors.white10,

              borderRadius:
                  BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: active
                  ? const Color(0xFF00BCD4)
                  : Colors.white60,
              size: 22,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 10,
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