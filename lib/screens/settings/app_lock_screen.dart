import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class AppLockScreen extends StatefulWidget {
  const AppLockScreen({super.key});

  @override
  State<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends State<AppLockScreen> {
  final LocalAuthentication _auth = LocalAuthentication();

  bool _appLockEnabled = false;
  bool _isAuthenticating = false;

  // ============================================================
  // ENABLE / DISABLE APP LOCK
  // ============================================================

  Future<void> _toggleAppLock(bool value) async {
    // Disable app lock
    if (!value) {
      setState(() {
        _appLockEnabled = false;
      });

      _showMessage("App Lock disabled.");
      return;
    }

    // Prevent multiple authentication requests
    if (_isAuthenticating) return;

    setState(() {
      _isAuthenticating = true;
    });

    try {
      // Check whether device supports authentication
      final bool isSupported =
          await _auth.isDeviceSupported();

      final bool canCheckBiometrics =
          await _auth.canCheckBiometrics;

      if (!isSupported && !canCheckBiometrics) {
        if (!mounted) return;

        _showMessage(
          "Biometric authentication is not available on this device.",
        );

        return;
      }

      // ========================================================
      // OLD LOCAL_AUTH API
      // ========================================================

      final bool authenticated =
          await _auth.authenticate(
        localizedReason:
            "Authenticate to enable ISL CONNECT AI App Lock",
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      if (!mounted) return;

      if (authenticated) {
        setState(() {
          _appLockEnabled = true;
        });

        _showMessage(
          "App Lock enabled successfully.",
        );
      } else {
        setState(() {
          _appLockEnabled = false;
        });

        _showMessage(
          "Authentication cancelled.",
        );
      }
    } catch (e) {
      debugPrint(
        "Authentication error: $e",
      );

      if (!mounted) return;

      setState(() {
        _appLockEnabled = false;
      });

      _showMessage(
        "Unable to use biometric authentication.",
      );
    } finally {
      if (mounted) {
        setState(() {
          _isAuthenticating = false;
        });
      }
    }
  }

  // ============================================================
  // TEST BIOMETRIC
  // ============================================================

  Future<void> _testAuthentication() async {
    if (_isAuthenticating) return;

    setState(() {
      _isAuthenticating = true;
    });

    try {
      final bool authenticated =
          await _auth.authenticate(
        localizedReason:
            "Authenticate to access ISL CONNECT AI",
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      if (!mounted) return;

      if (authenticated) {
        _showMessage(
          "Authentication successful.",
        );
      } else {
        _showMessage(
          "Authentication cancelled.",
        );
      }
    } catch (e) {
      debugPrint(
        "Authentication error: $e",
      );

      if (!mounted) return;

      _showMessage(
        "Authentication could not be completed.",
      );
    } finally {
      if (mounted) {
        setState(() {
          _isAuthenticating = false;
        });
      }
    }
  }

  // ============================================================
  // SNACKBAR MESSAGE
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
  // UI
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
          "App Lock",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              const SizedBox(height: 20),

              // =================================================
              // FINGERPRINT ICON
              // =================================================

              Container(
                width: 100,
                height: 100,

                decoration: BoxDecoration(
                  color: const Color(0x3300BCD4),
                  borderRadius:
                      BorderRadius.circular(30),
                ),

                child: const Icon(
                  Icons.fingerprint,
                  color: Color(0xFF00BCD4),
                  size: 60,
                ),
              ),

              const SizedBox(height: 24),

              // =================================================
              // TITLE
              // =================================================

              const Text(
                "Secure Your App",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Protect ISL CONNECT AI using your device biometric authentication.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 35),

              // =================================================
              // APP LOCK CARD
              // =================================================

              Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: const Color(0xFF1A254B),
                  borderRadius:
                      BorderRadius.circular(22),

                  border: Border.all(
                    color: Colors.white12,
                  ),
                ),

                child: Row(
                  children: [

                    // LOCK ICON
                    Container(
                      width: 55,
                      height: 55,

                      decoration: BoxDecoration(
                        color:
                            const Color(0x3300BCD4),
                        borderRadius:
                            BorderRadius.circular(16),
                      ),

                      child: Icon(
                        _appLockEnabled
                            ? Icons.lock
                            : Icons.lock_open,

                        color:
                            _appLockEnabled
                                ? Colors.green
                                : Colors.orange,

                        size: 30,
                      ),
                    ),

                    const SizedBox(width: 16),

                    // TEXT
                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(
                            "App Lock",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            "Require biometric authentication",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // SWITCH
                    Switch(
                      value: _appLockEnabled,

                      activeThumbColor:
                          const Color(0xFF00BCD4),

                      onChanged:
                        _isAuthenticating
                            ? null
                            : _toggleAppLock,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // =================================================
              // STATUS CARD
              // =================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: _appLockEnabled
                      ? Colors.green.withValues(alpha: .12)
                      : Colors.orange.withValues(alpha: .12),

                  borderRadius:
                      BorderRadius.circular(16),
                ),

                child: Row(
                  children: [

                    Icon(
                      _appLockEnabled
                          ? Icons.check_circle
                          : Icons.info_outline,

                      color:
                          _appLockEnabled
                              ? Colors.green
                              : Colors.orange,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        _appLockEnabled
                            ? "App Lock is enabled."
                            : "App Lock is currently disabled.",

                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // =================================================
              // TEST BIOMETRIC BUTTON
              // =================================================

              SizedBox(
                width: double.infinity,
                height: 58,

                child: ElevatedButton.icon(
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF00BCD4),

                    foregroundColor:
                        Colors.white,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),

                  onPressed:
                      _isAuthenticating
                          ? null
                          : _testAuthentication,

                  icon: _isAuthenticating
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
                          Icons.fingerprint,
                        ),

                  label: Text(
                    _isAuthenticating
                        ? "Authenticating..."
                        : "Test Biometric",

                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // =================================================
              // SECURITY MESSAGE
              // =================================================

              const Text(
                "Your biometric data stays on your device.",
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}