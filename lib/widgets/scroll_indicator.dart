import 'package:flutter/material.dart';

class ScrollIndicator extends StatelessWidget {
  final ScrollController scrollController;
  final Widget child;

  const ScrollIndicator({
    super.key,
    required this.scrollController,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        return false;
      },
      child: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        thickness: 6,
        radius: const Radius.circular(3),
        child: child,
      ),
    );
  }
}
