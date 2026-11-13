
import 'package:flutter/material.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() =>
      _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  // SmartHaven theme colors
  static const Color bg = Color(0xFF211812);
  static const Color card = Color(0xFF33251D);
  static const Color gold = Color(0xFFE8BC8A);
  static const Color cream = Color(0xFFF4E9DC);
  static const Color muted = Color(0xFFB9A99B);
  static const Color green = Color(0xFF8BCF83);
  static const Color red = Color(0xFFE57373);

  bool twoFactorEnabled = false;

  bool cameraPermission = true;
  bool locationPermission = true;
  bool notificationPermission = true;
  bool microphonePermission = false;

  bool showDevices = false;

  // Change Password Dialog
  void showChangePasswordDialog() {
    final currentController = TextEditingController();
    final newController = TextEditingController();
    final confirmController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: card,
          title: const Text(
            'Change Password',
            style: TextStyle(color: cream),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                passwordField(
                  'Current Password',
                  currentController,
                ),
                const SizedBox(height: 15),
                passwordField(
                  'New Password',
                  newController,
                ),
                const SizedBox(height: 15),
                passwordField(
                  'Confirm New Password',
                  confirmController,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: muted),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: gold,
                foregroundColor: bg,
              ),
              onPressed: () {
                if (currentController.text.isEmpty ||
                    newController.text.isEmpty ||
                    confirmController.text.isEmpty) {
                  showMessage('Please fill in all fields');
                } else if (newController.text !=
                    confirmController.text) {
                  showMessage('New passwords do not match');
                } else if (newController.text.length < 8) {
                  showMessage(
                    'Password must contain at least 8 characters',
                  );
                } else {
                  Navigator.pop(dialogContext);
                  showMessage(
                    'Demo only: connect password update to authentication',
                  );
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    ).then((_) {
      currentController.dispose();
      newController.dispose();
      confirmController.dispose();
    });
  }

  Widget passwordField(
    String label,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      obscureText: true,
      style: const TextStyle(color: cream),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: muted),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: muted),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: gold),
        ),
      ),
    );
  }

  // Login Activity Dialog
  void showLoginActivity() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: card,
          title: const Text(
            'Login Activity',
            style: TextStyle(color: cream),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              loginItem(
                Icons.phone_android,
                'Android Device',
                'Current device • Recently active',
              ),
              const SizedBox(height: 15),
              loginItem(
                Icons.computer,
                'Windows Computer',
                'Previous login • Demo information',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Close',
                style: TextStyle(color: gold),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget loginItem(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon, color: gold, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: cream,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: muted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Delete Account Dialog
  void showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: card,
          title: const Text(
            'Delete Account?',
            style: TextStyle(color: red),
          ),
          content: const Text(
            'Are you sure you want to delete your SmartHaven account? '
            'This action cannot be undone.',
            style: TextStyle(color: cream),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Cancel',
                style: TextStyle(color: muted),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                showMessage(
                  'Demo only: account deletion is not connected yet',
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: card,
      ),
    );
  }

  // Main option card
  Widget securityOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color iconColor = gold,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 23,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: cream,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: muted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: muted,
            ),
          ],
        ),
      ),
    );
  }

  // Section heading
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 22,
        bottom: 13,
        left: 4,
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: gold,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  // Permission switch
  Widget permissionOption({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 9,
      ),
      child: Row(
        children: [
          Icon(icon, color: gold, size: 22),
          const SizedBox(width: 13),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: cream,
                fontSize: 14,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: green,
            activeTrackColor: green.withOpacity(0.3),
            inactiveThumbColor: muted,
            inactiveTrackColor: bg,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,

      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: cream,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Privacy & Security',
          style: TextStyle(
            color: cream,
            fontSize: 20,
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

              // Introduction
              const Text(
                'Protect your SmartHaven account and connected home.',
                style: TextStyle(
                  color: muted,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 22),

              // Security status card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: card,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      color: green,
                      size: 35,
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account Security',
                            style: TextStyle(
                              color: cream,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Manage your account protection settings',
                            style: TextStyle(
                              color: muted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Security section
              sectionTitle('SECURITY'),

              securityOption(
                icon: Icons.lock_outline,
                title: 'Change Password',
                subtitle: 'Update your account password',
                onTap: showChangePasswordDialog,
              ),

              // Two factor authentication
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: card,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.verified_user_outlined,
                      color: gold,
                      size: 25,
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Two-Factor Authentication',
                            style: TextStyle(
                              color: cream,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Add an extra layer of protection',
                            style: TextStyle(
                              color: muted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: twoFactorEnabled,
                      onChanged: (value) {
                        setState(() {
                          twoFactorEnabled = value;
                        });
                        showMessage(
                          'Demo switch only: connect 2FA authentication',
                        );
                      },
                      activeThumbColor: green,
                    ),
                  ],
                ),
              ),

              securityOption(
                icon: Icons.history,
                title: 'Login Activity',
                subtitle: 'Review recent account logins',
                onTap: showLoginActivity,
              ),

              // Trusted devices
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: card,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 5,
                      ),
                      leading: const Icon(
                        Icons.devices,
                        color: gold,
                        size: 25,
                      ),
                      title: const Text(
                        'Trusted Devices',
                        style: TextStyle(
                          color: cream,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: const Text(
                        'Manage connected devices',
                        style: TextStyle(
                          color: muted,
                          fontSize: 12,
                        ),
                      ),
                      trailing: Icon(
                        showDevices
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: muted,
                      ),
                      onTap: () {
                        setState(() {
                          showDevices = !showDevices;
                        });
                      },
                    ),
                    if (showDevices) ...[
                      const Divider(color: bg),
                      loginItem(
                        Icons.phone_android,
                        'Android Device',
                        'Current device • Demo entry',
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          'Device management will be connected to your account later.',
                          style: TextStyle(
                            color: muted,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Privacy section
              sectionTitle('PRIVACY'),

              Container(
                decoration: BoxDecoration(
                  color: card,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    permissionOption(
                      icon: Icons.camera_alt_outlined,
                      title: 'Camera Access',
                      value: cameraPermission,
                      onChanged: (value) {
                        setState(() {
                          cameraPermission = value;
                        });
                      },
                    ),
                    const Divider(color: bg, height: 1),
                    permissionOption(
                      icon: Icons.location_on_outlined,
                      title: 'Location Access',
                      value: locationPermission,
                      onChanged: (value) {
                        setState(() {
                          locationPermission = value;
                        });
                      },
                    ),
                    const Divider(color: bg, height: 1),
                    permissionOption(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      value: notificationPermission,
                      onChanged: (value) {
                        setState(() {
                          notificationPermission = value;
                        });
                      },
                    ),
                    const Divider(color: bg, height: 1),
                    permissionOption(
                      icon: Icons.mic_none,
                      title: 'Microphone Access',
                      value: microphonePermission,
                      onChanged: (value) {
                        setState(() {
                          microphonePermission = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              // Danger zone
              sectionTitle('DANGER ZONE'),

              securityOption(
                icon: Icons.delete_outline,
                title: 'Delete Account',
                subtitle: 'Permanently remove your account',
                iconColor: red,
                onTap: showDeleteAccountDialog,
              ),

              const SizedBox(height: 20),

              const Center(
                child: Text(
                  'SmartHaven • Privacy & Security',
                  style: TextStyle(
                    color: muted,
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
}
