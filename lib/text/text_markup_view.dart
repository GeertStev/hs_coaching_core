import 'package:flutter/widgets.dart';
import 'package:hs_coaching_core/text/text_markup.dart';
import 'package:hs_coaching_core/text/text_markup_span.dart';

/// Toont opgemaakte tekst (zie `text_markup.dart`): regels, tabellen en
/// kolommen. Gedeeld door het scherm (weergave) en de app (voorbeeld); elke
/// app kiest zelf de stijlen en de lijnkleur van tabellen.
class TextMarkupView extends StatelessWidget {
  const TextMarkupView(
    this.source, {
    super.key,
    required this.bodyStyle,
    required this.heading1Style,
    required this.heading2Style,
    required this.lineColor,
  });

  final String source;
  final TextStyle bodyStyle;
  final TextStyle heading1Style;
  final TextStyle heading2Style;

  /// Kleur van de tabellijnen.
  final Color lineColor;

  double get _gap => (bodyStyle.fontSize ?? 14) * 0.75;

  @override
  Widget build(BuildContext context) {
    return _sections(parseTextDocument(source));
  }

  Widget _sections(List<TextMarkupSection> sections) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < sections.length; i++) ...[
          if (i > 0) SizedBox(height: _gap),
          _section(sections[i]),
        ],
      ],
    );
  }

  Widget _section(TextMarkupSection section) {
    return switch (section) {
      TextMarkupLines(:final lines) => SizedBox(
        width: double.infinity,
        child: Text.rich(
          buildTextMarkupBlocksSpan(
            lines,
            bodyStyle: bodyStyle,
            heading1Style: heading1Style,
            heading2Style: heading2Style,
          ),
        ),
      ),
      TextMarkupTable() => _table(section),
      TextMarkupColumns(:final columns) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < columns.length; i++) ...[
            if (i > 0) SizedBox(width: _gap * 2),
            Expanded(child: _sections(columns[i])),
          ],
        ],
      ),
    };
  }

  Widget _table(TextMarkupTable table) {
    final headerStyle = bodyStyle.copyWith(fontWeight: FontWeight.bold);
    final padding = EdgeInsets.symmetric(
      horizontal: _gap * 0.75,
      vertical: _gap * 0.4,
    );
    return Table(
      border: TableBorder.all(color: lineColor),
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      children: [
        for (var r = 0; r < table.rows.length; r++)
          TableRow(
            decoration: r == 0
                ? BoxDecoration(color: lineColor.withValues(alpha: 0.15))
                : null,
            children: [
              for (final cell in table.rows[r])
                Padding(
                  padding: padding,
                  child: Text.rich(
                    buildTextMarkupInlineSpan(
                      cell,
                      style: r == 0 ? headerStyle : bodyStyle,
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
