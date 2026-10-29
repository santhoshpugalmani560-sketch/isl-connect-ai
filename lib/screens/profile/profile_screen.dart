import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ============================================================
  // USER DETAILS
  // ============================================================

  String userName = "Santhosh P";
  String email = "santhosh@example.com";

  String userRole = "Healthcare Professional";
  String islLevel = "Intermediate";
  String organization = "ISL CONNECT AI";

  bool notificationsEnabled = true;
  bool darkModeEnabled = true;
  bool soundEnabled = true;
  bool vibrationEnabled = true;

  String preferredLanguage = "English";

  // ============================================================
  // EDIT PROFILE
  // ============================================================

  void _editProfile() {
    final nameController =
        TextEditingController(text: userName);

    final emailController =
        TextEditingController(text: email);

    final organizationController =
        TextEditingController(text: organization);

    String selectedRole = userRole;
    String selectedLevel = islLevel;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF101936),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 24,
                bottom:
                    MediaQuery.of(context).viewInsets.bottom +
                        20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Edit Professional Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    _textField(
                      controller: nameController,
                      label: "Full Name",
                      icon: Icons.person_outline,
                    ),

                    const SizedBox(height: 14),

                    _textField(
                      controller: emailController,
                      label: "Email Address",
                      icon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 14),

                    _textField(
                      controller: organizationController,
                      label:
                          "Organization / Hospital / College",
                      icon: Icons.business_outlined,
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "Professional Role",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                      initialValue: selectedRole,
                      dropdownColor:
                          const Color(0xFF18213F),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration:
                          _dropdownDecoration(
                        Icons.work_outline,
                      ),
                      items: const [
                        "Patient",
                        "Student",
                        "Teacher",
                        "Interpreter",
                        "Healthcare Professional",
                        "Researcher",
                        "Administrator",
                        "Other",
                      ]
                          .map(
                            (role) =>
                                DropdownMenuItem(
                              value: role,
                              child: Text(role),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setSheetState(() {
                            selectedRole = value;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "ISL Proficiency",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                      initialValue: selectedLevel,
                      dropdownColor:
                          const Color(0xFF18213F),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration:
                          _dropdownDecoration(
                        Icons.school_outlined,
                      ),
                      items: const [
                        "Beginner",
                        "Basic",
                        "Intermediate",
                        "Advanced",
                        "Professional",
                      ]
                          .map(
                            (level) =>
                                DropdownMenuItem(
                              value: level,
                              child: Text(level),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setSheetState(() {
                            selectedLevel = value;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.primary,
                          foregroundColor:
                              Colors.white,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                        ),
                        icon: const Icon(
                          Icons.save_outlined,
                        ),
                        label: const Text(
                          "Save Profile",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            userName =
                                nameController.text
                                        .trim()
                                        .isEmpty
                                    ? "Santhosh P"
                                    : nameController
                                        .text
                                        .trim();

                            email =
                                emailController.text
                                    .trim();

                            organization =
                                organizationController
                                    .text
                                    .trim();

                            userRole =
                                selectedRole;

                            islLevel =
                                selectedLevel;
                          });

                          Navigator.pop(context);

                          _showMessage(
                            "Profile updated successfully",
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.white70,
        ),
        prefixIcon: Icon(
          icon,
          color: AppColors.primary,
        ),
        filled: true,
        fillColor: const Color(0xFF18213F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  InputDecoration _dropdownDecoration(
    IconData icon,
  ) {
    return InputDecoration(
      prefixIcon: Icon(
        icon,
        color: AppColors.primary,
      ),
      filled: true,
      fillColor: const Color(0xFF18213F),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );
  }

  // ============================================================
  // CHANGE PASSWORD
  // ============================================================

  void _changePassword() {
    final passwordController =
        TextEditingController();

    final confirmController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF101936),
          title: const Text(
            "Change Password",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _passwordField(
                passwordController,
                "New Password",
              ),
              const SizedBox(height: 14),
              _passwordField(
                confirmController,
                "Confirm Password",
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (passwordController.text ==
                        confirmController.text &&
                    passwordController.text.length >= 6) {
                  Navigator.pop(context);

                  _showMessage(
                    "Password changed successfully",
                  );
                } else {
                  _showMessage(
                    "Passwords do not match or are too short",
                  );
                }
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  Widget _passwordField(
    TextEditingController controller,
    String label,
  ) {
    return TextField(
      controller: controller,
      obscureText: true,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.white70,
        ),
        filled: true,
        fillColor: const Color(0xFF18213F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ============================================================
  // LANGUAGE
  // ============================================================

  void _selectLanguage() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF101936),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),
      builder: (context) {
        final languages = [
          "English",
          "Tamil",
          "Hindi",
          "Telugu",
          "Malayalam",
          "Kannada",
        ];

        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              "Preferred Language",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            ...languages.map(
              (language) => ListTile(
                leading: const Icon(
                  Icons.language,
                  color: AppColors.primary,
                ),
                title: Text(
                  language,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing:
                    preferredLanguage == language
                        ? const Icon(
                            Icons.check_circle,
                            color: AppColors.primary,
                          )
                        : null,
                onTap: () {
                  setState(() {
                    preferredLanguage =
                        language;
                  });

                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // EMERGENCY CONTACTS
  // ============================================================

  void _emergencyContacts() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF101936),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                "Emergency Contacts",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Add trusted contacts for Emergency SOS.",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 20),

              _actionButton(
                icon: Icons.person_add_alt_1,
                title: "Add Emergency Contact",
                subtitle:
                    "Add a trusted person",
                color: Colors.redAccent,
                onTap: () {
                  Navigator.pop(context);
                  _showMessage(
                    "Emergency contact setup opened",
                  );
                },
              ),

              const SizedBox(height: 12),

              _actionButton(
                icon: Icons.location_on_outlined,
                title: "Location Sharing",
                subtitle:
                    "Configure live location",
                color: Colors.orange,
                onTap: () {
                  Navigator.pop(context);
                  _showMessage(
                    "Location settings opened",
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // SECURITY
  // ============================================================

  void _security() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF101936),
          title: const Text(
            "Privacy & Security",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: const Text(
            "Your profile and application settings "
            "should be protected.\n\n"
            "Recommended security options:\n\n"
            "• Strong password\n"
            "• App lock\n"
            "• Secure patient information\n"
            "• Permission management\n"
            "• Emergency contact protection",
            style: TextStyle(
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // ABOUT APP
  // ============================================================

  void _aboutApp() {
    showAboutDialog(
      context: context,
      applicationName: "ISL CONNECT AI",
      applicationVersion: "1.0.0",
      applicationLegalese:
          "Breaking Communication Barriers",
      children: const [
        SizedBox(height: 16),
        Text(
          "ISL CONNECT AI is an accessibility-focused "
          "application designed to support Indian Sign "
          "Language communication through AI-assisted "
          "translation, learning and communication tools.",
        ),
      ],
    );
  }

  // ============================================================
  // HELP
  // ============================================================

  void _helpSupport() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF101936),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Help & Support",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              _actionButton(
                icon: Icons.help_outline,
                title: "App Guide",
                subtitle:
                    "Learn how to use ISL CONNECT AI",
                color: Colors.cyan,
                onTap: () {
                  Navigator.pop(context);
                  _showMessage(
                    "App guide opened",
                  );
                },
              ),

              const SizedBox(height: 12),

              _actionButton(
                icon: Icons.bug_report_outlined,
                title: "Report a Problem",
                subtitle:
                    "Send feedback about the app",
                color: Colors.orange,
                onTap: () {
                  Navigator.pop(context);
                  _showMessage(
                    "Problem reporting opened",
                  );
                },
              ),

              const SizedBox(height: 12),

              _actionButton(
                icon: Icons.contact_support_outlined,
                title: "Contact Support",
                subtitle:
                    "Get assistance with ISL CONNECT AI",
                color: Colors.green,
                onTap: () {
                  Navigator.pop(context);
                  _showMessage(
                    "Support section opened",
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // COMMON ACTION BUTTON
  // ============================================================

  Widget _actionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF18213F),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(
                  alpha: .14,
                ),
                borderRadius:
                    BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: color,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: Colors.white54,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  void _logout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF101936),
          title: const Text(
            "Logout",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: const Text(
            "Are you sure you want to logout?",
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.redAccent,
              ),
              onPressed: () {
                Navigator.pop(context);

                _showMessage(
                  "Logout completed",
                );
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      appBar: AppBar(
        backgroundColor:
            AppColors.background,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "Professional Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          18,
          10,
          18,
          30,
        ),

        child: Column(
          children: [

            // ========================================================
            // PROFILE HEADER
            // ========================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(28),

                gradient:
                    const LinearGradient(
                  begin:
                      Alignment.topLeft,
                  end:
                      Alignment.bottomRight,

                  colors: [
                    Color(0xFF243B72),
                    Color(0xFF0C6E8C),
                  ],
                ),
              ),

              child: Column(
                children: [

                  Stack(
                    children: [

                      Container(
                        width: 100,
                        height: 100,

                        decoration:
                            const BoxDecoration(
                          color:
                              Color(0xFF2196F3),
                          shape:
                              BoxShape.circle,
                        ),

                        child:
                            const Icon(
                          Icons.person,
                          color:
                              Colors.white,
                          size: 58,
                        ),
                      ),

                      Positioned(
                        bottom: 2,
                        right: 2,

                        child:
                            Container(
                          width: 30,
                          height: 30,

                          decoration:
                              const BoxDecoration(
                            color:
                                Colors.green,
                            shape:
                                BoxShape.circle,
                          ),

                          child:
                              const Icon(
                            Icons.check,
                            color:
                                Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 14,
                  ),

                  Text(
                    userName,

                    style:
                        const TextStyle(
                      color:
                          Colors.white,
                      fontSize: 25,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  Text(
                    email,

                    style:
                        const TextStyle(
                      color:
                          Colors.white70,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(
                    height: 14,
                  ),

                  Container(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),

                    decoration:
                        BoxDecoration(
                      color:
                          Colors.white12,
                      borderRadius:
                          BorderRadius.circular(
                        30,
                      ),
                    ),

                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        const Icon(
                          Icons
                              .verified_user,
                          color:
                              Colors.cyanAccent,
                          size: 17,
                        ),

                        const SizedBox(
                          width: 7,
                        ),

                        Text(
                          userRole,

                          style:
                              const TextStyle(
                            color:
                                Colors.white,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  Row(
                    children: [

                      Expanded(
                        child:
                            _profileStat(
                          "ISL Level",
                          islLevel,
                          Icons
                              .sign_language,
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      Expanded(
                        child:
                            _profileStat(
                          "Status",
                          "Active",
                          Icons.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 22,
            ),

            // ========================================================
            // ACCOUNT
            // ========================================================

            _sectionTitle(
              "Account",
            ),

            _profileTile(
              icon:
                  Icons.edit_outlined,
              title:
                  "Edit Professional Profile",
              subtitle:
                  "Name, role, organization and ISL level",
              color:
                  Colors.cyan,
              onTap:
                  _editProfile,
            ),

            _profileTile(
              icon:
                  Icons.lock_outline,
              title:
                  "Change Password",
              subtitle:
                  "Update your account password",
              color:
                  Colors.orange,
              onTap:
                  _changePassword,
            ),

            // ========================================================
            // PROFESSIONAL INFORMATION
            // ========================================================

            const SizedBox(
              height: 12,
            ),

            _sectionTitle(
              "Professional Information",
            ),

            _profileTile(
              icon:
                  Icons.work_outline,
              title:
                  "Professional Role",
              subtitle:
                  userRole,
              color:
                  Colors.blue,
              onTap:
                  _editProfile,
            ),

            _profileTile(
              icon:
                  Icons.business_outlined,
              title:
                  "Organization",
              subtitle:
                  organization.isEmpty
                      ? "Add hospital / college / organization"
                      : organization,
              color:
                  Colors.purple,
              onTap:
                  _editProfile,
            ),

            _profileTile(
              icon:
                  Icons.school_outlined,
              title:
                  "ISL Proficiency",
              subtitle:
                  islLevel,
              color:
                  Colors.green,
              onTap:
                  _editProfile,
            ),

            // ========================================================
            // PREFERENCES
            // ========================================================

            const SizedBox(
              height: 12,
            ),

            _sectionTitle(
              "Preferences",
            ),

            _profileSwitchTile(
              icon:
                  Icons.notifications_none,
              title:
                  "Notifications",
              subtitle:
                  "Receive app notifications",
              color:
                  Colors.green,
              value:
                  notificationsEnabled,
              onChanged:
                  (value) {
                setState(() {
                  notificationsEnabled =
                      value;
                });
              },
            ),

            _profileSwitchTile(
              icon:
                  Icons.dark_mode_outlined,
              title:
                  "Dark Mode",
              subtitle:
                  "Use the dark application theme",
              color:
                  Colors.deepPurple,
              value:
                  darkModeEnabled,
              onChanged:
                  (value) {
                setState(() {
                  darkModeEnabled =
                      value;
                });
              },
            ),

            _profileSwitchTile(
              icon:
                  Icons.volume_up_outlined,
              title:
                  "Sound",
              subtitle:
                  "Enable spoken and audio feedback",
              color:
                  Colors.cyan,
              value:
                  soundEnabled,
              onChanged:
                  (value) {
                setState(() {
                  soundEnabled =
                      value;
                });
              },
            ),

            _profileSwitchTile(
              icon:
                  Icons.vibration,
              title:
                  "Vibration",
              subtitle:
                  "Enable haptic feedback",
              color:
                  Colors.orange,
              value:
                  vibrationEnabled,
              onChanged:
                  (value) {
                setState(() {
                  vibrationEnabled =
                      value;
                });
              },
            ),

            _profileTile(
              icon:
                  Icons.language,
              title:
                  "Preferred Language",
              subtitle:
                  preferredLanguage,
              color:
                  Colors.blue,
              onTap:
                  _selectLanguage,
            ),

            // ========================================================
            // SAFETY & PRIVACY
            // ========================================================

            const SizedBox(
              height: 12,
            ),

            _sectionTitle(
              "Safety & Privacy",
            ),

            _profileTile(
              icon:
                  Icons.emergency_outlined,
              title:
                  "Emergency Contacts",
              subtitle:
                  "Manage trusted contacts for SOS",
              color:
                  Colors.redAccent,
              onTap:
                  _emergencyContacts,
            ),

            _profileTile(
              icon:
                  Icons.security_outlined,
              title:
                  "Privacy & Security",
              subtitle:
                  "Protect your account and data",
              color:
                  Colors.orange,
              onTap:
                  _security,
            ),

            // ========================================================
            // SUPPORT
            // ========================================================

            const SizedBox(
              height: 12,
            ),

            _sectionTitle(
              "Support",
            ),

            _profileTile(
              icon:
                  Icons.help_outline,
              title:
                  "Help & Support",
              subtitle:
                  "Get help using ISL CONNECT AI",
              color:
                  Colors.green,
              onTap:
                  _helpSupport,
            ),

            _profileTile(
              icon:
                  Icons.info_outline,
              title:
                  "About ISL CONNECT AI",
              subtitle:
                  "Version 1.0.0 • Breaking Communication Barriers",
              color:
                  Colors.blue,
              onTap:
                  _aboutApp,
            ),

            // ========================================================
            // LOGOUT
            // ========================================================

            const SizedBox(
              height: 20,
            ),

            SizedBox(
              width:
                  double.infinity,
              height:
                  56,

              child:
                  OutlinedButton.icon(
                style:
                    OutlinedButton.styleFrom(
                  foregroundColor:
                      Colors.redAccent,

                  side:
                      const BorderSide(
                    color:
                        Colors.redAccent,
                  ),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      16,
                    ),
                  ),
                ),

                onPressed:
                    _logout,

                icon:
                    const Icon(
                  Icons.logout,
                ),

                label:
                    const Text(
                  "Logout",

                  style:
                      TextStyle(
                    fontSize:
                        16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            const Text(
              "ISL CONNECT AI\n"
              "Breaking Communication Barriers",

              textAlign:
                  TextAlign.center,

              style:
                  TextStyle(
                color:
                    AppColors.textSecondary,
                fontSize:
                    13,
                height:
                    1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _sectionTitle(
    String title,
  ) {
    return Align(
      alignment:
          Alignment.centerLeft,

      child: Padding(
        padding:
            const EdgeInsets.only(
          left: 4,
          bottom: 10,
        ),

        child: Text(
          title,

          style:
              const TextStyle(
            color:
                Colors.white,
            fontSize:
                19,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // PROFILE STAT
  // ============================================================

  Widget _profileStat(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      padding:
          const EdgeInsets.all(
        12,
      ),

      decoration:
          BoxDecoration(
        color:
            Colors.white10,
        borderRadius:
            BorderRadius.circular(
          16,
        ),
      ),

      child: Row(
        children: [

          Icon(
            icon,
            color:
                Colors.cyanAccent,
            size:
                20,
          ),

          const SizedBox(
            width: 8,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style:
                      const TextStyle(
                    color:
                        Colors.white60,
                    fontSize:
                        11,
                  ),
                ),

                const SizedBox(
                  height: 2,
                ),

                Text(
                  value,

                  maxLines:
                      1,

                  overflow:
                      TextOverflow.ellipsis,

                  style:
                      const TextStyle(
                    color:
                        Colors.white,
                    fontWeight:
                        FontWeight.bold,
                    fontSize:
                        13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PROFILE TILE
  // ============================================================

  Widget _profileTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),

      decoration:
          BoxDecoration(
        color:
            const Color(0xFF18213F),

        borderRadius:
            BorderRadius.circular(
          18,
        ),
      ),

      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 4,
        ),

        leading:
            Container(
          width: 46,
          height: 46,

          decoration:
              BoxDecoration(
            color:
                color.withValues(
              alpha: .13,
            ),

            borderRadius:
                BorderRadius.circular(
              14,
            ),
          ),

          child:
              Icon(
            icon,
            color:
                color,
          ),
        ),

        title:
            Text(
          title,

          style:
              const TextStyle(
            color:
                Colors.white,
            fontSize:
                15,
            fontWeight:
                FontWeight.w600,
          ),
        ),

        subtitle:
            Padding(
          padding:
              const EdgeInsets.only(
            top: 3,
          ),

          child:
              Text(
            subtitle,

            maxLines:
                2,

            overflow:
                TextOverflow.ellipsis,

            style:
                const TextStyle(
              color:
                  Colors.white60,
              fontSize:
                  12,
            ),
          ),
        ),

        trailing:
            const Icon(
          Icons.chevron_right,
          color:
              Colors.white54,
        ),

        onTap:
            onTap,
      ),
    );
  }

  // ============================================================
  // SWITCH TILE
  // ============================================================

  Widget _profileSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 10,
      ),

      decoration:
          BoxDecoration(
        color:
            const Color(0xFF18213F),

        borderRadius:
            BorderRadius.circular(
          18,
        ),
      ),

      child:
          SwitchListTile(
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 14,
        ),

        secondary:
            Container(
          width: 46,
          height: 46,

          decoration:
              BoxDecoration(
            color:
                color.withValues(
              alpha: .13,
            ),

            borderRadius:
                BorderRadius.circular(
              14,
            ),
          ),

          child:
              Icon(
            icon,
            color:
                color,
          ),
        ),

        title:
            Text(
          title,

          style:
              const TextStyle(
            color:
                Colors.white,
            fontWeight:
                FontWeight.w600,
          ),
        ),

        subtitle:
            Text(
          subtitle,

          style:
              const TextStyle(
            color:
                Colors.white60,
            fontSize:
                12,
          ),
        ),

        value:
            value,

        activeThumbColor:
            AppColors.primary,

        activeTrackColor:
            AppColors.primary.withValues(
          alpha: .35,
        ),

        onChanged:
            onChanged,
      ),
    );
  }
}