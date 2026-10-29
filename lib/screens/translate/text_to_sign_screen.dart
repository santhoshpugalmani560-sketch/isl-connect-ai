import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class TextToSignScreen extends StatefulWidget {
  const TextToSignScreen({super.key});

  @override
  State<TextToSignScreen> createState() => _TextToSignScreenState();
}

class _TextToSignScreenState extends State<TextToSignScreen> {
  final TextEditingController _controller = TextEditingController();

  VideoPlayerController? _videoController;

  String enteredText = '';
  String status = 'Ready to Convert';
  String? _selectedVideo;

  bool _isLoadingVideo = false;
  bool _isPlaying = false;

  // English sentences mapped to their existing MP4 sign videos.
  final Map<String, String> _signVideos = {
    'call an ambulance': 'call_an_ambulance.mp4',
    'call the police': 'call_the_police.mp4',
    'can you show me the way': 'can_you_show_me_the_way.mp4',
    'i am going outside': 'i_am_going_outside.mp4',
    'i am happy': 'i_am_happy.mp4',
    'i am hungry': 'i_am_hungry.mp4',
    'i am in danger': 'i_am_in_danger.mp4',
    'i am ready to start': 'i_am_ready_to_start.mp4',
    'i am sad': 'i_am_sad.mp4',
    'i am sorry': 'i_am_sorry.mp4',
    'i cannot hear you': 'i_cannot_hear_you.mp4',
    'i need a doctor': 'i_need_a_doctor.mp4',
    'i need medical help': 'i_need_medical_help.mp4',
    'i need some time': 'i_need_some_time.mp4',
    'my name is santhosh': 'my_name_is_santhosh.mp4',
    'nice to meet you': 'nice_to_meet_you.mp4',
    'please communicate using sign language':
        'please_communicate_using_sign_language.mp4',
    'please help me': 'please_help_me.mp4',
    'please stay with me': 'please_stay_with_me.mp4',
    'see you tomorrow': 'see_you_tomorrow.mp4',
    'what can i do': 'what_can_i_do.mp4',
    'what happened': 'what_happened.mp4',
    'where are you going': 'where_are_you_going.mp4',
    'where is the hospital': 'where_is_the_hospital.mp4',
    'where is the railway station':
        'where_is_the_railway_station.mp4',
    'you are welcome': 'you_are_welcome.mp4',
  };

  String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'''[^\w\s']'''), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  String? _findMatchingVideo(String text) {
    final normalized = _normalize(text);

    // First, try to match the entire sentence.
    if (_signVideos.containsKey(normalized)) {
      return _signVideos[normalized];
    }

    // Otherwise, find a supported phrase inside a longer sentence.
    final phrases = _signVideos.keys.toList()
      ..sort((a, b) => b.length.compareTo(a.length));

    for (final phrase in phrases) {
      final pattern = RegExp(
        r'(?<!\w)' + RegExp.escape(phrase) + r'(?!\w)',
      );

      if (pattern.hasMatch(normalized)) {
        return _signVideos[phrase];
      }
    }

    return null;
  }

  Future<void> _convertToSign() async {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      setState(() {
        enteredText = '';
        status = 'Please enter some text.';
      });
      return;
    }

    final videoFile = _findMatchingVideo(text);

    setState(() {
      enteredText = text;
    });

    if (videoFile == null) {
      await _disposeVideo();

      if (!mounted) return;

      setState(() {
        _selectedVideo = null;
        _isLoadingVideo = false;
        _isPlaying = false;
        status = 'No matching sign video found.';
      });

      _showMessage(
        'No video matches this sentence. Try one of the 26 supported phrases.',
      );
      return;
    }

    await _playVideo(videoFile);
  }

  Future<void> _playVideo(String videoFile) async {
    setState(() {
      _isLoadingVideo = true;
      _isPlaying = false;
      _selectedVideo = videoFile;
      status = 'Loading sign video...';
    });

    final oldController = _videoController;
    _videoController = null;

    if (oldController != null) {
      await oldController.pause();
      await oldController.dispose();
    }

    if (!mounted) return;

    final controller = VideoPlayerController.asset(
      'assets/videos/$videoFile',
    );

    _videoController = controller;

    try {
      await controller.initialize();

      if (!mounted || _videoController != controller) {
        await controller.dispose();
        return;
      }

      await controller.setLooping(true);
      await controller.play();

      if (!mounted) return;

      setState(() {
        _isLoadingVideo = false;
        _isPlaying = true;
        status = 'Sign video playing';
      });
    } catch (error) {
      debugPrint('Video loading error: $error');

      await controller.dispose();

      if (!mounted) return;

      if (_videoController == controller) {
        _videoController = null;
      }

      setState(() {
        _isLoadingVideo = false;
        _isPlaying = false;
        _selectedVideo = null;
        status = 'Could not load the video.';
      });

      _showMessage(
        'Could not load $videoFile. Check the filename and pubspec.yaml.',
      );
    }
  }

  Future<void> _togglePlayback() async {
    final controller = _videoController;

    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    if (controller.value.isPlaying) {
      await controller.pause();

      if (!mounted) return;

      setState(() {
        _isPlaying = false;
        status = 'Video paused';
      });
    } else {
      await controller.play();

      if (!mounted) return;

      setState(() {
        _isPlaying = true;
        status = 'Sign video playing';
      });
    }
  }

  Future<void> _replayVideo() async {
    final controller = _videoController;

    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    await controller.seekTo(Duration.zero);
    await controller.play();

    if (!mounted) return;

    setState(() {
      _isPlaying = true;
      status = 'Replaying sign video';
    });
  }

  Future<void> _disposeVideo() async {
    final controller = _videoController;
    _videoController = null;

    if (controller != null) {
      await controller.pause();
      await controller.dispose();
    }
  }

  void _clearText() {
    _disposeVideo();

    setState(() {
      _controller.clear();
      enteredText = '';
      _selectedVideo = null;
      _isLoadingVideo = false;
      _isPlaying = false;
      status = 'Ready to Convert';
    });
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
    _controller.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _videoController;

    return Scaffold(
      backgroundColor: const Color(0xFF08111F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF08111F),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Text to Sign',
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
                'Enter English Text',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _controller,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Example: I need a doctor',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF1A254B),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A254B),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.sign_language_rounded,
                      color: Color(0xFF00BCD4),
                      size: 55,
                    ),
                    const SizedBox(height: 12),

                    const Text(
                      'ISL Sign Video',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      enteredText.isEmpty
                          ? 'Enter a sentence to see its sign video.'
                          : enteredText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 17,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(
                        minHeight: 220,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0B1220),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: _isLoadingVideo
                          ? const SizedBox(
                              height: 220,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF00BCD4),
                                ),
                              ),
                            )
                          : controller != null &&
                                  controller.value.isInitialized
                              ? AspectRatio(
                                  aspectRatio:
                                      controller.value.aspectRatio > 0
                                          ? controller.value.aspectRatio
                                          : 9 / 16,
                                  child: VideoPlayer(controller),
                                )
                              : const SizedBox(
                                  height: 220,
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.video_library_rounded,
                                            size: 60,
                                            color: Color(0xFF00BCD4),
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            'Your sign video will appear here',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                    ),

                    if (controller != null &&
                        controller.value.isInitialized) ...[
                      const SizedBox(height: 12),

                      VideoProgressIndicator(
                        controller,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                          playedColor: Color(0xFF00BCD4),
                          bufferedColor: Colors.white30,
                          backgroundColor: Colors.white12,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: _togglePlayback,
                            icon: Icon(
                              _isPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_fill,
                            ),
                            iconSize: 44,
                            color: const Color(0xFF00BCD4),
                            tooltip: _isPlaying ? 'Pause' : 'Play',
                          ),
                          const SizedBox(width: 24),
                          IconButton(
                            onPressed: _replayVideo,
                            icon: const Icon(Icons.replay_circle_filled),
                            iconSize: 44,
                            color: Colors.white,
                            tooltip: 'Replay',
                          ),
                        ],
                      ),

                      if (_selectedVideo != null)
                        Text(
                          _selectedVideo!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                          ),
                        ),
                    ],

                    const SizedBox(height: 12),

                    Text(
                      status,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF00BCD4),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Actions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _isLoadingVideo ? null : _convertToSign,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BCD4),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.translate_rounded),
                  label: const Text(
                    'Convert to Sign',
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
                  onPressed: _clearText,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.delete_outline_rounded),
                  label: const Text(
                    'Clear Text',
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
                  onPressed: () {
                    if (enteredText.isEmpty) {
                      _showMessage('No text available to copy.');
                      return;
                    }

                    Clipboard.setData(
                      ClipboardData(text: enteredText),
                    );

                    _showMessage('Text copied successfully.');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF00BCD4),
                    side: const BorderSide(
                      color: Color(0xFF00BCD4),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.copy_rounded),
                  label: const Text(
                    'Copy Text',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Supported: 26 English phrases. Other sentences need a matching sign video.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}