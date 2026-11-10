import 'package:flutter/material.dart';





class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;

  static const Color gold = Color(0xFFD9AD82);
  static const Color goldLight = Color(0xFFF0C69D);
  static const Color muted = Color(0xFFBDB2A8);

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _required(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your $label.';
    }
    return null;
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: muted, fontSize: 15),
      prefixIcon: Icon(icon, color: goldLight, size: 22),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
    String? Function(String?)? validator,
    bool obscureText = false,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      decoration: _inputDecoration(hint: hint, icon: icon, suffix: suffix),
      validator: validator ?? (value) => _required(value, label),
    );
  }

  void _register() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text.length < 8) {
      _showMessage('Password must contain at least 8 characters.');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showMessage('The passwords do not match.');
      return;
    }

    if (!_acceptedTerms) {
      _showMessage('Please agree to the Terms & Conditions.');
      return;
    }

    // Connect this form to your Django API later.
    _showMessage('Details validated successfully!', isSuccess: true);
  }

  void _showMessage(String message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess
            ? const Color(0xFF356B4B)
            : const Color(0xFF8B493B),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.9, -0.9),
            radius: 1.25,
            colors: [Color(0xFF493324), Color(0xFF17120F)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 700;

              return Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 32 : 16,
                    vertical: 22,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: Column(
                      children: [
                        _buildHero(isWide),
                        Transform.translate(
                          offset: const Offset(0, -24),
                          child: _buildRegistrationCard(isWide),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHero(bool isWide) {
    return Container(
      height: isWide ? 360 : 330,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27),
        border: Border.all(color: gold.withOpacity(0.2)),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=1800&q=85',
          ),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(isWide ? 42 : 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              const Color(0xFF17120F).withOpacity(0.97),
              const Color(0xFF17120F).withOpacity(0.76),
              const Color(0xFF17120F).withOpacity(0.12),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          letterSpacing: -0.8,
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
            Text.rich(
              TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isWide ? 42 : 34,
                  height: 1.15,
                  fontWeight: FontWeight.w400,
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
      ),
    );
  }

  Widget _buildRegistrationCard(bool isWide) {
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
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 40),
                TextButton(
                  onPressed: () {
                    _showMessage('Login page will be added next.');
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Color(0xFF92877F), fontSize: 16),
                  ),
                ),
              ],
            ),
            Container(
              width: 105,
              height: 3,
              margin: const EdgeInsets.only(top: 2, bottom: 27),
              decoration: BoxDecoration(
                color: gold,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Text(
              'Create Your Account',
              style: TextStyle(
                fontSize: isWide ? 32 : 27,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.7,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Join SmartHaven for a smarter and safer home.',
              style: TextStyle(color: Color(0xFFD4B99F), fontSize: 14),
            ),
            const SizedBox(height: 25),

            _buildTextField(
              controller: _nameController,
              hint: 'Full Name',
              icon: Icons.person_outline,
              label: 'name',
            ),
            const SizedBox(height: 13),

            _buildTextField(
              controller: _addressController,
              hint: 'Address',
              icon: Icons.home_outlined,
              label: 'address',
            ),
            const SizedBox(height: 13),

            _buildTextField(
              controller: _phoneController,
              hint: 'Phone Number',
              icon: Icons.call_outlined,
              label: 'phone number',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 13),

            _buildTextField(
              controller: _emailController,
              hint: 'Email Address',
              icon: Icons.mail_outline,
              label: 'email address',
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

            _buildTextField(
              controller: _passwordController,
              hint: 'Password',
              icon: Icons.lock_outline,
              label: 'password',
              obscureText: _obscurePassword,
              suffix: IconButton(
                tooltip: _obscurePassword ? 'Show password' : 'Hide password',
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: muted,
                  size: 21,
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

            _buildTextField(
              controller: _confirmPasswordController,
              hint: 'Confirm Password',
              icon: Icons.lock_outline,
              label: 'confirm password',
              obscureText: _obscureConfirmPassword,
              textInputAction: TextInputAction.done,
              suffix: IconButton(
                tooltip: _obscureConfirmPassword
                    ? 'Show password'
                    : 'Hide password',
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: muted,
                  size: 21,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password.';
                }

                if (value != _passwordController.text) {
                  return 'Passwords do not match.';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              activeColor: gold,
              checkColor: const Color(0xFF211811),
              value: _acceptedTerms,
              onChanged: (value) {
                setState(() {
                  _acceptedTerms = value ?? false;
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
                      _showMessage('Add your Terms & Conditions page here.');
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

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF211811),
                  backgroundColor: goldLight,
                  elevation: 5,
                  shape: const StadiumBorder(),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.arrow_forward, size: 21),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Center(
              child: Column(
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(color: Color(0xFFE8E0D9), fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      _showMessage('Login page will be added next.');
                    },
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
                    style: TextStyle(color: Color(0xFF857970), fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
