import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget child;
  final EdgeInsets? padding;

  const InfoCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getAdaptiveSpacing(context, 12),
        ),
      ),
      child: Padding(
        padding:
            padding ??
            EdgeInsets.all(ResponsiveUtils.getAdaptiveSpacing(context, 16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: ResponsiveUtils.getAdaptiveFontSize(context, 20),
                ),
                SizedBox(width: ResponsiveUtils.getAdaptiveSpacing(context, 8)),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: ResponsiveUtils.getAdaptiveSpacing(context, 12)),
            child,
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveUtils.getAdaptiveSpacing(context, 4),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: ResponsiveUtils.getAdaptiveFontSize(context, 16),
            color: iconColor ?? Colors.grey[600],
          ),
          SizedBox(width: ResponsiveUtils.getAdaptiveSpacing(context, 8)),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 14),
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 14),
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChipList extends StatelessWidget {
  final List<String> items;
  final Color? chipColor;

  const ChipList({super.key, required this.items, this.chipColor});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: ResponsiveUtils.getAdaptiveSpacing(context, 8),
      runSpacing: ResponsiveUtils.getAdaptiveSpacing(context, 4),
      children: items.map((item) {
        return Chip(
          label: Text(
            item,
            style: TextStyle(
              fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 12),
            ),
          ),
          backgroundColor: chipColor ?? Colors.blue[50],
          side: BorderSide(color: chipColor ?? Colors.blue[200]!, width: 1),
        );
      }).toList(),
    );
  }
}
