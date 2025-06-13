import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/cat_breed.dart';
import '../utils/responsive_utils.dart';
import '../utils/cat_stats_helper.dart';
import '../widgets/info_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/url_handler.dart';
import '../widgets/country_flag_widget.dart';

class CatDetailScreen extends StatelessWidget {
  final CatBreed breed;

  const CatDetailScreen({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveUtils.constrainedContainer(
        context: context,
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(context),
            SliverPadding(
              padding: EdgeInsets.all(
                ResponsiveUtils.getHorizontalPadding(context),
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    height: ResponsiveUtils.getAdaptiveSpacing(context, 16),
                  ),
                  _buildHeaderCard(context),
                  SizedBox(
                    height: ResponsiveUtils.getAdaptiveSpacing(context, 16),
                  ),
                  StatsGrid(stats: CatStatsHelper.getPersonalityStats(breed)),
                  SizedBox(
                    height: ResponsiveUtils.getAdaptiveSpacing(context, 16),
                  ),
                  if (breed.description?.isNotEmpty == true) ...[
                    _buildDescriptionCard(context),
                    SizedBox(
                      height: ResponsiveUtils.getAdaptiveSpacing(context, 16),
                    ),
                  ],
                  _buildTemperamentCard(context),
                  SizedBox(
                    height: ResponsiveUtils.getAdaptiveSpacing(context, 16),
                  ),
                  _buildPhysicalTraitsCard(context),
                  SizedBox(
                    height: ResponsiveUtils.getAdaptiveSpacing(context, 16),
                  ),
                  _buildLinksCard(context),
                  SizedBox(
                    height: ResponsiveUtils.getAdaptiveSpacing(context, 32),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    final expandedHeight = ResponsiveUtils.isMobile(context) ? 300.0 : 400.0;

    return SliverAppBar(
      expandedHeight: expandedHeight,
      pinned: true,
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white, size: 28),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          breed.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 20),
            color: Colors.white,
            shadows: const [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 8,
                color: Colors.black87,
              ),
              Shadow(
                offset: Offset(1, 1),
                blurRadius: 4,
                color: Colors.black54,
              ),
            ],
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'cat-${breed.id}',
              child: breed.displayImageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: breed.displayImageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.pets,
                          size: ResponsiveUtils.getAdaptiveSpacing(context, 80),
                          color: Colors.grey[400],
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.error,
                          size: ResponsiveUtils.getAdaptiveSpacing(context, 80),
                          color: Colors.grey[400],
                        ),
                      ),
                    )
                  : Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.pets,
                        size: ResponsiveUtils.getAdaptiveSpacing(context, 80),
                        color: Colors.grey[400],
                      ),
                    ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return InfoCard(
      title: 'Información General',
      icon: Icons.info,
      iconColor: Colors.blue,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: ResponsiveUtils.getAdaptiveSpacing(context, 4),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: ResponsiveUtils.getAdaptiveFontSize(context, 16),
                  color: Colors.blue,
                ),
                SizedBox(width: ResponsiveUtils.getAdaptiveSpacing(context, 8)),
                Text(
                  'Origen: ',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 14),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(
                  child: CountryFlagWidget(
                    countryName: breed.origin,
                    flagSize: ResponsiveUtils.getAdaptiveFontSize(context, 18),
                    textStyle: TextStyle(
                      fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 14),
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (breed.lifeSpan?.isNotEmpty == true) ...[
            SizedBox(height: ResponsiveUtils.getAdaptiveSpacing(context, 8)),
            InfoRow(
              icon: Icons.favorite,
              iconColor: Colors.red,
              label: 'Esperanza de vida',
              value: CatStatsHelper.formatLifeSpan(breed.lifeSpan),
            ),
          ],
          if (breed.weight != null) ...[
            SizedBox(height: ResponsiveUtils.getAdaptiveSpacing(context, 8)),
            InfoRow(
              icon: Icons.monitor_weight,
              iconColor: Colors.green,
              label: 'Peso',
              value: CatStatsHelper.formatWeight(breed.weight),
            ),
          ],
          if (CatStatsHelper.getAlternativeNames(
            breed.altNames,
          ).isNotEmpty) ...[
            SizedBox(height: ResponsiveUtils.getAdaptiveSpacing(context, 12)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nombres alternativos:',
                style: TextStyle(
                  fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 14),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: ResponsiveUtils.getAdaptiveSpacing(context, 8)),
            ChipList(
              items: CatStatsHelper.getAlternativeNames(breed.altNames),
              chipColor: Colors.blue[100],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDescriptionCard(BuildContext context) {
    return InfoCard(
      title: 'Descripción',
      icon: Icons.description,
      iconColor: Colors.blue,
      child: Text(
        breed.description!,
        style: TextStyle(
          fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 14),
          height: 1.5,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildTemperamentCard(BuildContext context) {
    final temperaments = CatStatsHelper.getTemperamentChips(breed.temperament);

    return InfoCard(
      title: 'Temperamento',
      icon: Icons.psychology,
      iconColor: Colors.purple,
      child: ChipList(items: temperaments, chipColor: Colors.purple[100]),
    );
  }

  Widget _buildPhysicalTraitsCard(BuildContext context) {
    final traits = CatStatsHelper.getPhysicalTraits(breed);

    if (traits.isEmpty) return const SizedBox.shrink();

    return InfoCard(
      title: 'Características Físicas',
      icon: Icons.pets,
      iconColor: Colors.green,
      child: Wrap(
        spacing: ResponsiveUtils.getAdaptiveSpacing(context, 8),
        runSpacing: ResponsiveUtils.getAdaptiveSpacing(context, 8),
        children: traits.map((trait) {
          return Chip(
            avatar: Icon(
              trait['icon'] as IconData,
              size: ResponsiveUtils.getAdaptiveFontSize(context, 16),
              color: Colors.white,
            ),
            label: Text(
              trait['label'] as String,
              style: TextStyle(
                fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 12),
                color: Colors.white,
              ),
            ),
            backgroundColor: trait['color'] as Color,
            elevation: 2,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLinksCard(BuildContext context) {
    final links = CatStatsHelper.getUsefulLinks(breed);

    if (links.isEmpty) return const SizedBox.shrink();

    return InfoCard(
      title: 'Enlaces Útiles',
      icon: Icons.link,
      iconColor: Colors.orange,
      child: Column(
        children: links.map((link) {
          return UrlTile(
            icon: link['icon'] as IconData,
            iconColor: link['color'] as Color,
            title: link['title'] as String,
            url: link['url'] as String,
          );
        }).toList(),
      ),
    );
  }
}
