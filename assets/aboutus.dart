import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const SmartHavenApp());
}

class SmartHavenApp extends StatelessWidget {
  const SmartHavenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFF1E1009),
      ),
      home: const AboutSmartHavenPage(),
    );
  }
}

class AboutSmartHavenPage extends StatelessWidget {
  const AboutSmartHavenPage({super.key});

  static const Color backgroundColor = Color(0xFF211109);
  static const Color cardColor = Color(0xFF402719);
  static const Color accentColor = Color(0xFFFFB477);
  static const Color whiteColor = Color(0xFFF8F1EB);

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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // HERO SECTION
              ClipPath(
                clipper: HeroWaveClipper(),
                child: SizedBox(
                  height: 440,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [

                      // Background Image
                      Image.asset(
                        'assets/64 Villa House Designs That Merge Style with Nature.jpg',
                        fit: BoxFit.cover,
                      ),

                      // Dark Gradient
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.25),
                              Colors.black.withOpacity(0.15),
                              backgroundColor.withOpacity(0.65),
                            ],
                          ),
                        ),
                      ),

                      // Back Button
                      Positioned(
                        top: 65,
                        left: 25,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.maybePop(context);
                          },
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.35),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      ),

                      // SmartHaven Logo
                      Positioned(
                        left: 32,
                        bottom: 65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.home_outlined,
                                  size: 72,
                                  color: accentColor,
                                ),
                                Icon(
                                  Icons.eco_outlined,
                                  size: 43,
                                  color: accentColor,
                                ),
                              ],
                            ),

                            const SizedBox(height: 5),

                            RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontSize: 35,
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

                            const SizedBox(height: 7),

                            const Text(
                              'Live Smart. Live Better.',
                              style: TextStyle(
                                color: whiteColor,
                                fontSize: 15,
                                letterSpacing: 2,
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
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 35),

                    // PAGE TITLE
                    const Text(
                      'About SmartHaven',
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // DESCRIPTION
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: Color(0xFFD8C8BC),
                          fontSize: 20,
                          height: 1.65,
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

                    const SizedBox(height: 32),

                    // FEATURE CARDS
                    const FeatureCard(
                      icon: Icons.home_outlined,
                      title: 'Smart Living',
                      subtitle:
                          'Manage your home and lifestyle with ease.',
                    ),

                    const SizedBox(height: 13),

                    const FeatureCard(
                      icon: Icons.verified_user_outlined,
                      title: 'Your Security',
                      subtitle: 'Your safety is our priority.',
                    ),

                    const SizedBox(height: 13),

                    const FeatureCard(
                      icon: Icons.bolt_outlined,
                      title: 'Always Connected',
                      subtitle: 'Get the support you need, anytime.',
                    ),

                    const SizedBox(height: 13),

                    const FeatureCard(
                      icon: Icons.favorite_border,
                      title: 'A Better Tomorrow',
                      subtitle:
                          "Together, let's build a smarter future.",
                    ),

                    const SizedBox(height: 45),

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
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Icon(
                            Icons.eco_outlined,
                            color: accentColor,
                            size: 38,
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
                                fontSize: 29,
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

                          const SizedBox(height: 5),

                          const Text(
                            'Live Smart. Live Better.',
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 17,
                              letterSpacing: 4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 45),
                  ],
                ),
              ),
            ],
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
        horizontal: 20,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF402719).withOpacity(0.85),
        borderRadius: BorderRadius.circular(27),
        border: Border.all(
          color: const Color(0xFF765039).withOpacity(0.35),
        ),
      ),
      child: Row(
        children: [

          // ICON CIRCLE
          Container(
            height: 90,
            width: 90,
            decoration: const BoxDecoration(
              color: Color(0xFF593722),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFFFFB477),
              size: 48,
            ),
          ),

          const SizedBox(width: 25),

          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFF8F1EB),
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFFD0BFB2),
                    fontSize: 16,
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

    path.lineTo(0, size.height - 30);

    path.cubicTo(
      size.width * 0.20,
      size.height + 5,
      size.width * 0.38,
      size.height - 55,
      size.width * 0.58,
      size.height - 35,
    );

    path.cubicTo(
      size.width * 0.78,
      size.height - 10,
      size.width * 0.90,
      size.height - 5,
      size.width,
      size.height - 30,
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