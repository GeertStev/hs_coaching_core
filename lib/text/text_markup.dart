/// Eenvoudige opmaak voor display-teksten: een kleine Markdown-subset die in
/// het gewone `text`-veld van `DisplayText` wordt bewaard. Bestaande teksten
/// zonder opmaakcodes blijven dus gewoon geldig.
///
/// Ondersteund:
/// - `# Titel` (grote titel) en `## Titel` (kleine titel) aan het begin van
///   een regel;
/// - `**vet**`, `_cursief_` en `++onderlijnd++` binnen een regel. Een
///   opmaakcode zonder sluitende tegenhanger op dezelfde regel blijft gewoon
///   tekst (bv. `snake_case` of `2 ** 3`).
///
/// Puur Dart: de app gebruikt het voor de knoppen en het voorbeeld, het
/// scherm voor de weergave (zie `text_markup_span.dart`).
library;

enum TextMarkupBlockType { paragraph, heading1, heading2 }

/// Eén stuk tekst met dezelfde opmaak.
class TextMarkupSpan {
  const TextMarkupSpan(
    this.text, {
    this.bold = false,
    this.italic = false,
    this.underline = false,
  });

  final String text;
  final bool bold;
  final bool italic;
  final bool underline;

  @override
  bool operator ==(Object other) =>
      other is TextMarkupSpan &&
      other.text == text &&
      other.bold == bold &&
      other.italic == italic &&
      other.underline == underline;

  @override
  int get hashCode => Object.hash(text, bold, italic, underline);

  @override
  String toString() =>
      'TextMarkupSpan(${[if (bold) 'b', if (italic) 'i', if (underline) 'u'].join()} "$text")';
}

/// Eén regel van de tekst: gewone alinea of titel.
class TextMarkupBlock {
  const TextMarkupBlock(this.type, this.spans);

  final TextMarkupBlockType type;
  final List<TextMarkupSpan> spans;

  /// De tekst zonder opmaakcodes.
  String get plainText => spans.map((s) => s.text).join();

  @override
  bool operator ==(Object other) =>
      other is TextMarkupBlock &&
      other.type == type &&
      _listEquals(other.spans, spans);

  @override
  int get hashCode => Object.hash(type, Object.hashAll(spans));

  @override
  String toString() => 'TextMarkupBlock($type, $spans)';
}

/// Opmaakcodes binnen een regel, langste eerst zodat `**` niet als twee
/// losse tekens wordt gelezen.
const _inlineMarkers = ['**', '++', '_'];

/// Zet [source] om naar één blok per regel.
List<TextMarkupBlock> parseTextMarkup(String source) {
  return source.split('\n').map(_parseLine).toList();
}

/// De tekst zonder opmaakcodes, bv. voor de lijst in de app en om te zoeken.
String stripTextMarkup(String source) {
  return parseTextMarkup(source).map((b) => b.plainText).join('\n');
}

TextMarkupBlock _parseLine(String line) {
  var type = TextMarkupBlockType.paragraph;
  var content = line;
  if (line.startsWith('## ')) {
    type = TextMarkupBlockType.heading2;
    content = line.substring(3);
  } else if (line.startsWith('# ')) {
    type = TextMarkupBlockType.heading1;
    content = line.substring(2);
  }
  return TextMarkupBlock(type, _parseInline(content));
}

List<TextMarkupSpan> _parseInline(String line) {
  final spans = <TextMarkupSpan>[];
  final buffer = StringBuffer();
  final open = <String>{};

  void flush() {
    if (buffer.isEmpty) return;
    spans.add(
      TextMarkupSpan(
        buffer.toString(),
        bold: open.contains('**'),
        italic: open.contains('_'),
        underline: open.contains('++'),
      ),
    );
    buffer.clear();
  }

  var i = 0;
  while (i < line.length) {
    final marker = _markerAt(line, i);
    if (marker != null) {
      if (open.contains(marker)) {
        flush();
        open.remove(marker);
        i += marker.length;
        continue;
      }
      // Alleen openen als er verderop op de regel een sluitcode staat en er
      // iets tussen staat; anders is het gewone tekst.
      final close = line.indexOf(marker, i + marker.length);
      if (close > i + marker.length) {
        flush();
        open.add(marker);
        i += marker.length;
        continue;
      }
    }
    buffer.write(line[i]);
    i++;
  }
  flush();
  return spans;
}

String? _markerAt(String line, int index) {
  for (final marker in _inlineMarkers) {
    if (line.startsWith(marker, index)) return marker;
  }
  return null;
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
