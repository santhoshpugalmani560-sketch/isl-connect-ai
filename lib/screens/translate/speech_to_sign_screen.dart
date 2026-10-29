import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../services/speech_service.dart';

class SpeechToSignScreen extends StatefulWidget {
  const SpeechToSignScreen({super.key});

  @override
  State<SpeechToSignScreen> createState() =>
      _SpeechToSignScreenState();
}

class _SpeechToSignScreenState extends State<SpeechToSignScreen> {
  final SpeechService _speechService = SpeechService();

  VideoPlayerController? _videoController;

  String _recognizedText = 'Press Start Listening and speak.';
  String? _selectedPhrase;
  String? _selectedVideo;

  bool _isListening = false;
  bool _isInitializing = false;
  bool _isLoadingVideo = false;

  // English phrases mapped to your existing MP4 videos.
  final Map<String, String> _signVideos = {
    'call an ambulance':
        'assets/videos/call_an_ambulance.mp4',
    'call the police':
        'assets/videos/call_the_police.mp4',
    'can you show me the way':
        'assets/videos/can_you_show_me_the_way.mp4',
    'i am going outside':
        'assets/videos/i_am_going_outside.mp4',
    'i am happy':
        'assets/videos/i_am_happy.mp4',
    'i am hungry':
        'assets/videos/i_am_hungry.mp4',
    'i am in danger':
        'assets/videos/i_am_in_danger.mp4',
    'i am ready to start':
        'assets/videos/i_am_ready_to_start.mp4',
    'i am sad':
        'assets/videos/i_am_sad.mp4',
    'i am sorry':
        'assets/videos/i_am_sorry.mp4',
    'i cannot hear you':
        'assets/videos/i_cannot_hear_you.mp4',
    'i need a doctor':
        'assets/videos/i_need_a_doctor.mp4',
    'i need medical help':
        'assets/videos/i_need_medical_help.mp4',
    'i need some time':
        'assets/videos/i_need_some_time.mp4',
    'my name is santhosh':
        'assets/videos/my_name_is_santhosh.mp4',
    'nice to meet you':
        'assets/videos/nice_to_meet_you.mp4',
    'please communicate using sign language':
        'assets/videos/please_communicate_using_sign_language.mp4',
    'please help me':
        'assets/videos/please_help_me.mp4',
    'please stay with me':
        'assets/videos/please_stay_with_me.mp4',
    'see you tomorrow':
        'assets/videos/see_you_tomorrow.mp4',
    'what can i do':
        'assets/videos/what_can_i_do.mp4',
    'what happened':
        'assets/videos/what_happened.mp4',
    'where are you going':
        'assets/videos/where_are_you_going.mp4',
    'where is the hospital':
        'assets/videos/where_is_the_hospital.mp4',
    'where is the railway station':
        'assets/videos/where_is_the_railway_station.mp4',
    'you are welcome':
        'assets/videos/you_are_welcome.mp4',
  };

  String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r"[^a-z0-9\s']"), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  String? _findSign(String text) {
    final normalized = _normalize(text);

    // Match the longest phrase first.
    final phrases = _signVideos.keys.toList()
      ..sort((a, b) => b.length.compareTo(a.length));

    for (final phrase in phrases) {
      final pattern = RegExp(
        r'(?<![a-z0-9])' +
            RegExp.escape(phrase) +
            r'(?![a-z0-9])',
      );

      if (pattern.hasMatch(normalized)) {
        return phrase;
      }
    }

    return null;
  }

  Future<void> _toggleListening() async {
    if (_isInitializing) return;

    if (_isListening) {
      try {
        await _speechService.stopListening();
      } catch (e) {
        debugPrint('Stop listening error: $e');
      }

      if (!mounted) return;

      setState(() {
        _isListening = false;
      });
      return;
    }

    setState(() {
      _isInitializing = true;
    });

    try {
      final available = await _speechService.initialize();

      if (!mounted) return;

      if (!available) {
        setState(() {
          _isInitializing = false;
        });

        _showMessage(
          'Speech recognition is unavailable. '
          'Check your microphone permission.',
        );
        return;
      }

      setState(() {
        _isInitializing = false;
        _isListening = true;
        _recognizedText = 'Listening... Speak now.';
        _selectedPhrase = null;
      });

      await _speechService.startListening(
        onResult: (text) {
          if (!mounted) return;

          setState(() {
            _recognizedText = text;
          });

          final phrase = _findSign(text);

          if (phrase != null && phrase != _selectedPhrase) {
            _playSignVideo(phrase);
          }
        },
      );
    } catch (e) {
      debugPrint('Speech recognition error: $e');

      if (!mounted) return;

      setState(() {
        _isListening = false;
        _isInitializing = false;
      });

      _showMessage('Could not start speech recognition.');
    }
  }

  Future<void> _playSignVideo(String phrase) async {
    final videoPath = _signVideos[phrase];

    if (videoPath == null) return;

    setState(() {
      _selectedPhrase = phrase;
      _selectedVideo = videoPath;
      _isLoadingVideo = true;
    });

    final oldController = _videoController;
    _videoController = null;

    if (oldController != null) {
      await oldController.dispose();
    }

    if (!mounted) return;

    final newController = VideoPlayerController.asset(videoPath);
    _videoController = newController;

    try {
      await newController.initialize();

      if (!mounted || _videoController != newController) {
        await newController.dispose();
        return;
      }

      await newController.setLooping(true);
      await newController.play();

      if (!mounted) return;

      setState(() {
        _isLoadingVideo = false;
      });
    } catch (e) {
      debugPrint('Unable to play $videoPath: $e');

      if (!mounted) return;

      setState(() {
        _isLoadingVideo = false;
      });

      _showMessage(
        'Could not load this video. Check its file name '
        'and the assets/videos/ folder.',
      );
    }
  }

  Future<void> _pauseVideo() async {
    final controller = _videoController;

    if (controller != null && controller.value.isInitialized) {
      await controller.pause();
    }
  }

  Future<void> _replayVideo() async {
    final controller = _videoController;

    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    await controller.seekTo(Duration.zero);
    await controller.play();
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }

  @override
  void dispose() {
    _speechService.stopListening();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _videoController;

    return Scaffold(
      backgroundColor: const Color(0xFF050914),
      appBar: AppBar(
        backgroundColor: const Color(0xFF050914),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Speech to Sign',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 10),

              Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                size: 68,
                color: _isListening
                    ? Colors.redAccent
                    : const Color(0xFF00D9E8),
              ),

              const SizedBox(height: 16),

              Text(
                _recognizedText,
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed:
                      _isInitializing ? null : _toggleListening,
                  icon: Icon(
                    _isInitializing
                        ? Icons.hourglass_top
                        : _isListening
                            ? Icons.stop
                            : Icons.mic,
                  ),
                  label: Text(
                    _isInitializing
                        ? 'Initializing...'
                        : _isListening
                            ? 'Stop Listening'
                            : 'Start Listening',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF17213D),
                    foregroundColor: const Color(0xFF00D9E8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ISL Sign Video',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: Container(
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color(0xFF111A32),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: _selectedVideo == null
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Text(
                              'Speak a supported English phrase.\n\n'
                              'Your matching sign video will appear here.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                _selectedPhrase!.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF00D9E8),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            Expanded(
                              child: _isLoadingVideo ||
                                      controller == null ||
                                      !controller.value.isInitialized
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xFF00D9E8),
                                      ),
                                    )
                                  : Center(
                                      child: AspectRatio(
                                        aspectRatio: controller
                                            .value.aspectRatio,
                                        child: VideoPlayer(controller),
                                      ),
                                    ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 12,
                              ),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 12,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: _replayVideo,
                                    icon: const Icon(Icons.replay),
                                    label: const Text('Replay'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: _pauseVideo,
                                    icon: const Icon(Icons.pause),
                                    label: const Text('Pause'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Speak clearly in English. The app plays a matching '
                'video when a supported phrase is recognized.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}