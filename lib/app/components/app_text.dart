import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle? style;
  final String textStyleKey;
  final Color? color;

  const AppText._(
    this.text,
    this.textStyleKey, {
    this.style,
    this.textAlign,
    this.color,
    super.key,
  });

  factory AppText(
    String text,
    TextStyle textStyle, {
    TextAlign? textAlign,
    Color? color,
  }) {
    return AppText._(
      text,
      textStyle.toString(),
      textAlign: textAlign,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    // Mapeia os estilos
    final textStyles = {
      'bodyLarge': theme.bodyLarge,
      'bodyMedium': theme.bodyMedium,
      'bodySmall': theme.bodySmall,
      'headlineLarge': theme.headlineLarge,
      'headlineMedium': theme.headlineMedium,
      'headlineSmall': theme.headlineSmall,
      'displayLarge': theme.displayLarge,
      'displayMedium': theme.displayMedium,
      'displaySmall': theme.displaySmall,
    };

    TextStyle? finalStyle = style ?? textStyles[textStyleKey];

    if (color != null) {
      finalStyle = finalStyle?.copyWith(color: color);
    }

    return Text(
      text,
      style: finalStyle,
      textAlign: textAlign,
    );
  }
}

class AppTextBodyLarge extends AppText {
  const AppTextBodyLarge(
    String text, {
    super.key,
    TextAlign? textAlign,
    Color? color,
  }) : super._(
          text,
          'bodyLarge',
          textAlign: textAlign,
          color: color,
        );
}

class AppTextBodyMedium extends AppText {
  const AppTextBodyMedium(
    String text, {
    super.key,
    TextAlign? textAlign,
    Color? color,
  }) : super._(
          text,
          'bodyMedium',
          textAlign: textAlign,
          color: color,
        );
}

class AppTextBodySmall extends AppText {
  const AppTextBodySmall(
    String text, {
    super.key,
    TextAlign? textAlign,
    Color? color,
  }) : super._(
          text,
          'bodySmall',
          textAlign: textAlign,
          color: color,
        );
}

class AppTextHeadlineLarge extends AppText {
  const AppTextHeadlineLarge(
    String text, {
    super.key,
    TextAlign? textAlign,
    Color? color,
  }) : super._(
          text,
          'headlineLarge',
          textAlign: textAlign,
          color: color,
        );
}

class AppTextHeadlineMedium extends AppText {
  const AppTextHeadlineMedium(
    String text, {
    super.key,
    TextAlign? textAlign,
    Color? color,
  }) : super._(
          text,
          'headlineMedium',
          textAlign: textAlign,
          color: color,
        );
}

class AppTextHeadlineSmall extends AppText {
  const AppTextHeadlineSmall(
    String text, {
    super.key,
    TextAlign? textAlign,
    Color? color,
  }) : super._(
          text,
          'headlineSmall',
          textAlign: textAlign,
          color: color,
        );
}

class AppTextDisplayLarge extends AppText {
  const AppTextDisplayLarge(
    String text, {
    super.key,
    TextAlign? textAlign,
    Color? color,
  }) : super._(
          text,
          'displayLarge',
          textAlign: textAlign,
          color: color,
        );
}

class AppTextDisplayMedium extends AppText {
  const AppTextDisplayMedium(
    String text, {
    super.key,
    TextAlign? textAlign,
    Color? color,
  }) : super._(
          text,
          'displayMedium',
          textAlign: textAlign,
          color: color,
        );
}

class AppTextDisplaySmall extends AppText {
  const AppTextDisplaySmall(
    String text, {
    super.key,
    TextAlign? textAlign,
    Color? color,
  }) : super._(
          text,
          'displaySmall',
          textAlign: textAlign,
          color: color,
        );
}
