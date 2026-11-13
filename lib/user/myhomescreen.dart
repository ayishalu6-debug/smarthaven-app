
import 'package:flutter/material.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {

  // SMART HAVEN THEME
  static const Color bg = Color(0xFF211812);
  static const Color card = Color(0xFF493021);
  static const Color gold = Color(0xFFE8BC8A);
  static const Color cream = Color(0xFFF4E9DC);
  static const Color muted = Color(0xFFB9A99B);

  // HOUSE IMAGE
  final String houseImage =
      'assets/64 Villa House Designs That Merge Style with Nature.jpg';

  // HOME INFORMATION
  final TextEditingController homeNameController =
      TextEditingController(text: 'Home');

  final TextEditingController addressController =
      TextEditingController();

  String homeType = 'Villa';
  final String homeId = 'SH-10247';

  List<String> selectedRooms = [
    'Bedroom',
    'Bedroom',
    'Bedroom',
    'Kitchen',
    'Living Room',
  ];

  List<String> selectedDevices = [
    'Lights',
    'Fans',
    'Air Conditioner',
    'Smart TV',
  ];

  final List<String> homeTypes = [
    'Apartment',
    'Villa',
    'Independent House',
  ];

  final List<String> availableRooms = [
    'Bedroom',
    'Kitchen',
    'Living Room',
    'Bathroom',
    'Dining Room',
    'Balcony',
    'Study Room',
    'Garage',
  ];

  final List<String> availableDevices = [
    'Lights',
    'Fans',
    'Air Conditioner',
    'Smart TV',
    'Smart Lock',
    'Security Camera',
    'Gas Sensor',
    'Motion Sensor',
    'Smart Curtains',
  ];

  @override
  void dispose() {
    homeNameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  // COMMON INFORMATION CARD
  Widget homeInfoCard({
    required IconData icon,
    required String title,
    required Widget content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF493021),
            Color(0xFF33251D),
          ],
        ),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: gold.withOpacity(0.25),
        ),
      ),
      child: Row(
        children: [

          Container(
            height: 76,
            width: 76,
            decoration: BoxDecoration(
              color: const Color(0xFF573824),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Icon(
              icon,
              color: gold,
              size: 38,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: muted,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 9),

                content,
              ],
            ),
          ),
        ],
      ),
    );
  }

  // TEXT FIELD DESIGN
  Widget textField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(
        color: cream,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: muted,
          fontSize: 15,
        ),
        filled: true,
        fillColor: const Color(0xFF33251D),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: gold.withOpacity(0.35),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: gold,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  // HOME TYPE DROPDOWN
  Widget homeTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: homeType,
      dropdownColor: card,
      iconEnabledColor: gold,
      style: const TextStyle(
        color: cream,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF33251D),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: gold.withOpacity(0.35),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: gold),
        ),
      ),
      items: homeTypes.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            homeType = value;
          });
        }
      },
    );
  }

  // MULTIPLE SELECTION DIALOG
  void showSelectionDialog({
    required String title,
    required List<String> options,
    required List<String> selectedItems,
    required Function(List<String>) onSave,
  }) {

    List<String> temporarySelection =
        List.from(selectedItems);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: card,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              title: Text(
                title,
                style: const TextStyle(
                  color: cream,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: options.map((option) {
                      return CheckboxListTile(
                        value: temporarySelection.contains(option),
                        activeColor: gold,
                        checkColor: bg,
                        title: Text(
                          option,
                          style: const TextStyle(
                            color: cream,
                          ),
                        ),
                        onChanged: (checked) {
                          setDialogState(() {
                            if (checked == true) {
                              temporarySelection.add(option);
                            } else {
                              temporarySelection.remove(option);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
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
                    onSave(temporarySelection);
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // SELECTED ITEMS DISPLAY
  Widget selectionButton({
    required List<String> items,
    required String hint,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF33251D),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: gold.withOpacity(0.35),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                items.isEmpty
                    ? hint
                    : '${items.length} selected: ${items.join(', ')}',
                style: const TextStyle(
                  color: cream,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: gold,
            ),
          ],
        ),
      ),
    );
  }

  // HOME IMAGE AND ID CARD
  Widget homeOverviewCard() {
    return Container(
      height: 195,
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF573824),
            Color(0xFF33251D),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: gold.withOpacity(0.6),
        ),
      ),
      child: Row(
        children: [

          // HOUSE IMAGE
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.asset(
                  houseImage,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFF493021),
                      child: const Center(
                        child: Icon(
                          Icons.home_rounded,
                          color: gold,
                          size: 75,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // HOME ID
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    'Home ID',
                    style: TextStyle(
                      color: muted,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          homeId,
                          style: const TextStyle(
                            color: cream,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Home ID: SH-10247'),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.copy,
                          color: gold,
                          size: 20,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: gold.withOpacity(0.5),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.circle,
                          color: Color(0xFF75E6AC),
                          size: 10,
                        ),
                        SizedBox(width: 7),
                        Text(
                          'Connected',
                          style: TextStyle(
                            color: cream,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SECTION HEADING
  Widget sectionHeading(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 15,
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: cream,
          fontSize: 21,
          fontWeight: FontWeight.bold,
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

    final labels = [
      'Home',
      'Security',
      'Devices',
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF493021),
            Color(0xFF33251D),
          ],
        ),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: gold.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: List.generate(3, (index) {
          return Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icons[index],
                  color: cream,
                  size: 29,
                ),
                const SizedBox(height: 5),
                Text(
                  labels[index],
                  style: const TextStyle(
                    color: muted,
                    fontSize: 13,
                  ),
                ),
              ],
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
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 25),
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
                      Icons.arrow_back,
                      color: gold,
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
                            color: gold,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    style: TextStyle(fontSize: 23),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // PAGE TITLE
              const Text(
                'My Home',
                style: TextStyle(
                  color: cream,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                'Update your home information',
                style: TextStyle(
                  color: muted,
                  fontSize: 17,
                ),
              ),

              Container(
                margin: const EdgeInsets.only(
                  top: 18,
                  bottom: 28,
                ),
                height: 4,
                width: 140,
                decoration: BoxDecoration(
                  color: gold,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),

              // HOME OVERVIEW
              homeOverviewCard(),

              // HOME NAME
              homeInfoCard(
                icon: Icons.home_outlined,
                title: 'Home Name',
                content: textField(
                  controller: homeNameController,
                  hint: 'Enter home name',
                ),
              ),

              // HOME ADDRESS
              homeInfoCard(
                icon: Icons.location_on_outlined,
                title: 'Home Address',
                content: textField(
                  controller: addressController,
                  hint: 'Enter your home address',
                  maxLines: 2,
                ),
              ),

              // HOME TYPE
              homeInfoCard(
                icon: Icons.villa_outlined,
                title: 'Home Type',
                content: homeTypeDropdown(),
              ),

              // ROOMS
              homeInfoCard(
                icon: Icons.meeting_room_outlined,
                title: 'Rooms',
                content: selectionButton(
                  items: selectedRooms,
                  hint: 'Select rooms',
                  onTap: () {
                    showSelectionDialog(
                      title: 'Select Rooms',
                      options: availableRooms,
                      selectedItems: selectedRooms,
                      onSave: (items) {
                        setState(() {
                          selectedRooms = items;
                        });
                      },
                    );
                  },
                ),
              ),

              // CONNECTED DEVICES
              homeInfoCard(
                icon: Icons.wifi,
                title: 'Connected Devices',
                content: selectionButton(
                  items: selectedDevices,
                  hint: 'Select devices',
                  onTap: () {
                    showSelectionDialog(
                      title: 'Connected Devices',
                      options: availableDevices,
                      selectedItems: selectedDevices,
                      onSave: (items) {
                        setState(() {
                          selectedDevices = items;
                        });
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 15),

              // SAVE CHANGES BUTTON
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (homeNameController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a home name'),
                        ),
                      );
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Home information updated successfully!',
                        ),
                        backgroundColor: Color(0xFF493021),
                      ),
                    );
                  },
                  icon: const Icon(Icons.save_outlined),
                  label: const Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gold,
                    foregroundColor: bg,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),

      bottomNavigationBar: bottomNavigation(),
    );
  }
}
