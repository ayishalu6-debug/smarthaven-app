import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // SMART HAVEN THEME
  static const Color bg = Color(0xFF211812);
  static const Color card = Color(0xFF493021);
  static const Color gold = Color(0xFFE8BC8A);
  static const Color cream = Color(0xFFF4E9DC);
  static const Color muted = Color(0xFFB9A99B);

  // USER DETAILS
  String userName = "User";
  String email = "user@gmail.com";
  String phone = "+91 98765 43210";
  String gender = "Female";

  DateTime? dateOfBirth = DateTime(2003, 7, 17);

  int get userAge {
    if (dateOfBirth == null) return 0;

    final today = DateTime.now();
    int age = today.year - dateOfBirth!.year;

    if (today.month < dateOfBirth!.month ||
        (today.month == dateOfBirth!.month &&
            today.day < dateOfBirth!.day)) {
      age--;
    }

    return age;
  }

  String get formattedDate {
    if (dateOfBirth == null) return "Select date";

    return "${dateOfBirth!.day.toString().padLeft(2, '0')} "
        "${_monthName(dateOfBirth!.month)} ${dateOfBirth!.year}";
  }

  String _monthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }

  // EDIT TEXT INFORMATION
  Future<void> editText({
    required String title,
    required String currentValue,
    required Function(String) onSave,
    TextInputType keyboardType = TextInputType.text,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return EditTextDialog(
          title: title,
          currentValue: currentValue,
          keyboardType: keyboardType,
          backgroundColor: card,
          textColor: cream,
          hintColor: muted,
          accentColor: gold,
          onSave: onSave,
        );
      },
    );
  }

  // SELECT GENDER
  void selectGender() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            "Select Gender",
            style: TextStyle(color: cream, fontSize: 18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ["Male", "Female", "Other"].map((value) {
              return RadioListTile<String>(
                dense: true,
                contentPadding: EdgeInsets.zero,
                value: value,
                groupValue: gender,
                activeColor: gold,
                title: Text(
                  value,
                  style: const TextStyle(color: cream, fontSize: 14),
                ),
                onChanged: (selected) {
                  if (selected != null) {
                    setState(() {
                      gender = selected;
                    });
                    Navigator.pop(dialogContext);
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  // SELECT DATE OF BIRTH
  Future<void> selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: dateOfBirth ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      helpText: "SELECT DATE OF BIRTH",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: gold,
              onPrimary: bg,
              surface: card,
              onSurface: cream,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        dateOfBirth = selectedDate;
      });
    }
  }

  // INFORMATION CARD
  Widget informationCard({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF493021), Color(0xFF33251D)],
        ),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: gold.withOpacity(0.2)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(19),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 11,
          ),
          child: Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF573824),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: gold, size: 27),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: muted,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(
                        color: cream,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: cream,
                size: 23,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // BOTTOM NAVIGATION
  Widget bottomNavigation() {
    final icons = [
      Icons.home_rounded,
      Icons.shield_outlined,
      Icons.grid_view_rounded,
    ];

    final labels = ["Home", "Security", "Devices"];

    return Container(
      margin: const EdgeInsets.fromLTRB(14, 5, 14, 10),
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF493021), Color(0xFF33251D)],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: gold.withOpacity(0.3)),
      ),
      child: Row(
        children: List.generate(3, (index) {
          return Expanded(
            child: InkWell(
              onTap: () {
                // Connect your existing navigation here.
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icons[index], color: cream, size: 23),
                  const SizedBox(height: 3),
                  Text(
                    labels[index],
                    style: const TextStyle(
                      color: muted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 35,
                      minHeight: 35,
                    ),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: gold,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text.rich(
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
                    style: TextStyle(fontSize: 21),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // PAGE TITLE
              const Text(
                "User Profile",
                style: TextStyle(
                  color: cream,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "Your personal information",
                style: TextStyle(color: muted, fontSize: 14),
              ),

              Container(
                margin: const EdgeInsets.only(top: 13, bottom: 20),
                height: 3,
                width: 110,
                decoration: BoxDecoration(
                  color: gold,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),

              // PROFILE AVATAR
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 105,
                          width: 105,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9C2B1),
                            shape: BoxShape.circle,
                            border: Border.all(color: gold, width: 2),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 72,
                            color: Color(0xFF513A2C),
                          ),
                        ),

                        Positioned(
                          bottom: 1,
                          right: 0,
                          child: Container(
                            height: 33,
                            width: 33,
                            decoration: const BoxDecoration(
                              color: Color(0xFF493021),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: gold,
                              size: 17,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Text(
                      userName,
                      style: const TextStyle(
                        color: cream,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      email,
                      style: const TextStyle(
                        color: muted,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      dateOfBirth == null
                          ? "Age not set"
                          : "$userAge years old",
                      style: const TextStyle(
                        color: gold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // PERSONAL INFORMATION
              informationCard(
                icon: Icons.person_outline,
                title: "Full Name",
                value: userName,
                onTap: () {
                  editText(
                    title: "Full Name",
                    currentValue: userName,
                    onSave: (value) {
                      setState(() {
                        userName = value;
                      });
                    },
                  );
                },
              ),

              informationCard(
                icon: Icons.email_outlined,
                title: "Email Address",
                value: email,
                onTap: () {
                  editText(
                    title: "Email Address",
                    currentValue: email,
                    keyboardType: TextInputType.emailAddress,
                    onSave: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  );
                },
              ),

              informationCard(
                icon: Icons.phone_outlined,
                title: "Phone Number",
                value: phone,
                onTap: () {
                  editText(
                    title: "Phone Number",
                    currentValue: phone,
                    keyboardType: TextInputType.phone,
                    onSave: (value) {
                      setState(() {
                        phone = value;
                      });
                    },
                  );
                },
              ),

              informationCard(
                icon: Icons.calendar_month_outlined,
                title: "Date of Birth",
                value: formattedDate,
                onTap: selectDate,
              ),

              informationCard(
                icon: Icons.wc_outlined,
                title: "Gender",
                value: gender,
                onTap: selectGender,
              ),

              const SizedBox(height: 7),

              // SAVE CHANGES
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Profile updated successfully!"),
                        backgroundColor: Color(0xFF493021),
                      ),
                    );
                  },
                  icon: const Icon(Icons.save_outlined, size: 20),
                  label: const Text(
                    "Save Changes",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gold,
                    foregroundColor: bg,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigation(),
    );
  }
}

class EditTextDialog extends StatefulWidget {
  final String title;
  final String currentValue;
  final TextInputType keyboardType;
  final Color backgroundColor;
  final Color textColor;
  final Color hintColor;
  final Color accentColor;
  final Function(String) onSave;

  const EditTextDialog({
    super.key,
    required this.title,
    required this.currentValue,
    required this.keyboardType,
    required this.backgroundColor,
    required this.textColor,
    required this.hintColor,
    required this.accentColor,
    required this.onSave,
  });

  @override
  State<EditTextDialog> createState() => _EditTextDialogState();
}

class _EditTextDialogState extends State<EditTextDialog> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.currentValue);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      title: Text(
        "Edit ${widget.title}",
        style: TextStyle(
          color: widget.textColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      content: TextField(
        controller: controller,
        keyboardType: widget.keyboardType,
        style: TextStyle(
          color: widget.textColor,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: "Enter ${widget.title}",
          hintStyle: TextStyle(color: widget.hintColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.accentColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.accentColor),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "Cancel",
            style: TextStyle(color: widget.hintColor),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.accentColor,
            foregroundColor: widget.backgroundColor,
          ),
          onPressed: () {
            final value = controller.text.trim();

            if (value.isEmpty) return;

            widget.onSave(value);
            Navigator.of(context).pop();
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}