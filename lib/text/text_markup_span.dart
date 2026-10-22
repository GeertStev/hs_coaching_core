import 'package:flutter/painting.dart';
import 'package:hs_coaching_core/text/text_markup.dart';

/// Bouwt één [TextSpan] uit opgemaakte tekst (zie `text_markup.dart`), voor
/// een `Text.rich`. Gedeeld door het scherm (weergave) en de app (voorbeeld),
/// zodat beide de opmaak hetzelfde tonen. Elke app kiest zelf de stijlen.
TextSpan buildTextMarkupSpan(
  String source, {
  required TextStyle bodyStyle,
  required TextStyle heading1Style,
  required TextStyle heading2Style,
}) {
  final blocks = parseTextMarkup(source);
  final children = <InlineSpan>[];
  for (var i = 0; i < blocks.length; i++) {
    final block = blocks[i];
    final blockStyle = switch (block.type) {
      TextMarkupBlockType.paragraph => bodyStyle,
      TextMarkupBlockType.heading1 => heading1Style,
      TextMarkupBlockType.heading2 => heading2Style,
    };
    for (final span in block.spans) {
      children.add(
        TextSpan(text: span.text, style: _spanStyle(blockStyle, span)),
      );
    }
    if (i < blocks.length - 1) {
      children.add(TextSpan(text: '\n', style: blockStyle));
    }
  }
  return TextSpan(style: bodyStyle, children: children);
}

TextStyle _spanStyle(TextStyle base, TextMarkupSpan span) {
  return base.copyWith(
    fontWeight: span.bold ? FontWeight.bold : null,
    fontStyle: span.italic ? FontStyle.italic : null,
    decoration: span.underline ? TextDecoration.underline : null,
    decorationColor: span.underline ? base.color : null,
  );
}
