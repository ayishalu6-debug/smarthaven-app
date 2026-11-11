import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final Color peach = const Color(0xFFE8AE83);
  final Color cardColor = const Color(0xFF30221B);
  final Color mutedText = const Color(0xFFB9A69A);

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF493328),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17110E),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HOME INTRO BANNER
                  _buildHeader(),

                  // WELCOME SECTION
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: TextStyle(color: mutedText, fontSize: 15),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Flexible(
                              child: Text(
                                'User',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 7),
                            Icon(Icons.favorite_border, color: peach, size: 23),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Your home is in safe hands ♡',
                          style: TextStyle(color: mutedText, fontSize: 13),
                        ),
                      ],
                    ),
                  ),

                  // SECURITY ALERT
                  _buildSecurityAlert(),

                  // HOME SECURITY
                  _buildHomeSecurity(),

                  // GAS MONITORING
                  _buildGasMonitoring(),

                  // ROOMS TITLE
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
                    child: Row(
                      children: [
                        Icon(Icons.grid_view_rounded, color: peach, size: 21),
                        const SizedBox(width: 9),
                        const Text(
                          'Rooms',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => showMessage('All rooms'),
                          child: Text(
                            'View All  →',
                            style: TextStyle(
                              color: peach,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // FOUR ROOM CARDS
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 13,
                      mainAxisSpacing: 13,
                      childAspectRatio: 0.91,
                      children: [
                        _buildRoomCard(
                          'Bedroom',
                          'assets/bedroom.jpg',
                          Icons.bed_rounded,
                        ),
                        _buildRoomCard(
                          'Kitchen',
                          'assets/Kitchen.jpg',
                          Icons.soup_kitchen_rounded,
                        ),
                        _buildRoomCard(
                          'Living Room',
                          'assets/living room.jpg',
                          Icons.weekend_rounded,
                        ),
                        _buildRoomCard(
                          'Guest Room',
                          'assets/guest room.jpg',
                          Icons.person_rounded,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // BOTTOM NAVIGATION
            Positioned(
              left: 15,
              right: 15,
              bottom: 12,
              child: _buildBottomNavigation(),
            ),
          ],
        ),
      ),
    );
  }

  // HEADER WITH FULL-WIDTH HOME INTRO IMAGE
  Widget _buildHeader() {
    return SizedBox(
      height: 235,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/homeintro.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: const Color(0xFF493328));
            },
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.35),
                  Colors.black.withOpacity(0.15),
                  const Color(0xFF17110E).withOpacity(0.95),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.home_outlined, color: Colors.white, size: 30),
                    const SizedBox(width: 8),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Smart',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'Haven',
                            style: TextStyle(
                              color: const Color(0xFFE8AE83),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => showMessage('Notifications'),
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
                    const CircleAvatar(
                      radius: 19,
                      backgroundColor: Color(0xFFE8AE83),
                      child: Icon(Icons.person, color: Color(0xFF30221B)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Padding(
                  padding: EdgeInsets.only(left: 39),
                  child: Text(
                    'SMART LIVING. SAFE LIVING.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 9,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  'Welcome to',
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
                const Text(
                  'SmartHaven',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 31,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Your home, your comfort, your safety.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // SECURITY ALERT CARD
  Widget _buildSecurityAlert() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF493027),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF8D5D43).withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: peach, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Security Alert',
                  style: TextStyle(
                    color: peach,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Unknown Entry Detected',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  'at 08:47 PM',
                  style: TextStyle(color: mutedText, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.camera_alt_outlined,
            color: Colors.white70,
            size: 32,
          ),
          IconButton(
            onPressed: () => showMessage('Security alert details'),
            icon: const Icon(Icons.chevron_right, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // HOME SECURITY CARD
  Widget _buildHomeSecurity() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          const Icon(Icons.shield_outlined, color: Color(0xFFE8AE83), size: 31),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Home Security',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text(
                      'Secured',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  'All systems are normal',
                  style: TextStyle(color: mutedText, fontSize: 11),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => showMessage('Home security details'),
            child: Text(
              'View Details →',
              style: TextStyle(color: peach, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  // GAS LEAKAGE MONITORING CARD
  Widget _buildGasMonitoring() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.local_fire_department_outlined,
            color: Color(0xFFE8AE83),
            size: 31,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gas Leakage Monitoring',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                SizedBox(height: 6),
                Text(
                  'No Gas Leak Detected',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: Colors.greenAccent, size: 25),
          IconButton(
            onPressed: () => showMessage('Gas monitoring details'),
            icon: const Icon(Icons.chevron_right, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // ROOM CARD WITH LOCAL IMAGE
  Widget _buildRoomCard(String roomName, String imagePath, IconData roomIcon) {
    return GestureDetector(
      onTap: () {
        showMessage('$roomName selected');
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF493328),
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.white54,
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
                    Colors.black.withOpacity(0.10),
                    Colors.black.withOpacity(0.15),
                    Colors.black.withOpacity(0.88),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 11,
              right: 11,
              child: CircleAvatar(
                radius: 17,
                backgroundColor: Colors.black.withOpacity(0.55),
                child: Icon(roomIcon, color: peach, size: 19),
              ),
            ),

            Positioned(
              left: 13,
              right: 10,
              bottom: 13,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roomName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Active',
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // BOTTOM NAVIGATION BAR
  Widget _buildBottomNavigation() {
    final items = [
      Icons.home_rounded,
      Icons.shield_outlined,
      Icons.grid_view_rounded,
      Icons.person_outline_rounded,
    ];

    final labels = ['Home', 'Security', 'Devices', 'Profile'];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF30221B),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF8D5D43).withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });

              if (index != 0) {
                showMessage('${labels[index]} page selected');
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  items[index],
                  color: isSelected ? peach : Colors.white60,
                  size: 23,
                ),
                const SizedBox(height: 5),
                Text(
                  labels[index],
                  style: TextStyle(
                    color: isSelected ? peach : Colors.white60,
                    fontSize: 10,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 3,
                  width: 19,
                  decoration: BoxDecoration(
                    color: isSelected ? peach : Colors.transparent,
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
}
