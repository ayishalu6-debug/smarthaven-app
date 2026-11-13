
import 'package:flutter/material.dart';
import 'package:smarthaven/user/aboutus.dart';
import 'package:smarthaven/user/auth.dart';
import 'package:smarthaven/user/familymembers.dart';
import 'package:smarthaven/user/help.dart';
import 'package:smarthaven/user/myhomescreen.dart';
import 'package:smarthaven/user/privacy.dart';
import 'package:smarthaven/user/userprofilescreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // SMART HAVEN THEME COLORS
  static const Color bg = Color(0xFF211812);
  static const Color card = Color(0xFF33251D);
  static const Color gold = Color(0xFFE8BC8A);
  static const Color cream = Color(0xFFF4E9DC);
  static const Color muted = Color(0xFFB9A99B);
  static const Color green = Color(0xFF8BCF83);

  int selectedIndex = 3;
  bool isDarkTheme = true;

  // PAGE NAVIGATION
  void navigateToPage(Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slideAnimation = Tween<Offset>(
            begin: const Offset(0.04, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
          );

          final fadeAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );

          return FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: slideAnimation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 350),
        reverseTransitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  // APPEARANCE POPUP
  void openAppearancePopup() {
    bool selectedTheme = isDarkTheme;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setPopupState) {
            return Dialog(
              backgroundColor: const Color(0xFF493021),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19),
                side: BorderSide(color: gold.withOpacity(0.35)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.palette_outlined,
                          color: gold,
                          size: 21,
                        ),
                        const SizedBox(width: 9),
                        const Expanded(
                          child: Text(
                            "Appearance",
                            style: TextStyle(
                              color: cream,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(5),
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: muted,
                            size: 20,
                          ),
                        ),
                      ],
                    ),

                    Divider(color: gold.withOpacity(0.2)),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            color: const Color(0xFF573824),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Icon(
                            selectedTheme
                                ? Icons.dark_mode_outlined
                                : Icons.light_mode_outlined,
                            color: gold,
                            size: 21,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Theme",
                                style: TextStyle(
                                  color: cream,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "Choose your preferred theme.",
                                style: TextStyle(
                                  color: muted,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: selectedTheme,
                          activeColor: gold,
                          activeTrackColor: Color(0xFF806044),
                          inactiveThumbColor: cream,
                          inactiveTrackColor: Colors.grey,
                          onChanged: (value) {
                            setPopupState(() {
                              selectedTheme = value;
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),
                    Divider(color: gold.withOpacity(0.2)),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: cream,
                              side: BorderSide(
                                color: gold.withOpacity(0.5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isDarkTheme = selectedTheme;
                              });
                              Navigator.pop(dialogContext);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: gold,
                              foregroundColor: bg,
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Done",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
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

  // PROFILE OPTION WIDGET
  Widget profileOption({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF493021),
            Color(0xFF33251D),
          ],
        ),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: gold.withOpacity(0.12)),
      ),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 5,
        ),
        minLeadingWidth: 0,
        leading: Container(
          height: 43,
          width: 43,
          decoration: BoxDecoration(
            color: const Color(0xFF513523),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(icon, color: gold, size: 23),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: cream,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            subtitle,
            style: const TextStyle(
              color: muted,
              fontSize: 11,
            ),
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: cream,
          size: 23,
        ),
        onTap: onTap,
      ),
    );
  }

  // SECTION HEADING
  Widget sectionHeading({
    required IconData icon,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 17, bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: gold, size: 21),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: cream,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // PROFILE CARD
  Widget profileCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF573824),
            Color(0xFF33251D),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: gold.withOpacity(0.45)),
      ),
      child: Row(
        children: [
          Container(
            height: 72,
            width: 72,
            decoration: const BoxDecoration(
              color: Color(0xFFD9C2B1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Color(0xFF513A2C),
              size: 51,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "user",
                  style: TextStyle(
                    color: cream,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "user@gmail.com",
                  style: TextStyle(
                    color: muted,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: gold.withOpacity(0.5),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        color: green,
                        size: 8,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Active Account",
                        style: TextStyle(
                          color: cream,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(4),
            onPressed: () {
              navigateToPage(UserProfileScreen());
            },
            icon: const Icon(
              Icons.chevron_right,
              color: cream,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  // BOTTOM NAVIGATION
  Widget bottomNavigation() {
    final icons = [
      Icons.home_rounded,
      Icons.shield_outlined,
      Icons.grid_view_rounded,
      Icons.person_outline,
    ];

    final labels = [
      "Home",
      "Security",
      "Devices",
      "Profile",
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(13, 5, 13, 9),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF493021),
            Color(0xFF33251D),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: gold.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(4, (index) {
          bool isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icons[index],
                  color: isSelected ? gold : cream,
                  size: 21,
                ),
                const SizedBox(height: 3),
                Text(
                  labels[index],
                  style: TextStyle(
                    color: isSelected ? gold : muted,
                    fontSize: 10,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  height: 2,
                  width: isSelected ? 19 : 0,
                  decoration: BoxDecoration(
                    color: gold,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ==========================================
  // LOGOUT CONFIRMATION POPUP
  // ==========================================

  void showLogoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: const Color(0xFF3B281F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
            side: const BorderSide(
              color: Color(0xFF9B704B),
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 28, 22, 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // LOGOUT ICON
                Container(
                  height: 82,
                  width: 82,
                  decoration: const BoxDecoration(
                    color: Color(0xFF523522),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: Color(0xFFE6B982),
                    size: 43,
                  ),
                ),

                const SizedBox(height: 16),

                // TITLE
                const Text(
                  "Log Out?",
                  style: TextStyle(
                    color: cream,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // DESCRIPTION
                const Text(
                  "Are you sure you want to log out of your account?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFD6C1B5),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 25),

                Divider(
                  color: gold.withOpacity(0.2),
                  height: 1,
                ),

                const SizedBox(height: 19),

                // BUTTONS
                Row(
                  children: [

                    // NO BUTTON
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: gold,
                            side: const BorderSide(
                              color: Color(0xFFE6B982),
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            "No",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // YES LOGOUT BUTTON
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            // CLOSE POPUP
                            Navigator.pop(dialogContext);

                            // NAVIGATE TO REGISTRATION PAGE
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                  SmartHavenAuthPage (),
                              ),
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD77C78),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Yes, Log Out",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // MAIN BUILD METHOD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(17, 12, 17, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // TOP HEADER
              Row(
                children: [
                  const Icon(
                    Icons.home_outlined,
                    color: gold,
                    size: 26,
                  ),
                  const SizedBox(width: 9),
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Smart",
                            style: TextStyle(
                              color: cream,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "Haven",
                            style: TextStyle(
                              color: gold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(5),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none,
                      color: cream,
                      size: 23,
                    ),
                  ),
                  const SizedBox(width: 9),
                  const Icon(
                    Icons.settings_outlined,
                    color: cream,
                    size: 23,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // PAGE TITLE
              const Text(
                "Profile",
                style: TextStyle(
                  color: cream,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 3),

              const Text(
                "Manage your account and preferences",
                style: TextStyle(
                  color: muted,
                  fontSize: 12,
                ),
              ),

              Container(
                margin: const EdgeInsets.only(
                  top: 13,
                  bottom: 19,
                ),
                height: 2,
                width: 85,
                color: gold,
              ),

              // PROFILE CARD
              profileCard(),

              // ACCOUNT SECTION
              sectionHeading(
                icon: Icons.grid_view_rounded,
                title: "Account",
              ),

              profileOption(
                icon: Icons.home_outlined,
                title: "My Home",
                subtitle: "Home details and address",
                onTap: () {
                  navigateToPage(MyHomeScreen());
                },
              ),

              profileOption(
                icon: Icons.people_outline,
                title: "Family Members",
                subtitle: "Manage household members",
                onTap: () {
                  navigateToPage(FamilyMembersScreen());
                },
              ),

              // PREFERENCES SECTION
              sectionHeading(
                icon: Icons.tune,
                title: "Preferences",
              ),

              profileOption(
                icon: Icons.palette_outlined,
                title: "Appearance",
                subtitle: "Light, Dark or System mode",
                onTap: openAppearancePopup,
              ),

              profileOption(
                icon: Icons.shield_outlined,
                title: "Privacy & Security",
                subtitle: "Keep your account safe",
                onTap: () {
                  navigateToPage(PrivacySecurityScreen());
                },
              ),

              // SUPPORT SECTION
              sectionHeading(
                icon: Icons.support_agent,
                title: "Support",
              ),

              profileOption(
                icon: Icons.help_outline,
                title: "Help & Support",
                subtitle: "FAQs, guides and contact us",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HelpSupportApp(),
                    ),
                  );
                },
              ),

              profileOption(
                icon: Icons.info_outline,
                title: "About SmartHaven",
                subtitle: "App version & more",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutSmartHavenPage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 7),

              // LOGOUT BUTTON
              SizedBox(
                width: double.infinity,
                height: 46,
                child: OutlinedButton.icon(
                  onPressed: showLogoutDialog,
                  icon: const Icon(
                    Icons.logout,
                    color: Color(0xFFE87972),
                    size: 18,
                  ),
                  label: const Text(
                    "Log Out",
                    style: TextStyle(
                      color: Color(0xFFE87972),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFFE87972),
                      width: 1.2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),

      bottomNavigationBar: bottomNavigation(),
    );
  }
}
