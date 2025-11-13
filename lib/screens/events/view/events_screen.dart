import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myshetribe/screens/events/view/event_details_screen.dart';
import 'package:myshetribe/widgets/logo_header.dart';
import 'package:myshetribe/providers/event_provider.dart';
import 'package:myshetribe/models/event_model.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventProvider>(context, listen: false).loadUpcomingEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFB6C8),
      body: SafeArea(
        child: Consumer<EventProvider>(
          builder: (context, eventProvider, child) {
            if (eventProvider.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: const Color(0xFF2C2C2C),
                  strokeWidth: 2,
                ),
              );
            }

            final events = eventProvider.upcomingEvents;
            final featuredEvent = events.isNotEmpty ? events.first : null;
            final upcomingEvents = events.length > 1 ? events.sublist(1) : [];

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Header with Logo
                  LogoHeader(),
                  const SizedBox(height: 20),
                  // Events Title
                  Text(
                    'Events',
                    style: GoogleFonts.poppins(
                       fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2C2C2C),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Featured Event Card
                  if (featuredEvent != null) ...[
                    _buildFeaturedEventCard(featuredEvent),
                    Container(
                       margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                                color: const Color(0xFFFE9CB4),
                                borderRadius: BorderRadius.circular(0),
                              ),
                      child: _buildDescriptionCard(featuredEvent)),
                  ],
                  // const SizedBox(height: 20),
                  // Upcoming Events Section
                  if (upcomingEvents.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFE9CB4),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: upcomingEvents.map((event) => _buildUpcomingEventCard(event)).toList(),
                        ),
                      ),
                    ),
                  const SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDescriptionCard(EventModel event) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFD5A472),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Text(
        event.description,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF2C2C2C),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFeaturedEventCard(EventModel event) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Event Image
        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: const Color(0xFFD4A574),
          ),
          child: event.imageUrl != null
              ? CachedNetworkImage(
                  imageUrl: event.imageUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: const Color(0xFF2C2C2C),
                      strokeWidth: 2,
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/icons/my_events_header_pic.png',
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  'assets/icons/my_events_header_pic.png',
                  fit: BoxFit.cover,
                ),
        ),
        // Overlapping Gold Box with Title and Date
        Positioned(
           left: 0,
        right: 0,
          bottom: 0,
          child: Center(
            child: Container(
                alignment: Alignment.center,
               width: MediaQuery.of(context).size.width*0.7,
               height: 57,
              decoration: BoxDecoration(
                color: const Color(0xFFD5A472),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    event.title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2C2C2C),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    DateFormat('d MMMM yyyy').format(event.eventDate),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2C2C2C),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

 Widget _buildUpcomingEventCard(EventModel event) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailScreen(event: event),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Row(
            children: [
              // Left side - Image (45% width)
              Expanded(
                flex: 45,
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4A574),
                  ),
                  child: event.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: event.imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: const Color(0xFF2C2C2C),
                              strokeWidth: 2,
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/icons/my_brunch_party.png',
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          'assets/icons/my_brunch_party.png',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              // Right side - Gold section with label (55% width)
              Expanded(
                flex: 55,
                child: Container(
                  height: 130,
                  color: const Color(0xFFD4A574),
                  child: Align(
                    alignment: Alignment(0, -0.99),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF000000),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Text(
                        event.title,
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.037,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFD5A472),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}