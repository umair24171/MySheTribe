import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:myshetribe_admin/providers/content_management_provider.dart';
import 'package:myshetribe_admin/models/event_model.dart';
import 'package:intl/intl.dart';

class EventsManagementScreen extends StatelessWidget {
  const EventsManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Events Management',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3A3A3A),
                ),
              ),
              Row(
                children: [
                  Consumer<ContentManagementProvider>(
                    builder: (context, provider, child) {
                      return IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: provider.isLoading
                            ? null
                            : () => provider.loadEvents(),
                        tooltip: 'Refresh',
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Event creation form - to be implemented'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: Text('Create Event', style: GoogleFonts.poppins()),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          Consumer<ContentManagementProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (provider.events.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'No events found',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.all(
                          const Color(0xFF3A3A3A)),
                      columns: [
                        DataColumn(
                          label: Text('Title',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        DataColumn(
                          label: Text('City',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        DataColumn(
                          label: Text('Event Date',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        DataColumn(
                          label: Text('Category',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        DataColumn(
                          label: Text('Price',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        DataColumn(
                          label: Text('Attendees',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        DataColumn(
                          label: Text('Active',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        DataColumn(
                          label: Text('Actions',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                      rows: provider.events.map((event) {
                        return DataRow(
                          cells: [
                            DataCell(
                              SizedBox(
                                width: 200,
                                child: Text(event.title,
                                    style: GoogleFonts.poppins(),
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            DataCell(Text(event.city,
                                style: GoogleFonts.poppins())),
                            DataCell(Text(
                              DateFormat('MMM dd, yyyy').format(event.eventDate),
                              style: GoogleFonts.poppins(),
                            )),
                            DataCell(Text(event.category,
                                style: GoogleFonts.poppins())),
                            DataCell(Text(
                              event.price != null
                                  ? 'AED ${event.price!.toStringAsFixed(2)}'
                                  : 'Free',
                              style: GoogleFonts.poppins(),
                            )),
                            DataCell(Text(
                              '${event.attendeeIds.length}/${event.maxAttendees}',
                              style: GoogleFonts.poppins(),
                            )),
                            DataCell(
                              Icon(
                                event.isActive ? Icons.check_circle : Icons.cancel,
                                color: event.isActive ? Colors.green : Colors.red,
                                size: 20,
                              ),
                            ),
                            DataCell(
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.info_outline,
                                        color: Colors.blue),
                                    onPressed: () =>
                                        _showEventDetails(context, event),
                                    tooltip: 'View Details',
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => _showDeleteDialog(
                                        context, event, provider),
                                    tooltip: 'Delete Event',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showEventDetails(BuildContext context, EventModel event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Event Details', style: GoogleFonts.poppins()),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Title', event.title),
              _buildDetailRow('Description', event.description),
              _buildDetailRow('Location', event.location),
              _buildDetailRow('City', event.city),
              _buildDetailRow(
                'Event Date',
                DateFormat('MMM dd, yyyy HH:mm').format(event.eventDate),
              ),
              _buildDetailRow('Category', event.category),
              _buildDetailRow(
                'Price',
                event.price != null
                    ? 'AED ${event.price!.toStringAsFixed(2)}'
                    : 'Free',
              ),
              _buildDetailRow(
                'Attendees',
                '${event.attendeeIds.length}/${event.maxAttendees}',
              ),
              _buildDetailRow('Active', event.isActive ? 'Yes' : 'No'),
              _buildDetailRow(
                'Created',
                DateFormat('MMM dd, yyyy HH:mm').format(event.createdAt),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFF3A3A3A),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    EventModel event,
    ContentManagementProvider provider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Event', style: GoogleFonts.poppins()),
        content: Text(
          'Are you sure you want to delete "${event.title}"? This action cannot be undone.',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.poppins()),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              bool success = await provider.deleteEvent(event.id);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Event deleted successfully'
                          : 'Failed to delete event',
                    ),
                    backgroundColor: success ? Colors.green : Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Delete', style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }
}
