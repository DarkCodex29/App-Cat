import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/country_flag_service.dart';
import '../utils/responsive_utils.dart';

class CountryFlagWidget extends StatefulWidget {
  final String countryName;
  final double? flagSize;
  final TextStyle? textStyle;

  const CountryFlagWidget({
    super.key,
    required this.countryName,
    this.flagSize,
    this.textStyle,
  });

  @override
  State<CountryFlagWidget> createState() => _CountryFlagWidgetState();
}

class _CountryFlagWidgetState extends State<CountryFlagWidget> {
  String? flagUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFlag();
  }

  Future<void> _loadFlag() async {
    final url = await CountryFlagService.getFlagUrl(widget.countryName);
    if (mounted) {
      setState(() {
        flagUrl = url;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.flagSize ?? ResponsiveUtils.getAdaptiveFontSize(context, 20);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size * 0.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey[300]!, width: 0.5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: isLoading
                ? Container(
                    color: Colors.grey[200],
                    child: Icon(
                      Icons.flag,
                      size: size * 0.5,
                      color: Colors.grey[400],
                    ),
                  )
                : flagUrl != null
                    ? CachedNetworkImage(
                        imageUrl: flagUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.flag,
                            size: size * 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.location_on,
                            size: size * 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.location_on,
                          size: size * 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
          ),
        ),
        SizedBox(width: ResponsiveUtils.getAdaptiveSpacing(context, 8)),
        Flexible(
          child: Text(
            widget.countryName,
            style: widget.textStyle ?? TextStyle(
              fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 14),
              color: Colors.grey[700],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
} 