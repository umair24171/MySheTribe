import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:myshetribe_admin/providers/content_management_provider.dart';
import 'package:myshetribe_admin/models/tribe_model.dart';
import 'package:intl/intl.dart';

class TribesManagementScreen extends StatelessWidget {
  const TribesManagementScreen({Key? key}) : super(key: key);

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
                'Tribes Management',
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
                            : () => provider.loadTribes(),
                        tooltip: 'Refresh',
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tribe creation form - to be implemented'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: Text('Create Tribe', style: GoogleFonts.poppins()),
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

              if (provider.tribes.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.groups, size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'No tribes found',
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
                          label: Text('Name',
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
                          label: Text('Members',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        DataColumn(
                          label: Text('Activity Score',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        DataColumn(
                          label: Text('Interests',
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
                      rows: provider.tribes.map((tribe) {
                        return DataRow(
                          cells: [
                            DataCell(
                              SizedBox(
                                width: 200,
                                child: Text(tribe.name,
                                    style: GoogleFonts.poppins(),
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            DataCell(Text(tribe.city,
                                style: GoogleFonts.poppins())),
                            DataCell(Text(
                              tribe.memberCount.toString(),
                              style: GoogleFonts.poppins(),
                            )),
                            DataCell(Text(
                              tribe.activityScore.toStringAsFixed(2),
                              style: GoogleFonts.poppins(),
                            )),
                            DataCell(
                              SizedBox(
                                width: 150,
                                child: Text(
                                  tribe.interests.take(2).join(', '),
                                  style: GoogleFonts.poppins(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              Icon(
                                tribe.isActive ? Icons.check_circle : Icons.cancel,
                                color: tribe.isActive ? Colors.green : Colors.red,
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
                                        _showTribeDetails(context, tribe),
                                    tooltip: 'View Details',
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => _showDeleteDialog(
                                        context, tribe, provider),
                                    tooltip: 'Delete Tribe',
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

  void _showTribeDetails(BuildContext context, TribeModel tribe) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tribe Details', style: GoogleFonts.poppins()),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Name', tribe.name),
              _buildDetailRow('Description', tribe.description),
              _buildDetailRow('City', tribe.city),
              _buildDetailRow('Members', tribe.memberCount.toString()),
              _buildDetailRow(
                  'Activity Score', tribe.activityScore.toStringAsFixed(2)),
              _buildDetailRow(
                'Interests',
                tribe.interests.isEmpty ? 'None' : tribe.interests.join(', '),
              ),
              _buildDetailRow(
                'Tags',
                tribe.tags.isEmpty ? 'None' : tribe.tags.join(', '),
              ),
              _buildDetailRow('Active', tribe.isActive ? 'Yes' : 'No'),
              _buildDetailRow(
                'Created',
                DateFormat('MMM dd, yyyy HH:mm').format(tribe.createdAt),
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
    TribeModel tribe,
    ContentManagementProvider provider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Tribe', style: GoogleFonts.poppins()),
        content: Text(
          'Are you sure you want to delete "${tribe.name}"? This action cannot be undone.',
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
              bool success = await provider.deleteTribe(tribe.id);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Tribe deleted successfully'
                          : 'Failed to delete tribe',
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
