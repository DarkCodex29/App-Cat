import 'package:flutter/material.dart';

class ResponsiveUtils {
  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  // Métodos para detectar el tipo de dispositivo
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint;
  }

  // Número de columnas para grid según el dispositivo
  static int getGridColumns(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 3; // Desktop
  }

  // Número de columnas para stats grid
  static int getStatsColumns(BuildContext context) {
    if (isMobile(context)) return 2;
    if (isTablet(context)) return 3;
    return 4; // Desktop
  }

  // Padding horizontal según el dispositivo
  static double getHorizontalPadding(BuildContext context) {
    if (isMobile(context)) return 16.0;
    if (isTablet(context)) return 24.0;
    return 32.0; // Desktop
  }

  // Ancho máximo del contenido
  static double getMaxContentWidth(BuildContext context) {
    if (isMobile(context)) return double.infinity;
    if (isTablet(context)) return 800;
    return 1200; // Desktop
  }

  // Aspect ratio para las cards de gatos
  static double getCatCardAspectRatio(BuildContext context) {
    if (isMobile(context)) return 1.2;
    if (isTablet(context)) return 1.1;
    return 1.0; // Desktop
  }

  // Tamaño de fuente adaptativo
  static double getAdaptiveFontSize(BuildContext context, double baseFontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < mobileBreakpoint) {
      return baseFontSize * 0.9;
    } else if (screenWidth < tabletBreakpoint) {
      return baseFontSize;
    } else {
      return baseFontSize * 1.1;
    }
  }

  // Espaciado adaptativo
  static double getAdaptiveSpacing(BuildContext context, double baseSpacing) {
    if (isMobile(context)) return baseSpacing;
    if (isTablet(context)) return baseSpacing * 1.2;
    return baseSpacing * 1.5; // Desktop
  }

  // Widget para centrar contenido con ancho máximo
  static Widget constrainedContainer({
    required BuildContext context,
    required Widget child,
    double? maxWidth,
  }) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? getMaxContentWidth(context),
        ),
        child: child,
      ),
    );
  }
}
