import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';

class StatCard extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getAdaptiveSpacing(context, 12),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          ResponsiveUtils.getAdaptiveSpacing(context, 12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: ResponsiveUtils.getAdaptiveFontSize(context, 24),
            ),
            SizedBox(height: ResponsiveUtils.getAdaptiveSpacing(context, 8)),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 12),
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: ResponsiveUtils.getAdaptiveSpacing(context, 8)),
            RatingBar(rating: value, color: color),
          ],
        ),
      ),
    );
  }
}

class RatingBar extends StatelessWidget {
  final int rating;
  final Color color;
  final int maxRating;

  const RatingBar({
    super.key,
    required this.rating,
    required this.color,
    this.maxRating = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(maxRating, (index) {
        final isFilled = index < rating;
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.getAdaptiveSpacing(context, 1),
          ),
          width: ResponsiveUtils.getAdaptiveSpacing(context, 16),
          height: ResponsiveUtils.getAdaptiveSpacing(context, 4),
          decoration: BoxDecoration(
            color: isFilled ? color : Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}

class StatsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> stats;

  const StatsGrid({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveUtils.getStatsColumns(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: ResponsiveUtils.isMobile(context) ? 1.2 : 1.1,
        crossAxisSpacing: ResponsiveUtils.getAdaptiveSpacing(context, 12),
        mainAxisSpacing: ResponsiveUtils.getAdaptiveSpacing(context, 12),
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return StatCard(
          label: stat['label'] as String,
          value: stat['value'] as int,
          icon: stat['icon'] as IconData,
          color: stat['color'] as Color,
        );
      },
    );
  }
}
