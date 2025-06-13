import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/responsive_utils.dart';

class UrlHandler {
  static void showUrlDialog(BuildContext context, String url, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'URL:',
                style: TextStyle(
                  fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 14),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: ResponsiveUtils.getAdaptiveSpacing(context, 4)),
              Container(
                padding: EdgeInsets.all(
                  ResponsiveUtils.getAdaptiveSpacing(context, 8),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  url,
                  style: TextStyle(
                    fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 12),
                    color: Colors.blue[700],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancelar',
                style: TextStyle(
                  fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 14),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _copyToClipboard(context, url);
              },
              child: Text(
                'Copiar',
                style: TextStyle(
                  fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 14),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _launchUrl(context, url);
              },
              child: Text(
                'Abrir',
                style: TextStyle(
                  fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 14),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> _launchUrl(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          _showErrorSnackBar(context, 'No se puede abrir el enlace');
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(context, 'Error al abrir el enlace');
      }
    }
  }

  static Future<void> _copyToClipboard(BuildContext context, String url) async {
    try {
      await Clipboard.setData(ClipboardData(text: url));
      if (context.mounted) {
        _showSuccessSnackBar(context, 'Enlace copiado al portapapeles');
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(context, 'Error al copiar el enlace');
      }
    }
  }

  static void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class UrlTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String url;

  const UrlTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
        size: ResponsiveUtils.getAdaptiveFontSize(context, 24),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: ResponsiveUtils.getAdaptiveFontSize(context, 16),
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.open_in_new,
        color: Colors.grey[600],
        size: ResponsiveUtils.getAdaptiveFontSize(context, 20),
      ),
      onTap: () => UrlHandler.showUrlDialog(context, url, title),
    );
  }
}
