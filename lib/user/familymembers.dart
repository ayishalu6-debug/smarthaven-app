
import 'package:flutter/material.dart';

class FamilyMembersScreen extends StatefulWidget {
  const FamilyMembersScreen({super.key});

  @override
  State<FamilyMembersScreen> createState() => _FamilyMembersScreenState();
}

class FamilyMember {
  final int number;
  String name;
  String relationship;
  bool isActive;

  FamilyMember({
    required this.number,
    String? name,
    this.relationship = 'Household Member',
    this.isActive = true,
  }) : name = name ?? 'User $number';
}

class _FamilyMembersScreenState extends State<FamilyMembersScreen> {
  // SMART HAVEN COLOURS
  static const Color background = Color(0xFF211812);
  static const Color card = Color(0xFF493021);
  static const Color cardLight = Color(0xFF573824);
  static const Color peach = Color(0xFFE8BC8A);
  static const Color cream = Color(0xFFF4E9DC);
  static const Color muted = Color(0xFFB9A99B);
  static const Color red = Color(0xFFFF8278);

  // START WITH TWO MEMBERS
  final List<FamilyMember> members = [
    FamilyMember(number: 1),
    FamilyMember(number: 2),
  ];

  int nextUserNumber = 3;
  bool familyAccess = true;

  // ADD MEMBER
  void addMember() {
    setState(() {
      members.add(FamilyMember(number: nextUserNumber));
      nextUserNumber++;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New family member added'),
        backgroundColor: card,
      ),
    );
  }

  // EDIT MEMBER
  void editMember(FamilyMember member) {
    showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return _EditMemberDialog(
          member: member,
          onSave: (name, relationship, isActive) {
            setState(() {
              member.name = name;
              member.relationship = relationship;
              member.isActive = isActive;
            });
          },
        );
      },
    ).then((saved) {
      if (saved == true && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Member updated successfully'),
            backgroundColor: card,
          ),
        );
      }
    });
  }

  // DELETE MEMBER
  void deleteMember(FamilyMember member) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Delete Member?',
            style: TextStyle(
              color: cream,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to remove ${member.name}?',
            style: const TextStyle(color: muted),
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
                backgroundColor: red,
                foregroundColor: background,
              ),
              onPressed: () {
                setState(() {
                  members.remove(member);
                });

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Member deleted'),
                    backgroundColor: card,
                  ),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // MEMBER CARD
  Widget memberCard(FamilyMember member) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 23,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [cardLight, card],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: peach.withOpacity(0.22)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 31,
            backgroundColor: peach,
            child: const Icon(
              Icons.person,
              color: background,
              size: 34,
            ),
          ),
          const SizedBox(width: 15),

          // MEMBER INFORMATION
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: const TextStyle(
                    color: cream,
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  member.relationship,
                  style: const TextStyle(
                    color: muted,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 13),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: peach.withOpacity(0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: member.isActive
                            ? const Color(0xFF5BE39B)
                            : muted,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        member.isActive ? 'Active' : 'Inactive',
                        style: const TextStyle(
                          color: cream,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // EDIT BUTTON
          _actionButton(
            icon: Icons.edit_outlined,
            color: cream,
            onTap: () => editMember(member),
          ),
          const SizedBox(width: 10),

          // DELETE BUTTON
          _actionButton(
            icon: Icons.delete_outline,
            color: red,
            onTap: () => deleteMember(member),
          ),
        ],
      ),
    );
  }

  // CIRCULAR ACTION BUTTON
  Widget _actionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white.withOpacity(0.06),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          height: 52,
          width: 52,
          child: Icon(
            icon,
            color: color,
            size: 25,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          // TOP BACKGROUND IMAGE
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 500,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/homeintro.jpg',
                  fit: BoxFit.cover,
                ),

                // DARK GRADIENT OVERLAY
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x33000000),
                        Color(0x88211812),
                        Color(0xFF211812),
                      ],
                      stops: [0.0, 0.65, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                20,
                15,
                20,
                25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: cream,
                          size: 21,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Smart',
                              style: TextStyle(
                                color: cream,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'Haven',
                              style: TextStyle(
                                color: peach,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        style: TextStyle(fontSize: 23),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.notifications_none,
                        color: cream,
                        size: 27,
                      ),
                      const SizedBox(width: 15),
                      const CircleAvatar(
                        radius: 23,
                        backgroundColor: peach,
                        child: Icon(
                          Icons.person,
                          color: background,
                          size: 27,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // PAGE TITLE
                  const Text(
                    'Family\nMembers',
                    style: TextStyle(
                      color: cream,
                      fontSize: 37,
                      height: 1.08,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Manage your household members ♡',
                    style: TextStyle(
                      color: muted,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // TOTAL MEMBERS CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 25,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [cardLight, card],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: peach.withOpacity(0.35),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.groups_rounded,
                          color: peach,
                          size: 57,
                        ),
                        const SizedBox(width: 22),
                        Container(
                          height: 60,
                          width: 1,
                          color: peach.withOpacity(0.45),
                        ),
                        const SizedBox(width: 22),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Members',
                              style: TextStyle(
                                color: muted,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${members.length} Members',
                              style: const TextStyle(
                                color: cream,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // MEMBER LIST
                  if (members.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: card,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.people_outline,
                            color: peach,
                            size: 40,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'No family members yet',
                            style: TextStyle(
                              color: cream,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Add a member to get started.',
                            style: TextStyle(color: muted),
                          ),
                        ],
                      ),
                    )
                  else
                    ...members.map(memberCard),

                  const SizedBox(height: 5),

                  // ADD ANOTHER MEMBER
                  SizedBox(
                    width: double.infinity,
                    height: 65,
                    child: OutlinedButton.icon(
                      onPressed: addMember,
                      icon: const Icon(
                        Icons.add,
                        color: peach,
                        size: 28,
                      ),
                      label: const Text(
                        'Add Another Member',
                        style: TextStyle(
                          color: peach,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: peach,
                          width: 1.4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // ACCESS PERMISSIONS
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [cardLight, card],
                      ),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: peach.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.verified_user_outlined,
                          color: peach,
                          size: 45,
                        ),
                        const SizedBox(width: 18),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Access Permissions',
                                style: TextStyle(
                                  color: cream,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 7),
                              Text(
                                'Allow family members to control smart home devices',
                                style: TextStyle(
                                  color: muted,
                                  fontSize: 13,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: familyAccess,
                          activeThumbColor: cream,
                          activeTrackColor: peach,
                          onChanged: (value) {
                            setState(() {
                              familyAccess = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // SAVE CHANGES
                  SizedBox(
                    width: double.infinity,
                    height: 62,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Changes updated successfully!',
                            ),
                            backgroundColor: card,
                          ),
                        );
                      },
                      icon: const Icon(Icons.save_outlined),
                      label: const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: peach,
                        foregroundColor: background,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// EDIT MEMBER DIALOG
class _EditMemberDialog extends StatefulWidget {
  final FamilyMember member;
  final Function(String, String, bool) onSave;

  const _EditMemberDialog({
    required this.member,
    required this.onSave,
  });

  @override
  State<_EditMemberDialog> createState() => _EditMemberDialogState();
}

class _EditMemberDialogState extends State<_EditMemberDialog> {
  static const Color background = Color(0xFF211812);
  static const Color card = Color(0xFF493021);
  static const Color peach = Color(0xFFE8BC8A);
  static const Color cream = Color(0xFFF4E9DC);
  static const Color muted = Color(0xFFB9A99B);

  late final TextEditingController nameController;
  late String relationship;
  late bool isActive;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.member.name,
    );

    relationship = widget.member.relationship;
    isActive = widget.member.isActive;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      labelText: hint,
      labelStyle: const TextStyle(color: muted),
      prefixIcon: Icon(icon, color: peach),
      filled: true,
      fillColor: background,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: peach.withOpacity(0.35),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: peach.withOpacity(0.35),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: peach),
      ),
    );
  }

  void saveMember() {
    final enteredName = nameController.text.trim();

    if (enteredName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a member name'),
        ),
      );
      return;
    }

    widget.onSave(
      enteredName,
      relationship,
      isActive,
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      title: Text(
        'Edit ${widget.member.name}',
        style: const TextStyle(
          color: cream,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 42,
              backgroundColor: peach,
              child: Icon(
                Icons.person,
                color: background,
                size: 45,
              ),
            ),

            const SizedBox(height: 20),

            // EDIT NAME
            TextField(
              controller: nameController,
              style: const TextStyle(color: cream),
              decoration: inputDecoration(
                'Member Name',
                Icons.person_outline,
              ),
            ),

            const SizedBox(height: 18),

            // MEMBER TYPE
            DropdownButtonFormField<String>(
              value: relationship,
              dropdownColor: card,
              style: const TextStyle(color: cream),
              decoration: inputDecoration(
                'Member Type',
                Icons.people_outline,
              ),
              items: const [
                'Household Member',
                'Admin',
                'Guest',
                'Child',
              ].map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    relationship = value;
                  });
                }
              },
            ),

            const SizedBox(height: 18),

            // ACTIVE STATUS
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Active Member',
                style: TextStyle(color: cream),
              ),
              value: isActive,
              activeThumbColor: cream,
              activeTrackColor: peach,
              onChanged: (value) {
                setState(() {
                  isActive = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        // CANCEL
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: muted),
          ),
        ),

        // SAVE
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: peach,
            foregroundColor: background,
          ),
          onPressed: saveMember,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
