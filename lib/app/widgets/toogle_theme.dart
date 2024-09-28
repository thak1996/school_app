import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class ToogleTheme extends StatelessWidget {
  const ToogleTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 10),
        const Icon(Icons.light_mode_outlined),
        const SizedBox(width: 10),
        Switch(
          value: AdaptiveTheme.of(context).mode.isDark,
          onChanged: (value) {
            if (value) {
              AdaptiveTheme.of(context).setDark();
            } else {
              AdaptiveTheme.of(context).setLight();
            }
          },
        ),
        const SizedBox(width: 10),
        const Icon(Icons.dark_mode_outlined),
        const SizedBox(width: 10),
      ],
    );
  }
}
