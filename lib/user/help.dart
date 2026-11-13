
import 'package:flutter/material.dart';

void main() {
  runApp(const HelpSupportApp());
}

class HelpSupportApp extends StatelessWidget {
  const HelpSupportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1C1009),
        fontFamily: 'Roboto',
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFF4B77F),
          surface: Color(0xFF382316),
        ),
      ),
      home: const HelpSupportPage(),
    );
  }
}

class HelpSupportPage extends StatefulWidget {
  const HelpSupportPage({super.key});

  @override
  State<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  final TextEditingController searchController =
      TextEditingController();

  String searchText = '';

  final Color cardColor = const Color(0xFF382316);
  final Color accentColor = const Color(0xFFF4B77F);

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // FAQ POPUP
  void showFAQs() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFF382316),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
            side: BorderSide(color: accentColor.withOpacity(0.5)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Icon(Icons.help_outline,
                    size: 55, color: accentColor),
                const SizedBox(height: 10),
                const Text(
                  'FAQs',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Find answers to common questions',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 15),

                // Expandable FAQ questions
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        faqItem(
                          'How do I reset my password?',
                          'Go to Account Settings, select Reset Password, '
                          'and follow the instructions.',
                        ),
                        faqItem(
                          'How can I update my profile?',
                          'Open your profile settings and edit your '
                          'personal information.',
                        ),
                        faqItem(
                          'Why is my account suspended?',
                          'Your account may be suspended due to a '
                          'security or policy issue. Contact support '
                          'for assistance.',
                        ),
                        faqItem(
                          'How do I contact support?',
                          'Select Live Support to chat with our '
                          'support team.',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                closeButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget faqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF493020),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ExpansionTile(
        iconColor: accentColor,
        collapsedIconColor: accentColor,
        title: Text(
          question,
          style: const TextStyle(fontSize: 14),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 15),
            child: Text(
              answer,
              style: const TextStyle(
                color: Colors.white70,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ACCOUNT HELP POPUP
  void showAccountHelp() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Icon(
                  Icons.verified_user_outlined,
                  size: 55,
                  color: accentColor,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Account Help',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Manage your account related issues',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 20),

                accountOption(
                  context,
                  Icons.lock_reset,
                  'Reset Password',
                  'Follow the password reset process to '
                      'securely update your password.',
                ),
                accountOption(
                  context,
                  Icons.person_outline,
                  'Update Profile',
                  'You can update your profile information '
                      'from your account settings.',
                ),
                accountOption(
                  context,
                  Icons.settings_outlined,
                  'Account Settings',
                  'Manage your account preferences and settings.',
                ),
                accountOption(
                  context,
                  Icons.delete_outline,
                  'Delete Account',
                  'Contact support if you want to request '
                      'account deletion.',
                ),

                const SizedBox(height: 15),
                closeButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget accountOption(
    BuildContext dialogContext,
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        color: const Color(0xFF493020),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        leading: Icon(icon, color: accentColor),
        title: Text(title, style: const TextStyle(fontSize: 14)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pop(dialogContext);
          showInformation(title, description);
        },
      ),
    );
  }

  void showInformation(String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardColor,
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: TextStyle(color: accentColor)),
          ),
        ],
      ),
    );
  }

  // LIVE SUPPORT POPUP
  void showLiveSupport() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Icon(
                  Icons.support_agent,
                  size: 60,
                  color: accentColor,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Live Support',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Chat with our support team',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 12,
                    ),
                    const SizedBox(width: 7),
                    const Text('Online'),
                  ],
                ),
                const SizedBox(height: 22),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    openChat();
                  },
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text('Start Chat'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // CHAT WINDOW DEMO
  void openChat() {
    final messageController = TextEditingController();
    final List<String> messages = [
      'Welcome! How can we help you today?'
    ];

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setChatState) {
            return Dialog(
              backgroundColor: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: SizedBox(
                  height: 390,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.support_agent, color: accentColor),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'Support Chat',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              messageController.dispose();
                              Navigator.pop(dialogContext);
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white24),
                      Expanded(
                        child: ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: index == 0
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 6),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: index == 0
                                      ? const Color(0xFF493020)
                                      : const Color(0xFF98643D),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(messages[index]),
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: messageController,
                              decoration: InputDecoration(
                                hintText: 'Type your message...',
                                filled: true,
                                fillColor: const Color(0xFF493020),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send, color: accentColor),
                            onPressed: () {
                              final message =
                                  messageController.text.trim();

                              if (message.isNotEmpty) {
                                setChatState(() {
                                  messages.add(message);
                                });
                                messageController.clear();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).then((_) {
      messageController.dispose();
    });
  }

  // CLOSE BUTTON
  Widget closeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () => Navigator.pop(context),
        child: const Text(
          'Close',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // MAIN PAGE CARD
  Widget helpCard(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: Colors.white10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFF53351F),
          child: Icon(icon, color: accentColor, size: 28),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            subtitle,
            style: const TextStyle(color: Colors.white60),
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'title': 'FAQs',
        'subtitle': 'Find answers to common questions',
        'icon': Icons.menu_book_outlined,
        'action': showFAQs,
      },
      {
        'title': 'Account Help',
        'subtitle': 'Manage your account',
        'icon': Icons.verified_user_outlined,
        'action': showAccountHelp,
      },
      {
        'title': 'Live Support',
        'subtitle': 'Chat with our support team',
        'icon': Icons.support_agent,
        'action': showLiveSupport,
      },
    ];

    final filteredItems = items.where((item) {
      final title = item['title'].toString().toLowerCase();
      final subtitle = item['subtitle'].toString().toLowerCase();

      return title.contains(searchText) ||
          subtitle.contains(searchText);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1009),
        elevation: 0,
        title: const Text(
          'Help & Support',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            Center(
              child: Icon(
                Icons.question_answer_outlined,
                size: 95,
                color: accentColor,
              ),
            ),

            const SizedBox(height: 15),

            const Center(
              child: Text(
                'Need help?',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 8),

            const Center(
              child: Text(
                'Find answers or get support from us.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // SEARCH BAR
            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase().trim();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for help...',
                prefixIcon: Icon(
                  Icons.search,
                  color: accentColor,
                ),
                suffixIcon: searchText.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            searchText = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              '▦  Quick Help',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            ...filteredItems
                .where((item) => item['title'] != 'Live Support')
                .map((item) {
              return helpCard(
                item['icon'] as IconData,
                item['title'] as String,
                item['subtitle'] as String,
                item['action'] as VoidCallback,
              );
            }),

            const SizedBox(height: 15),

            const Divider(color: Colors.white24),

            const SizedBox(height: 20),

            const Text(
              '♧  Support',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            ...filteredItems
                .where((item) => item['title'] == 'Live Support')
                .map((item) {
              return helpCard(
                item['icon'] as IconData,
                item['title'] as String,
                item['subtitle'] as String,
                item['action'] as VoidCallback,
              );
            }),

            if (filteredItems.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Text(
                    'No help topics found.',
                    style: TextStyle(color: Colors.white60),
                  ),
                ),
              ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                border: Border.all(color: accentColor.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.white70),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Still need help?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Check our support center for more information.',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
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
