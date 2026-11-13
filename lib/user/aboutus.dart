import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutSmartHavenPage extends StatelessWidget {
  const AboutSmartHavenPage({super.key});

  static const Color backgroundColor = Color(0xFF211109);
  static const Color cardColor = Color(0xFF402719);
  static const Color accentColor = Color(0xFFFFB477);
  static const Color whiteColor = Color(0xFFF8F1EB);

  // SMOOTH FADE + SLIDE PAGE TRANSITION
  static Future<void> open(BuildContext context) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AboutSmartHavenPage(),

        transitionDuration: const Duration(milliseconds: 600),
        reverseTransitionDuration: const Duration(milliseconds: 500),

        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          final slideAnimation = Tween<Offset>(
            begin: const Offset(0.15, 0),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: backgroundColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HERO SECTION
                ClipPath(
                  clipper: HeroWaveClipper(),
                  child: SizedBox(
                    height: 310,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // BACKGROUND IMAGE
                        Image.asset(
                          'assets/64 Villa House Designs That Merge Style with Nature.jpg',
                          fit: BoxFit.cover,
                        ),

                        // DARK GRADIENT
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.30),
                                Colors.black.withOpacity(0.15),
                                backgroundColor.withOpacity(0.75),
                              ],
                            ),
                          ),
                        ),

                        // BACK BUTTON
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 12,
                          left: 17,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.maybePop(context);
                            },
                            child: Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.35),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 17,
                              ),
                            ),
                          ),
                        ),

                        // SMART HAVEN LOGO
                        Positioned(
                          left: 23,
                          bottom: 43,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.home_outlined,
                                    size: 53,
                                    color: accentColor,
                                  ),
                                  Icon(
                                    Icons.eco_outlined,
                                    size: 32,
                                    color: accentColor,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 3),

                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Smart',
                                      style: TextStyle(color: whiteColor),
                                    ),
                                    TextSpan(
                                      text: 'Haven',
                                      style: TextStyle(color: accentColor),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 4),

                              const Text(
                                'Live Smart. Live Better.',
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 11,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // MAIN CONTENT
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 19),

                      // PAGE TITLE
                      const Text(
                        'About SmartHaven',
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 14),

                      // DESCRIPTION
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            color: Color(0xFFD8C8BC),
                            fontSize: 14,
                            height: 1.6,
                          ),
                          children: [
                            TextSpan(
                              text: 'SmartHaven',
                              style: TextStyle(
                                color: accentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' is your all-in-one smart living companion, designed to make your everyday life easier, safer and more connected. From managing your home, staying organized, to getting the right support — ',
                            ),
                            TextSpan(
                              text: 'SmartHaven',
                              style: TextStyle(
                                color: accentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' is here to help you live smarter, every day.',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 23),

                      // FEATURE CARDS
                      const FeatureCard(
                        icon: Icons.home_outlined,
                        title: 'Smart Living',
                        subtitle:
                            'Manage your home and lifestyle with ease.',
                      ),

                      const SizedBox(height: 10),

                      const FeatureCard(
                        icon: Icons.verified_user_outlined,
                        title: 'Your Security',
                        subtitle: 'Your safety is our priority.',
                      ),

                      const SizedBox(height: 10),

                      const FeatureCard(
                        icon: Icons.bolt_outlined,
                        title: 'Always Connected',
                        subtitle: 'Get the support you need, anytime.',
                      ),

                      const SizedBox(height: 10),

                      const FeatureCard(
                        icon: Icons.favorite_border,
                        title: 'A Better Tomorrow',
                        subtitle:
                            "Together, let's build a smarter future.",
                      ),

                      const SizedBox(height: 28),

                      // FOOTER DIVIDER
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(
                              color: Color(0xFF9A6748),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Icon(
                              Icons.eco_outlined,
                              color: accentColor,
                              size: 27,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Color(0xFF9A6748),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // FOOTER LOGO
                      Center(
                        child: Column(
                          children: [
                            RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Smart',
                                    style: TextStyle(color: whiteColor),
                                  ),
                                  TextSpan(
                                    text: 'Haven',
                                    style: TextStyle(color: accentColor),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 4),

                            const Text(
                              'Live Smart. Live Better.',
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 12,
                                letterSpacing: 2.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// FEATURE CARD WIDGET

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF402719).withOpacity(0.85),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFF765039).withOpacity(0.35),
        ),
      ),
      child: Row(
        children: [
          // ICON CIRCLE
          Container(
            height: 57,
            width: 57,
            decoration: const BoxDecoration(
              color: Color(0xFF593722),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFFFFB477),
              size: 30,
            ),
          ),

          const SizedBox(width: 14),

          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFF8F1EB),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFFD0BFB2),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// HERO IMAGE BOTTOM WAVE CLIPPER

class HeroWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 22);

    path.cubicTo(
      size.width * 0.20,
      size.height + 5,
      size.width * 0.38,
      size.height - 40,
      size.width * 0.58,
      size.height - 27,
    );

    path.cubicTo(
      size.width * 0.78,
      size.height - 8,
      size.width * 0.90,
      size.height - 4,
      size.width,
      size.height - 22,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}