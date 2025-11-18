import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatLoungeScreen extends StatefulWidget {
  final String chatName;
  final String profileImage;

  const ChatLoungeScreen({
    Key? key,
    required this.chatName,
    required this.profileImage,
  }) : super(key: key);

  @override
  State<ChatLoungeScreen> createState() => _ChatLoungeScreenState();
}

class _ChatLoungeScreenState extends State<ChatLoungeScreen> {
  int _selectedIndex = 3; // Chat is selected
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello from Myshe Tribe Team',
      'isMe': false,
      'isSystem': true,
    },
    {
      'text': 'Hello this is Sarah I just joined.',
      'isMe': true,
      'isSystem': false,
    },
    {
      'text': 'Welcome Sarah',
      'isMe': false,
      'isSystem': true,
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      body: Column(
        children: [
          // Custom App Bar
          Container(
            color: const Color(0xFF3C3C3C),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Row(
                  children: [
                    // Profile Photo
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFFCC66),
                        image: DecorationImage(
                          image: AssetImage('assets/icons/chat_image.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Chat Name
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MySheTribe',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFFB6F92),
                            ),
                          ),
                          Text(
                            widget.chatName,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFFFB6F92),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Action Icons
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.videocam,
                       color: const Color(0xFFFB6F92),
                        size: 35,
                      ),
                    ),
                    SizedBox(width: 10,),
                     Image.asset('assets/icons/audio_call.png',height: 25,width: 25, color: const Color(0xFFFB6F92),),
                  ],
                ),
              ),
            ),
          ),
          // Messages Area
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          // Input Field Area
          Container(
            color: const Color(0xFFFFB6C8),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  // Text Input Field
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: _messageController,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: const Color(0xFF2C2C2C),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Send Button
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2C2C2C),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (_messageController.text.trim().isNotEmpty) {
                          // Handle send message
                          _messageController.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Color(0xFFFFB6C8),
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isMe = message['isMe'];
    final isSystem = message['isSystem'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Align(
        alignment: isMe ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: isMe
                ? const Color(0xFFFFD4E0) // Light pink for user messages
                : Colors.white, // White for system/other messages
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            message['text'],
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2C2C2C),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.favorite_outline, 'My Match', 0),
              _buildNavItem(Icons.event_outlined, 'Events', 1),
              _buildNavItem(Icons.home, 'Home', 2),
              _buildNavItem(Icons.chat_bubble_outline, 'Chat', 3),
              _buildNavItem(Icons.person_outline, 'Profile', 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFB6C8) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : const Color(0xFFFFB6C8),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFFFFB6C8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}