import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class SignToTextScreen extends StatefulWidget {
  const SignToTextScreen({super.key});

  @override
  State<SignToTextScreen> createState() => _SignToTextScreenState();
}

class _SignToTextScreenState extends State<SignToTextScreen> {
  String detectedText = "No sign detected";

  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();

      if (cameras == null || cameras!.isEmpty) {
        return;
      }

      _cameraController = CameraController(
        cameras!.first,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();

      if (!mounted) return;

      setState(() {
        isCameraInitialized = true;
      });
    } catch (e) {
      debugPrint("Camera Error: $e");
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08111F),

      appBar: AppBar(
        backgroundColor: const Color(0xFF08111F),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Sign to Text",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
  height: MediaQuery.of(context).size.height * 0.35,
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
      ? ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: CameraPreview(_cameraController!),
        )
      : const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Color(0xFF00BCD4),
              ),
              SizedBox(height: 20),
              Text(
                "Opening Camera...",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
),

const SizedBox(height: 24),

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
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.text_fields_rounded,
          color: Color(0xFF00BCD4),
          size: 34,
        ),
      ),

      const SizedBox(width: 18),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Detected Text",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              detectedText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "AI will convert detected sign language into readable text.",
              style: TextStyle(
                color: Colors.white60,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),

const SizedBox(height: 28),

const Text(
  "Actions",
  style: TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 18),
SizedBox(
  width: double.infinity,
  height: 56,
  child: ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF00BCD4),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    onPressed: () async {
  if (!isCameraInitialized) {
    await _initializeCamera();

    if (!mounted) return;

    ScaffoldMessenger.of(this.context).showSnackBar(
      const SnackBar(
        content: Text("Camera opened successfully."),
      ),
    );
  } else {
    ScaffoldMessenger.of(this.context).showSnackBar(
      const SnackBar(
        content: Text("Camera is already running."),
      ),
    );
  }
},
    icon: const Icon(Icons.camera_alt_rounded),
    label: const Text(
      "Open Camera",
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),

const SizedBox(height: 14),

SizedBox(
  width: double.infinity,
  height: 56,
  child: ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2563EB),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    onPressed: () {
      setState(() {
        detectedText = "Hello";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sign detected successfully."),
        ),
      );
    },
    icon: const Icon(Icons.psychology_alt_rounded),
    label: const Text(
      "Detect Sign",
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),

const SizedBox(height: 14),

SizedBox(
  width: double.infinity,
  height: 56,
  child: OutlinedButton.icon(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF00BCD4),
      side: const BorderSide(
        color: Color(0xFF00BCD4),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    onPressed: () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Text copied successfully."),
        ),
      );
    },
    icon: const Icon(Icons.copy_rounded),
    label: const Text(
      "Copy Text",
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    ),
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