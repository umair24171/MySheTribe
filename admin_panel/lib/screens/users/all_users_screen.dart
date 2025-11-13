import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:myshetribe_admin/providers/user_management_provider.dart';
import 'package:myshetribe_admin/models/user_model.dart';
import 'package:intl/intl.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({Key? key}) : super(key: key);

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  String _searchQuery = '';
  VerificationStatus? _filterStatus;

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
                'All Users',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3A3A3A),
                ),
              ),
              Consumer<UserManagementProvider>(
                builder: (context, provider, child) {
                  return IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: provider.isLoading
                        ? null
                        : () => provider.loadAllUsers(),
                    tooltip: 'Refresh',
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Search and Filter
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by name or email...',
                    hintStyle: GoogleFonts.poppins(),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              DropdownButton<VerificationStatus?>(
                value: _filterStatus,
                hint: Text('Filter by Status', style: GoogleFonts.poppins()),
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: Text('All Statuses', style: GoogleFonts.poppins()),
                  ),
                  DropdownMenuItem(
                    value: VerificationStatus.pending,
                    child: Text('Pending', style: GoogleFonts.poppins()),
                  ),
                  DropdownMenuItem(
                    value: VerificationStatus.underReview,
                    child: Text('Under Review', style: GoogleFonts.poppins()),
                  ),
                  DropdownMenuItem(
                    value: VerificationStatus.approved,
                    child: Text('Approved', style: GoogleFonts.poppins()),
                  ),
                  DropdownMenuItem(
                    value: VerificationStatus.rejected,
                    child: Text('Rejected', style: GoogleFonts.poppins()),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _filterStatus = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          Consumer<UserManagementProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              List<UserModel> filteredUsers = provider.allUsers.where((user) {
                bool matchesSearch = user.fullName
                        .toLowerCase()
                        .contains(_searchQuery) ||
                    user.email.toLowerCase().contains(_searchQuery);

                bool matchesFilter =
                    _filterStatus == null || user.verificationStatus == _filterStatus;

                return matchesSearch && matchesFilter;
              }).toList();

              if (filteredUsers.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      'No users found',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
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
                          label: Text(
                            'Full Name',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Email',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Phone',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'City',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Status',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Registered',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Active',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Actions',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                      rows: filteredUsers.map((user) {
                        return DataRow(
                          cells: [
                            DataCell(Text(user.fullName,
                                style: GoogleFonts.poppins())),
                            DataCell(Text(user.email,
                                style: GoogleFonts.poppins())),
                            DataCell(Text(user.phoneNumber,
                                style: GoogleFonts.poppins())),
                            DataCell(Text(user.city ?? 'N/A',
                                style: GoogleFonts.poppins())),
                            DataCell(_buildStatusChip(user.verificationStatus)),
                            DataCell(Text(
                              DateFormat('MMM dd, yyyy').format(user.createdAt),
                              style: GoogleFonts.poppins(),
                            )),
                            DataCell(
                              Switch(
                                value: user.isActive,
                                onChanged: (value) {
                                  provider.updateUserStatus(user.uid, value);
                                },
                                activeColor: Colors.green,
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
                                        _showUserDetails(context, user),
                                    tooltip: 'View Details',
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () =>
                                        _showDeleteDialog(context, user, provider),
                                    tooltip: 'Delete User',
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

  Widget _buildStatusChip(VerificationStatus status) {
    Color color;
    switch (status) {
      case VerificationStatus.pending:
        color = Colors.orange;
        break;
      case VerificationStatus.underReview:
        color = Colors.blue;
        break;
      case VerificationStatus.approved:
        color = Colors.green;
        break;
      case VerificationStatus.rejected:
        color = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        status.toString().split('.').last,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  void _showUserDetails(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('User Details', style: GoogleFonts.poppins()),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Full Name', user.fullName),
              _buildDetailRow('Email', user.email),
              _buildDetailRow('Phone', user.phoneNumber),
              _buildDetailRow('City', user.city ?? 'N/A'),
              _buildDetailRow('Nationality', user.nationality ?? 'N/A'),
              _buildDetailRow('Age Range', user.ageRange ?? 'N/A'),
              _buildDetailRow('Language', user.language ?? 'N/A'),
              _buildDetailRow('Profession', user.profession ?? 'N/A'),
              _buildDetailRow(
                'Interests',
                user.interests.isEmpty ? 'None' : user.interests.join(', '),
              ),
              if (user.bio != null) _buildDetailRow('Bio', user.bio!),
              _buildDetailRow('Status', user.verificationStatusString),
              _buildDetailRow(
                'Registered',
                DateFormat('MMM dd, yyyy HH:mm').format(user.createdAt),
              ),
              _buildDetailRow('Active', user.isActive ? 'Yes' : 'No'),
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
    UserModel user,
    UserManagementProvider provider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete User', style: GoogleFonts.poppins()),
        content: Text(
          'Are you sure you want to delete ${user.fullName}? This action cannot be undone.',
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
              bool success = await provider.deleteUser(user.uid);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'User deleted successfully'
                          : 'Failed to delete user',
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
