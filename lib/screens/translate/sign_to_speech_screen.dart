import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SignToSpeechScreen extends StatefulWidget {
  const SignToSpeechScreen({super.key});

  @override
  State<SignToSpeechScreen> createState() => _SignToSpeechScreenState();
}

class _SignToSpeechScreenState extends State<SignToSpeechScreen> {
  CameraController? _cameraController;

  bool _cameraReady = false;
  bool _isDetecting = false;

  String _detectedSign = "No sign detected";
  String _confidence = "0%";

  final FlutterTts _tts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
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

      final controller = CameraController(
        selectedCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await controller.initialize();

      if (!mounted) {
        await controller.dispose();
        return;
      }

      setState(() {
        _cameraController = controller;
        _cameraReady = true;
      });
    } catch (e) {
      debugPrint("CAMERA ERROR: $e");

      if (mounted) {
        _showMessage(
          "Camera permission is required.",
        );
      }
    }
  }

  // ============================================================
  // START DETECTION
  // ============================================================

  Future<void> _startDetection() async {
    if (!_cameraReady || _cameraController == null) {
      await _initializeCamera();
    }

    if (!_cameraReady || _cameraController == null) {
      _showMessage("Camera is not ready.");
      return;
    }

    setState(() {
      _isDetecting = true;
    });

    // Camera is now active.
    //
    // IMPORTANT:
    // This part only demonstrates that the camera is working.
    // Your TFLite model must be connected here for REAL
    // sign-language detection.

    await Future.delayed(
      const Duration(milliseconds: 800),
    );

    if (!mounted) return;

    setState(() {
      _detectedSign = "No sign detected";
      _confidence = "0%";
      _isDetecting = false;
    });

    _showMessage(
      "Camera detection started.",
    );
  }

  // ============================================================
  // SPEAK
  // ============================================================

  Future<void> _speak() async {
    if (_detectedSign == "No sign detected") {
      _showMessage("Detect a sign first.");
      return;
    }

    try {
      await _tts.setLanguage("en-US");
      await _tts.setSpeechRate(0.45);
      await _tts.speak(_detectedSign);
    } catch (e) {
      debugPrint("TTS ERROR: $e");
    }
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
        ),
      );
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _cameraController?.dispose();
    _tts.stop();
    super.dispose();
  }

  // ============================================================
  // UI
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050914),

      appBar: AppBar(
        backgroundColor: const Color(0xFF050914),
        elevation: 0,
        centerTitle: true,

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),

        title: const Text(
          "Sign to Speech",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            children: [

              // ========================================================
              // CAMERA PREVIEW
              // ========================================================

              Container(
                width: double.infinity,
                height: 330,

                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(24),
                ),

                clipBehavior: Clip.hardEdge,

                child: _cameraReady &&
                        _cameraController != null &&
                        _cameraController!
                            .value
                            .isInitialized
                    ? CameraPreview(
                        _cameraController!,
                      )
                    : const Center(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,

                          children: [

                            Icon(
                              Icons.camera_alt,
                              size: 70,
                              color: Colors.grey,
                            ),

                            SizedBox(height: 15),

                            Text(
                              "Camera not started",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),

              const SizedBox(height: 24),

              // ========================================================
              // RESULT
              // ========================================================

              Text(
                _detectedSign,

                textAlign: TextAlign.center,

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Confidence: $_confidence",

                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 28),

              // ========================================================
              // START DETECTION
              // ========================================================

              SizedBox(
                width: double.infinity,
                height: 58,

                child: ElevatedButton.icon(
                  onPressed:
                      _isDetecting
                          ? null
                          : _startDetection,

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF142B43),

                    foregroundColor:
                        const Color(0xFF00D9E8),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30),
                    ),
                  ),

                  icon: _isDetecting
                      ? const SizedBox(
                          width: 20,
                          height: 20,

                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                            color:
                                Color(0xFF00D9E8),
                          ),
                        )
                      : const Icon(
                          Icons.play_arrow,
                        ),

                  label: Text(
                    _isDetecting
                        ? "Detecting..."
                        : "Start Detection",

                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight:
                          FontWeight.w500,
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
                  onPressed: _speak,

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF111A32),

                    foregroundColor:
                        const Color(0xFF00D9E8),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30),
                    ),
                  ),

                  icon: const Icon(
                    Icons.volume_up,
                  ),

                  label: const Text(
                    "Speak",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}