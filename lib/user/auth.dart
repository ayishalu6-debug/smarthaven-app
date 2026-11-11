import 'package:flutter/material.dart';

class SmartHavenAuthPage extends StatefulWidget {
  const SmartHavenAuthPage({super.key});

  @override
  State<SmartHavenAuthPage> createState() => _SmartHavenAuthPageState();
}

class _SmartHavenAuthPageState extends State<SmartHavenAuthPage> {
  bool isLogin = false;

  // Register controllers
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Login controllers
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool obscureLoginPassword = true;
  bool acceptedTerms = false;
  bool rememberMe = false;

  static const Color gold = Color(0xFFD9AD82);
  static const Color goldLight = Color(0xFFF0C69D);
  static const Color muted = Color(0xFFBDB2A8);

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    registerEmailController.dispose();         
    registerPasswordController.dispose();
    confirmPasswordController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }

  // Switch between Register and Login
  void switchPage(bool login) {
    setState(() {
      isLogin = login;
    });
  }

  void showMessage(String message, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: success
            ? const Color(0xFF356B4B)
            : const Color(0xFF8B493B),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Input decoration
  InputDecoration inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: muted, fontSize: 15),
      prefixIcon: Icon(icon, color: goldLight, size: 23),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white.withOpacity(0.045),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 19),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: BorderSide(color: gold.withOpacity(0.17)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(color: gold, width: 1.3),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(color: Color(0xFFE58D78)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(color: Color(0xFFE58D78), width: 1.3),
      ),
    );
  }

  // Reusable input field
  Widget buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    Widget? suffix,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      decoration: inputDecoration(hint: hint, icon: icon, suffix: suffix),
      validator: validator,
    );
  }

  // REGISTER VALIDATION
  void register() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    if (registerPasswordController.text.length < 8) {
      showMessage('Password must contain at least 8 characters.');
      return;
    }

    if (registerPasswordController.text != confirmPasswordController.text) {
      showMessage('The passwords do not match.');
      return;
    }

    if (!acceptedTerms) {
      showMessage('Please agree to the Terms & Conditions.');
      return;
    }

    // Connect your Django API here.
    showMessage('Details validated successfully!', success: true);
  }

  // LOGIN VALIDATION
  void login() {
    FocusScope.of(context).unfocus();

    if (loginEmailController.text.trim().isEmpty ||
        loginPasswordController.text.isEmpty) {
      showMessage('Please enter your email and password.');
      return;
    }

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
        .hasMatch(loginEmailController.text.trim())) {
      showMessage('Please enter a valid email address.');
      return;
    }

    // Connect your authentication API here.
    showMessage('Login details validated successfully!', success: true);
  }

  // MAIN SCREEN WITH FULL SCREEN BACKGROUND
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17120F),

      body: Stack(
        fit: StackFit.expand,
        children: [
          // FULL SCREEN HOUSE BACKGROUND IMAGE
          Image.asset(
            'assets/64 Villa House Designs That Merge Style with Nature.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),

          // LIGHT DARK OVERLAY
          Container(color: Colors.black.withOpacity(0.20)),

          // PAGE CONTENT
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 700;

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 32 : 16,
                    vertical: 22,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1000),
                      child: Column(
                        children: [
                          buildHero(isWide),

                          Transform.translate(
                            offset: const Offset(0, -24),
                            child: buildAuthCard(isWide),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // SMART HAVEN HERO SECTION
  // Background image is now handled by the main Stack.
  Widget buildHero(bool isWide) {
    return Container(
      height: isWide ? 360 : 430,
      width: double.infinity,
      padding: EdgeInsets.all(isWide ? 42 : 25),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LOGO AND BRAND NAME
          Row(
            children: [
              const Icon(Icons.home_outlined, color: goldLight, size: 48),

              const SizedBox(width: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                      children: [
                        TextSpan(
                          text: 'Smart',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: 'Haven',
                          style: TextStyle(color: goldLight),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 3),

                  const Text(
                    'SMART LIVING. SAFE LIVING.',
                    style: TextStyle(
                      color: Color(0xFFE3D4C8),
                      fontSize: 10,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const Spacer(),

          // MAIN HERO TEXT
          Text.rich(
            TextSpan(
              style: TextStyle(
                color: Colors.white,
                fontSize: isWide ? 42 : 34,
                height: 1.15,
              ),
              children: const [
                TextSpan(text: 'Your '),

                TextSpan(
                  text: 'Smart',
                  style: TextStyle(
                    color: goldLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                TextSpan(text: ' Home,\nOur '),

                TextSpan(
                  text: 'Priority',
                  style: TextStyle(
                    color: goldLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 13),

          const Text(
            'Automate  ·  Secure  ·  Stay Connected',
            style: TextStyle(color: Color(0xFFE4D9CF), fontSize: 14),
          ),
        ],
      ),
    );
  }

  // AUTHENTICATION CARD
  Widget buildAuthCard(bool isWide) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.symmetric(horizontal: isWide ? 62 : 20, vertical: 30),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: gold.withOpacity(0.25)),

        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A221C), Color(0xFF171310)],
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.38),
            blurRadius: 35,
            offset: const Offset(0, 18),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // REGISTER / LOGIN TABS
          Row(
            children: [
              // REGISTER TAB
              Expanded(
                child: GestureDetector(
                  onTap: () => switchPage(false),
                  child: Column(
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          color: !isLogin
                              ? Colors.white
                              : const Color(0xFF92877F),
                          fontSize: 17,
                          fontWeight: !isLogin
                              ? FontWeight.w700
                              : FontWeight.normal,
                        ),
                      ),

                      const SizedBox(height: 14),

                      Container(
                        height: 3,
                        decoration: BoxDecoration(
                          color: !isLogin ? gold : Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 30),

              // LOGIN TAB
              Expanded(
                child: GestureDetector(
                  onTap: () => switchPage(true),
                  child: Column(
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: isLogin
                              ? Colors.white
                              : const Color(0xFF92877F),
                          fontSize: 17,
                          fontWeight: isLogin
                              ? FontWeight.w700
                              : FontWeight.normal,
                        ),
                      ),

                      const SizedBox(height: 14),

                      Container(
                        height: 3,
                        decoration: BoxDecoration(
                          color: isLogin ? gold : Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // SWITCH BETWEEN BOTH FORMS
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: isLogin ? buildLoginForm() : buildRegisterForm(),
          ),
        ],
      ),
    );
  }

  // REGISTER FORM
  Widget buildRegisterForm() {
    return Form(
      key: _formKey,
      child: Column(
        key: const ValueKey('register'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create Your Account',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Join SmartHaven for a smarter and safer home.',
            style: TextStyle(color: Color(0xFFD4B99F), fontSize: 14),
          ),

          const SizedBox(height: 25),

          // FULL NAME
          buildField(
            controller: nameController,
            hint: 'Full Name',
            icon: Icons.person_outline,
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Please enter your name.'
                : null,
          ),

          const SizedBox(height: 13),

          // ADDRESS
          buildField(
            controller: addressController,
            hint: 'Address',
            icon: Icons.home_outlined,
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Please enter your address.'
                : null,
          ),

          const SizedBox(height: 13),

          // PHONE NUMBER
          buildField(
            controller: phoneController,
            hint: 'Phone Number',
            icon: Icons.call_outlined,
            keyboardType: TextInputType.phone,
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Please enter your phone number.'
                : null,
          ),

          const SizedBox(height: 13),

          // EMAIL ADDRESS
          buildField(
            controller: registerEmailController,
            hint: 'Email Address',
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email address.';
              }

              if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                  .hasMatch(value.trim())) {
                return 'Please enter a valid email address.';
              }

              return null;
            },
          ),

          const SizedBox(height: 13),

          // PASSWORD
          buildField(
            controller: registerPasswordController,
            hint: 'Password',
            icon: Icons.lock_outline,
            obscure: obscurePassword,

            suffix: IconButton(
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },

              icon: Icon(
                obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: muted,
              ),
            ),

            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password.';
              }

              if (value.length < 8) {
                return 'Use at least 8 characters.';
              }

              return null;
            },
          ),

          const SizedBox(height: 13),

          // CONFIRM PASSWORD
          buildField(
            controller: confirmPasswordController,
            hint: 'Confirm Password',
            icon: Icons.lock_outline,
            obscure: obscureConfirmPassword,

            suffix: IconButton(
              onPressed: () {
                setState(() {
                  obscureConfirmPassword = !obscureConfirmPassword;
                });
              },

              icon: Icon(
                obscureConfirmPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: muted,
              ),
            ),

            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password.';
              }

              if (value != registerPasswordController.text) {
                return 'Passwords do not match.';
              }

              return null;
            },
          ),

          const SizedBox(height: 16),

          // TERMS AND CONDITIONS
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            activeColor: gold,
            checkColor: const Color(0xFF211811),
            value: acceptedTerms,

            onChanged: (value) {
              setState(() {
                acceptedTerms = value ?? false;
              });
            },

            title: Wrap(
              children: [
                const Text(
                  'I agree to the ',
                  style: TextStyle(color: Color(0xFFE5DDD6), fontSize: 13),
                ),

                GestureDetector(
                  onTap: () {
                    showMessage('Add your Terms & Conditions page here.');
                  },

                  child: const Text(
                    'Terms & Conditions',
                    style: TextStyle(color: goldLight, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // REGISTER BUTTON
          buildActionButton(label: 'Register', onPressed: register),

          const SizedBox(height: 24),

          // LOGIN LINK
          Center(
            child: Column(
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(color: Color(0xFFE8E0D9), fontSize: 14),
                ),

                TextButton(
                  onPressed: () => switchPage(true),
                  child: const Text(
                    'Login here',
                    style: TextStyle(
                      color: goldLight,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const Text(
                  'Your home. Your privacy. Your peace of mind.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF857970), fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // LOGIN FORM
  Widget buildLoginForm() {
    return Column(
      key: const ValueKey('login'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'Login to access your smart home.',
          style: TextStyle(color: Color(0xFFD4B99F), fontSize: 14),
        ),

        const SizedBox(height: 25),

        // EMAIL
        buildField(
          controller: loginEmailController,
          hint: 'Email Address',
          icon: Icons.mail_outline,
          keyboardType: TextInputType.emailAddress,
        ),

        const SizedBox(height: 15),

        // PASSWORD
        buildField(
          controller: loginPasswordController,
          hint: 'Password',
          icon: Icons.lock_outline,
          obscure: obscureLoginPassword,

          suffix: IconButton(
            onPressed: () {
              setState(() {
                obscureLoginPassword = !obscureLoginPassword;
              });
            },

            icon: Icon(
              obscureLoginPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: muted,
            ),
          ),
        ),

        const SizedBox(height: 20),

        // REMEMBER ME AND FORGOT PASSWORD
        Row(
          children: [
            SizedBox(
              width: 25,
              height: 25,
              child: Checkbox(
                value: rememberMe,
                activeColor: gold,
                checkColor: Colors.black,
                side: const BorderSide(color: Colors.white70),

                onChanged: (value) {
                  setState(() {
                    rememberMe = value ?? false;
                  });
                },
              ),
            ),

            const SizedBox(width: 8),

            const Text(
              'Remember Me',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),

            const Spacer(),

            GestureDetector(
              onTap: () {
                showMessage('Password recovery coming soon.');
              },

              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: goldLight,
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 35),

        // LOGIN BUTTON
        buildActionButton(label: 'Login', onPressed: login),

        const SizedBox(height: 55),

        // SECURITY TEXT
        Row(
          children: [
            Expanded(child: Divider(color: gold.withOpacity(0.35))),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Secure. Smart. Together.',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),

            Expanded(child: Divider(color: gold.withOpacity(0.35))),
          ],
        ),

        const SizedBox(height: 35),

        Center(child: Icon(Icons.shield_outlined, size: 60, color: gold)),
      ],
    );
  }

  // REUSABLE GOLD BUTTON
  Widget buildActionButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,

      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          foregroundColor: const Color(0xFF211811),
          backgroundColor: goldLight,
          elevation: 5,
          shape: const StadiumBorder(),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),

            Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),

            const Spacer(),

            Container(
              width: 38,
              height: 38,

              decoration: const BoxDecoration(
                color: Color(0xFF17110C),
                shape: BoxShape.circle,
              ),

              child: const Icon(Icons.arrow_forward, color: goldLight),
            ),
          ],
        ),
      ),
    );
  }
}
