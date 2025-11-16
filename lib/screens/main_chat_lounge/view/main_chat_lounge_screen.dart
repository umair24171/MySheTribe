import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshetribe/screens/main_chat_lounge/view/chats_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';

class MainChatLoungeScreen extends StatefulWidget {
  const MainChatLoungeScreen({Key? key}) : super(key: key);

  @override
  State<MainChatLoungeScreen> createState() => _MainChatLoungeScreenState();
}

class _MainChatLoungeScreenState extends State<MainChatLoungeScreen> {
  int _selectedIndex = 3; // Chat is selected

  final List<Map<String, dynamic>> _groupChats = [
    {
      'name': 'Main Lounge Chat',
      'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
      'hasDropdown': false,
    },
    {
      'name': 'MyMatch Chats',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400',
      'hasDropdown': true,
      'subChats': [
       'Sue Culture',
      'Julie Travel',
      'Rosemary Fitness',
      'Jane Entertainment Match',
      ],
    },
    {
      'name': 'MyGroup Chats',
      'image': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400',
      'hasDropdown': true,
      'subChats': [
        'MyCareer Chat',
        'MyEntertainment Chat',
        'MyEnterpreneur Chat',
        'MyFitness Chat',
        'MyLifeStyle Chat',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    // Logo and Branding Header
                    LogoHeader(),
                    
                    const SizedBox(height: 29),
                    // Main Chat Lounge Title
                    Text(
                      'Access Tribe Chat Lounges',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2C2C2C),
                      ),
                    ),
                    const SizedBox(height: 29),
                    // Background Image Section
                    Container(
                      width: double.infinity,
                      height: 240,
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/icons/main_chat_header.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Access Chats Here Section
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 19),
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        children: [
                          // Group Chat List
                          ...(_groupChats.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> chat = entry.value;
                            return _buildChatItem(chat, index);
                          }).toList()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatItem(Map<String, dynamic> chat, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      padding: const EdgeInsets.all(0),
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: GestureDetector(
        onTap: () {
          if (chat['hasDropdown'] == true) {
            // Show dropdown dialog
            _showSubChatsDialog(
              context: context,
              title: chat['name'],
              subChats: chat['subChats'] ?? [],
              profileImage: chat['image'],
            );
          } else {
            // Navigate directly
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatLoungeScreen(
                  chatName: chat['name'],
                  profileImage: chat['image'],
                ),
              ),
            );
          }
        },
        child: Row(
          children: [
            // Left Side - Full Height Image
            ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.network(
                chat['image'],
                width: 105,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            // Right Side - Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Text(
                  chat['name'],
                  style: GoogleFonts.poppins(
                    fontSize:16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2C2C2C),
                  ),
                ),
              ),
            ),
            // Dropdown Icon
            if (chat['hasDropdown'] == true)
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: const Color(0xFF2C2C2C),
                  size: 30,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showSubChatsDialog({
    required BuildContext context,
    required String title,
    required List<String> subChats,
    required String profileImage,
  }) {
    String? selectedChat;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2C2C2C),
                        ),
                      ),
                    ),
                    
                    // Sub Chats List
                    Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: subChats.map((chat) {
                            return _buildSubChatItem(
                              chat: chat,
                              isSelected: selectedChat == chat,
                              onTap: () {
                                setState(() {
                                  selectedChat = chat;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    
                    // Buttons
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF2C2C2C),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: selectedChat != null
                                  ? () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ChatLoungeScreen(
                                            chatName: selectedChat!,
                                            profileImage: profileImage,
                                          ),
                                        ),
                                      );
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2C2C2C),
                                disabledBackgroundColor: Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: Text(
                                'Done',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: selectedChat != null 
                                      ? Colors.white 
                                      : Colors.grey[600],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSubChatItem({
    required String chat,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                chat,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2C2C2C),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFF2C2C2C),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 14,
                      color: const Color(0xFF2C2C2C),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}