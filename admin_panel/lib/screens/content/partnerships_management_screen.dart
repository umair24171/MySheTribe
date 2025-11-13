import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:myshetribe_admin/providers/content_management_provider.dart';
import 'package:myshetribe_admin/models/partnership_offer_model.dart';
import 'package:intl/intl.dart';

class PartnershipsManagementScreen extends StatelessWidget {
  const PartnershipsManagementScreen({Key? key}) : super(key: key);

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
                'Partnership Offers Management',
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
                            : () => provider.loadPartnershipOffers(),
                        tooltip: 'Refresh',
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Partnership creation form - to be implemented'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: Text('Create Offer', style: GoogleFonts.poppins()),
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

              if (provider.partnershipOffers.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.card_giftcard,
                            size: 64, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'No partnership offers found',
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
                          label: Text('Partner',
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
                          label: Text('Discount',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        DataColumn(
                          label: Text('Code',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        DataColumn(
                          label: Text('Usage',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        DataColumn(
                          label: Text('Expiry',
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
                      rows: provider.partnershipOffers.map((offer) {
                        return DataRow(
                          cells: [
                            DataCell(
                              SizedBox(
                                width: 200,
                                child: Text(offer.title,
                                    style: GoogleFonts.poppins(),
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            DataCell(Text(offer.partnerName,
                                style: GoogleFonts.poppins())),
                            DataCell(Text(offer.category,
                                style: GoogleFonts.poppins())),
                            DataCell(Text(
                              offer.discountPercentage != null
                                  ? '${offer.discountPercentage!.toStringAsFixed(0)}%'
                                  : 'N/A',
                              style: GoogleFonts.poppins(),
                            )),
                            DataCell(Text(offer.discountCode ?? 'N/A',
                                style: GoogleFonts.poppins())),
                            DataCell(Text(
                              offer.usageCount.toString(),
                              style: GoogleFonts.poppins(),
                            )),
                            DataCell(Text(
                              offer.expiryDate != null
                                  ? DateFormat('MMM dd, yyyy')
                                      .format(offer.expiryDate!)
                                  : 'No expiry',
                              style: GoogleFonts.poppins(
                                color: offer.isExpired ? Colors.red : null,
                              ),
                            )),
                            DataCell(
                              Icon(
                                offer.isActive && !offer.isExpired
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: offer.isActive && !offer.isExpired
                                    ? Colors.green
                                    : Colors.red,
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
                                        _showOfferDetails(context, offer),
                                    tooltip: 'View Details',
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => _showDeleteDialog(
                                        context, offer, provider),
                                    tooltip: 'Delete Offer',
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

  void _showOfferDetails(BuildContext context, PartnershipOfferModel offer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Partnership Offer Details', style: GoogleFonts.poppins()),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Title', offer.title),
              _buildDetailRow('Description', offer.description),
              _buildDetailRow('Partner Name', offer.partnerName),
              _buildDetailRow('Category', offer.category),
              _buildDetailRow(
                'Discount',
                offer.discountPercentage != null
                    ? '${offer.discountPercentage!.toStringAsFixed(0)}%'
                    : 'N/A',
              ),
              _buildDetailRow('Discount Code', offer.discountCode ?? 'N/A'),
              _buildDetailRow(
                'Cities',
                offer.cities.isEmpty ? 'All cities' : offer.cities.join(', '),
              ),
              _buildDetailRow('Usage Count', offer.usageCount.toString()),
              _buildDetailRow(
                'Expiry Date',
                offer.expiryDate != null
                    ? DateFormat('MMM dd, yyyy HH:mm').format(offer.expiryDate!)
                    : 'No expiry',
              ),
              if (offer.termsAndConditions != null)
                _buildDetailRow('Terms & Conditions', offer.termsAndConditions!),
              _buildDetailRow('Featured', offer.isFeatured ? 'Yes' : 'No'),
              _buildDetailRow('Active', offer.isActive ? 'Yes' : 'No'),
              _buildDetailRow('Expired', offer.isExpired ? 'Yes' : 'No'),
              _buildDetailRow(
                'Created',
                DateFormat('MMM dd, yyyy HH:mm').format(offer.createdAt),
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
    PartnershipOfferModel offer,
    ContentManagementProvider provider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Partnership Offer', style: GoogleFonts.poppins()),
        content: Text(
          'Are you sure you want to delete "${offer.title}"? This action cannot be undone.',
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
              bool success = await provider.deletePartnershipOffer(offer.id);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Partnership offer deleted successfully'
                          : 'Failed to delete partnership offer',
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
