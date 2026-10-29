import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CameraSignScreen extends StatefulWidget {
  const CameraSignScreen({super.key});

  @override
  State<CameraSignScreen> createState() => _CameraSignScreenState();
}

class _CameraSignScreenState extends State<CameraSignScreen> {
  CameraController? _cameraController;

  final FlutterTts _flutterTts = FlutterTts();

  bool isCameraInitialized = false;
  bool isDetecting = false;
  bool isSpeaking = false;

  String prediction = "No Sign Detected";
  String confidence = "0%";

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeTts();
  }

  // ============================================================
  // TEXT TO SPEECH
  // ============================================================

  Future<void> _initializeTts() async {
    try {
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setSpeechRate(0.45);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);
    } catch (e) {
      debugPrint("TTS ERROR: $e");
    }
  }

  // ============================================================
  // CAMERA
  // ============================================================

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        _showMessage("No camera found.");
        return;
      }

      CameraDescription selectedCamera = cameras.first;

      for (final camera in cameras) {
        if (camera.lensDirection == CameraLensDirection.back) {
          selectedCamera = camera;
          break;
        }
      }

      _cameraController = CameraController(
        selectedCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();

      if (!mounted) return;

      setState(() {
        isCameraInitialized = true;
      });
    } catch (e) {
      debugPrint("CAMERA ERROR: $e");

      if (!mounted) return;

      _showMessage(
        "Camera permission or camera initialization failed.",
      );
    }
  }

  // ============================================================
  // OPEN CAMERA
  // ============================================================

  void _openCamera() {
    if (_cameraController != null &&
        _cameraController!.value.isInitialized) {
      _showMessage(
        "Camera is ready. Show your hand inside the camera.",
      );
    } else {
      _initializeCamera();
    }
  }

  // ============================================================
  // DEMO DETECTION
  // ============================================================

  Future<void> _detectSign() async {
    if (isDetecting) return;

    if (_cameraController == null ||
        !_cameraController!.value.isInitialized) {
      _showMessage("Camera is not ready.");
      return;
    }

    setState(() {
      isDetecting = true;
    });

    // Give the user a small visual delay.
    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    // ------------------------------------------------------------
    // DEMO RESULT
    //
    // IMPORTANT:
    // This is a demonstration result.
    // It is NOT a real AI prediction.
    // ------------------------------------------------------------

    setState(() {
      prediction = "Hello";
      confidence = "Demo";
      isDetecting = false;
    });

    _showMessage(
      "Demo sign detected: Hello",
    );
  }

  // ============================================================
  // SPEAK RESULT
  // ============================================================

  Future<void> _speakResult() async {
    if (prediction == "No Sign Detected") {
      _showMessage(
        "Detect a sign first.",
      );
      return;
    }

    if (isSpeaking) {
      await _flutterTts.stop();

      if (!mounted) return;

      setState(() {
        isSpeaking = false;
      });

      return;
    }

    try {
      setState(() {
        isSpeaking = true;
      });

      await _flutterTts.stop();

      await _flutterTts.speak(
        prediction,
      );

      await Future.delayed(
        const Duration(seconds: 2),
      );

      if (!mounted) return;

      setState(() {
        isSpeaking = false;
      });
    } catch (e) {
      debugPrint("SPEECH ERROR: $e");

      if (!mounted) return;

      setState(() {
        isSpeaking = false;
      });

      _showMessage(
        "Unable to speak result.",
      );
    }
  }

  // ============================================================
  // RESET
  // ============================================================

  void _resetDetection() {
    setState(() {
      prediction = "No Sign Detected";
      confidence = "0%";
    });

    _showMessage(
      "Detection reset.",
    );
  }

  // ============================================================
  // SNACKBAR
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
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _cameraController?.dispose();
    _flutterTts.stop();

    super.dispose();
  }

  // ============================================================
  // UI
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08111F),

      appBar: AppBar(
        backgroundColor: const Color(0xFF08111F),
        elevation: 0,
        centerTitle: true,

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),

        title: const Text(
          "Sign to Speech",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

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
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // ========================================================
              // LIVE CAMERA
              // ========================================================

              const Text(
                "Live Camera",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                height: 320,

                decoration: BoxDecoration(
                  color: const Color(0xFF1A254B),
                  borderRadius: BorderRadius.circular(24),

                  border: Border.all(
                    color: Colors.white12,
                  ),
                ),

                clipBehavior: Clip.hardEdge,

                child: isCameraInitialized &&
                        _cameraController != null &&
                        _cameraController!.value.isInitialized
                    ? Stack(
                        fit: StackFit.expand,
                        children: [

                          CameraPreview(
                            _cameraController!,
                          ),

                          // CAMERA GUIDE
                          Center(
                            child: Container(
                              width: 220,
                              height: 220,

                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(24),

                                border: Border.all(
                                  color: Colors.cyanAccent,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 15,

                            child: Center(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),

                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius:
                                      BorderRadius.circular(20),
                                ),

                                child: const Text(
                                  "Place your hand inside the box",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF00BCD4),
                        ),
                      ),
              ),

              const SizedBox(height: 20),

              // ========================================================
              // DEMO STATUS
              // ========================================================

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: Colors.orange.withValues(
                    alpha: 0.12,
                  ),

                  borderRadius: BorderRadius.circular(14),

                  border: Border.all(
                    color: Colors.orange.withValues(
                      alpha: 0.3,
                    ),
                  ),
                ),

                child: const Row(
                  children: [

                    Icon(
                      Icons.info_outline,
                      color: Colors.orange,
                    ),

                    SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        "Demo Mode: AI model is not connected yet.",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ========================================================
              // PREDICTION CARD
              // ========================================================

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: const Color(0xFF1A254B),
                  borderRadius: BorderRadius.circular(20),

                  border: Border.all(
                    color: Colors.white12,
                  ),
                ),

                child: Row(
                  children: [

                    Container(
                      width: 65,
                      height: 65,

                      decoration: BoxDecoration(
                        color: const Color(0x3300BCD4),
                        borderRadius:
                            BorderRadius.circular(16),
                      ),

                      child: const Icon(
                        Icons.psychology_alt_rounded,
                        color: Color(0xFF00BCD4),
                        size: 34,
                      ),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          const Text(
                            "Detected Sign",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            prediction,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "Confidence: $confidence",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ========================================================
              // ACTIONS
              // ========================================================

              const Text(
                "Actions",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              // ========================================================
              // OPEN CAMERA
              // ========================================================

              SizedBox(
                width: double.infinity,
                height: 58,

                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF00BCD4),

                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),

                  onPressed: _openCamera,

                  icon: const Icon(
                    Icons.camera_alt_rounded,
                  ),

                  label: const Text(
                    "Open Camera",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ========================================================
              // DETECT SIGN
              // ========================================================

              SizedBox(
                width: double.infinity,
                height: 58,

                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF2563EB),

                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),

                  onPressed:
                      isDetecting ? null : _detectSign,

                  icon: isDetecting
                      ? const SizedBox(
                          width: 20,
                          height: 20,

                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(
                          Icons
                              .psychology_alt_rounded,
                        ),

                  label: Text(
                    isDetecting
                        ? "Detecting..."
                        : "Start Detection",

                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ========================================================
              // SPEAK
              // ========================================================

              SizedBox(
                width: double.infinity,
                height: 58,

                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF10B981),

                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),

                  onPressed: _speakResult,

                  icon: Icon(
                    isSpeaking
                        ? Icons.stop_circle
                        : Icons.volume_up_rounded,
                  ),

                  label: Text(
                    isSpeaking
                        ? "Stop Speaking"
                        : "Speak Result",

                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ========================================================
              // RESET
              // ========================================================

              SizedBox(
                width: double.infinity,
                height: 52,

                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(
                      color: Colors.white30,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),

                  onPressed: _resetDetection,

                  icon: const Icon(
                    Icons.refresh_rounded,
                  ),

                  label: const Text(
                    "Reset",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ========================================================
              // DEMO INFORMATION
              // ========================================================

              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: const Color(0xFF1A254B),
                  borderRadius:
                      BorderRadius.circular(18),
                ),

                child: const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Row(
                      children: [
                        Icon(
                          Icons.smart_toy,
                          color: Color(0xFF00BCD4),
                        ),

                        SizedBox(width: 10),

                        Text(
                          "ISL Connect AI",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    Text(
                      "This presentation version demonstrates "
                      "the complete camera-to-speech workflow. "
                      "A trained ISL recognition model can be "
                      "connected later for real sign prediction.",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}