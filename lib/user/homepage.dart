import 'package:flutter/material.dart';
import 'package:smarthaven/user/profilescreen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // COLORS
  static const Color background = Color(0xFF17100D);
  static const Color cardColor = Color(0xFF302019);
  static const Color peach = Color(0xFFF2B58E);
  static const Color green = Color(0xFF55E5A9);
  static const Color lightText = Color(0xFFD0C3BB);

  // IMAGE PATHS
  static const String homeImage = 'assets/homeintro.jpg';
  static const String bedroomImage = 'assets/bedroom.jpg';
  static const String kitchenImage = 'assets/Kitchen.jpg';
  static const String livingImage = 'assets/living room.jpg';
  static const String guestImage = 'assets/guest room.jpg';

  // PROFILE NAVIGATION
  void openProfile(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ProfileScreen(),
        transitionDuration: const Duration(milliseconds: 600),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          final fadeAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );

          final slideAnimation = Tween<Offset>(
            begin: const Offset(0.15, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
          );

          return FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: slideAnimation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildBanner(context),
                  buildWelcome(),
                  buildSecurityAlert(),
                  buildHomeSecurity(),
                  buildGasMonitoring(),
                  buildRooms(),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigation(context),
    );
  }

  // TOP BANNER
  Widget buildBanner(BuildContext context) {
    return SizedBox(
      height: 235,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            homeImage,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: cardColor,
                child: const Icon(
                  Icons.home,
                  color: peach,
                  size: 48,
                ),
              );
            },
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.40),
                  Colors.transparent,
                  background.withOpacity(0.98),
                ],
                stops: const [0.0, 0.40, 1.0],
              ),
            ),
          ),

          // LOGO AND ICONS
          Positioned(
            top: 14,
            left: 17,
            right: 17,
            child: Row(
              children: [
                const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 27,
                ),
                const SizedBox(width: 6),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'Smart',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: 'Haven',
                        style: TextStyle(color: peach),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(7),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 23,
                  ),
                ),
                const SizedBox(width: 7),
                GestureDetector(
                  onTap: () => openProfile(context),
                  child: const CircleAvatar(
                    radius: 17,
                    backgroundColor: peach,
                    child: Icon(
                      Icons.person,
                      color: Color(0xFF39251C),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // TAGLINE
          const Positioned(
            top: 65,
            left: 50,
            child: Text(
              'SMART LIVING. SAFE LIVING.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 9,
                letterSpacing: 2,
              ),
            ),
          ),

          // BANNER TEXT
          const Positioned(
            bottom: 16,
            left: 20,
            right: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'SmartHaven',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Your home, your comfort, your safety.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // WELCOME SECTION
  Widget buildWelcome() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 20, 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back,',
            style: TextStyle(
              color: lightText,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Text(
                'User',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.favorite_border,
                color: peach,
                size: 22,
              ),
            ],
          ),
          SizedBox(height: 2),
          Text(
            'Your home is in safe hands ♡',
            style: TextStyle(
              color: lightText,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // SECURITY ALERT
  Widget buildSecurityAlert() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF492E22),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFF674433),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: peach,
            size: 27,
          ),
          const SizedBox(width: 9),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Security Alert',
                  style: TextStyle(
                    color: peach,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Unknown Entry Detected',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'at 08:47 PM',
                  style: TextStyle(
                    color: lightText,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.camera_alt_outlined,
            color: Colors.white70,
            size: 19,
          ),
          const SizedBox(width: 3),
          const Icon(
            Icons.chevron_right,
            color: Colors.white,
            size: 21,
          ),
        ],
      ),
    );
  }

  // HOME SECURITY
  Widget buildHomeSecurity() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),
      padding: const EdgeInsets.all(11),
      decoration: cardDecoration(),
      child: Row(
        children: [
          const Icon(
            Icons.shield_outlined,
            color: peach,
            size: 30,
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Home Security',
                  style: TextStyle(
                    color: lightText,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      'Secured',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 7),
                    Icon(
                      Icons.circle,
                      color: green,
                      size: 10,
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  'All systems are normal',
                  style: TextStyle(
                    color: lightText,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: peach,
            size: 13,
          ),
        ],
      ),
    );
  }

  // GAS LEAKAGE MONITORING
  Widget buildGasMonitoring() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),
      padding: const EdgeInsets.all(11),
      decoration: cardDecoration(),
      child: Row(
        children: [
          const Icon(
            Icons.local_fire_department_outlined,
            color: peach,
            size: 29,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gas Leakage Monitoring',
                  style: TextStyle(
                    color: lightText,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'No Gas Leak Detected',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 13,
            backgroundColor: green,
            child: Icon(
              Icons.check,
              color: background,
              size: 17,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(
            Icons.chevron_right,
            color: Colors.white,
            size: 22,
          ),
        ],
      ),
    );
  }

  // ROOMS SECTION
  Widget buildRooms() {
    final rooms = [
      {
        'name': 'Bedroom',
        'image': bedroomImage,
        'icon': Icons.bed_outlined,
      },
      {
        'name': 'Kitchen',
        'image': kitchenImage,
        'icon': Icons.kitchen_outlined,
      },
      {
        'name': 'Living Room',
        'image': livingImage,
        'icon': Icons.weekend_outlined,
      },
      {
        'name': 'Guest Room',
        'image': guestImage,
        'icon': Icons.person_outline,
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 13, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.grid_view_rounded,
                color: peach,
                size: 21,
              ),
              const SizedBox(width: 8),
              const Text(
                'Rooms',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Text(
                'View All  →',
                style: TextStyle(
                  color: peach,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rooms.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.25,
            ),
            itemBuilder: (context, index) {
              final room = rooms[index];

              return buildRoomCard(
                room['name'] as String,
                room['image'] as String,
                room['icon'] as IconData,
              );
            },
          ),
        ],
      ),
    );
  }

  // INDIVIDUAL ROOM CARD
  Widget buildRoomCard(
    String name,
    String image,
    IconData icon,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(17),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: cardColor,
                child: const Icon(
                  Icons.home_outlined,
                  color: peach,
                  size: 35,
                ),
              );
            },
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.85),
                ],
                stops: const [0.35, 1.0],
              ),
            ),
          ),

          Positioned(
            top: 8,
            right: 8,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.black.withOpacity(0.55),
              child: Icon(
                icon,
                color: peach,
                size: 18,
              ),
            ),
          ),

          Positioned(
            left: 10,
            right: 9,
            bottom: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                const Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: green,
                      size: 8,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Active',
                      style: TextStyle(
                        color: lightText,
                        fontSize: 10,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // COMMON CARD DECORATION
  BoxDecoration cardDecoration() {
    return BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(19),
      border: Border.all(
        color: const Color(0xFF49352A),
        width: 1,
      ),
    );
  }

  // BOTTOM NAVIGATION BAR
  Widget buildBottomNavigation(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(13, 4, 13, 9),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF35241D),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: const Color(0xFF634332),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          navItem(Icons.home_filled, 'Home', true),
          navItem(Icons.shield_outlined, 'Security', false),
          navItem(Icons.grid_view_rounded, 'Devices', false),
          GestureDetector(
            onTap: () => openProfile(context),
            child: navItem(
              Icons.person_outline,
              'Profile',
              false,
            ),
          ),
        ],
      ),
    );
  }

  // BOTTOM NAVIGATION ITEM
  Widget navItem(
    IconData icon,
    String title,
    bool selected,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: selected ? peach : Colors.white70,
          size: 21,
        ),
        const SizedBox(height: 3),
        Text(
          title,
          style: TextStyle(
            color: selected ? peach : Colors.white70,
            fontSize: 10,
            fontWeight:
                selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 3),
        if (selected)
          Container(
            height: 2,
            width: 19,
            decoration: BoxDecoration(
              color: peach,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
      ],
    );
  }
}