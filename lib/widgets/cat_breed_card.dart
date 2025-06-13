import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/cat_breed.dart';
import '../utils/responsive_utils.dart';
import 'country_flag_widget.dart';

class CatBreedCard extends StatelessWidget {
  final CatBreed breed;
  final VoidCallback onTap;

  const CatBreedCard({super.key, required this.breed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getAdaptiveSpacing(context, 12),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getAdaptiveSpacing(context, 12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(
                    ResponsiveUtils.getAdaptiveSpacing(context, 12),
                  ),
                ),
                child: Hero(
                  tag: 'cat-${breed.id}',
                  child: breed.displayImageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: breed.displayImageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.pets,
                              size: ResponsiveUtils.getAdaptiveSpacing(
                                context,
                                40,
                              ),
                              color: Colors.grey[400],
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.error,
                              size: ResponsiveUtils.getAdaptiveSpacing(
                                context,
                                40,
                              ),
                              color: Colors.grey[400],
                            ),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.pets,
                            size: ResponsiveUtils.getAdaptiveSpacing(
                              context,
                              40,
                            ),
                            color: Colors.grey[400],
                          ),
                        ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(
                  ResponsiveUtils.getAdaptiveSpacing(context, 12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      breed.name,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.getAdaptiveFontSize(
                          context,
                          16,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: ResponsiveUtils.getAdaptiveSpacing(context, 4),
                    ),
                    CountryFlagWidget(
                      countryName: breed.origin,
                      flagSize: ResponsiveUtils.getAdaptiveFontSize(context, 16),
                      textStyle: TextStyle(
                        fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 12),
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: ResponsiveUtils.getAdaptiveSpacing(context, 8),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          size: ResponsiveUtils.getAdaptiveFontSize(
                            context,
                            14,
                          ),
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: ResponsiveUtils.getAdaptiveSpacing(context, 4),
                        ),
                        Text(
                          '${breed.affectionLevel}/5',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.getAdaptiveFontSize(
                              context,
                              12,
                            ),
                            color: Colors.grey[600],
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.psychology,
                          size: ResponsiveUtils.getAdaptiveFontSize(
                            context,
                            14,
                          ),
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: ResponsiveUtils.getAdaptiveSpacing(context, 4),
                        ),
                        Text(
                          '${breed.intelligence}/5',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.getAdaptiveFontSize(
                              context,
                              12,
                            ),
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
