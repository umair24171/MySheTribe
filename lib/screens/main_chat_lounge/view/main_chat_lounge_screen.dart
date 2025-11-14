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
      'name': 'MyMatch Chat',
      'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
    },
    {
      'name': 'Culture & Heritage Chat',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400',
    },
    {
      'name': 'Entertainment Chat',
      'image': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400',
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
                    // const SizedBox(height: 22),
                    // Access Chats Here Section with Pink Background
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 19),
                      padding: const EdgeInsets.all(22),
                      // decoration: BoxDecoration(
                      //   color: const Color(0xFFFe9cb4),
                      //   borderRadius: BorderRadius.circular(0),
                      // ),
                      child: Column(
                        children: [
                          // Text(
                          //   'Access Chats Here!',
                          //   style: GoogleFonts.poppins(
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.w700,
                          //     color: const Color(0xFF2C2C2C),
                          //   ),
                          // ),
                          // const SizedBox(height: 20),
                          // Group Chat List
                          ...(_groupChats.map((chat) => _buildChatItem(chat)).toList()),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNavBar(),
    );
  }

 Widget _buildChatItem(Map<String, dynamic> chat) {
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatLoungeScreen(
              chatName: chat['name'],
              profileImage: chat['image'],
            ),
          ),
        );
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
                  fontSize: MediaQuery.of(context).size.width*0.026,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2C2C2C),
                ),
              ),
            ),
          ),
          // Dropdown Icon
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
  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3A),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFFB6C8),
        unselectedItemColor: const Color(0xFFFFB6C8),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'My Match',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}