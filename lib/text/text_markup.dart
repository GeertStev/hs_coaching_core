/// Eenvoudige opmaak voor display-teksten: een kleine Markdown-subset die in
/// het gewone `text`-veld van `DisplayText` wordt bewaard. Bestaande teksten
/// zonder opmaakcodes blijven dus gewoon geldig.
///
/// Ondersteund:
/// - `# Titel` (grote titel) en `## Titel` (kleine titel) aan het begin van
///   een regel;
/// - `**vet**`, `_cursief_` en `++onderlijnd++` binnen een regel. Een
///   opmaakcode zonder sluitende tegenhanger op dezelfde regel blijft gewoon
///   tekst (bv. `snake_case` of `2 ** 3`);
/// - kolommen: tekst tussen een `{`- en een `}`-regel (elk alleen op een
///   regel) is één kolom. Blokken vlak na elkaar (enkel witregels ertussen)
///   vormen één rij, max [maxTextColumns]; een volgend blok start een nieuwe
///   rij. Zonder `}` loopt de kolom door tot het einde;
/// - tabellen in Markdown-stijl: een `| a | b |`-regel gevolgd door een
///   scheidingsregel `|---|---|` is de kop, volgende `|`-regels de rijen.
///
/// Puur Dart: de app gebruikt het voor de knoppen en het voorbeeld, het
/// scherm voor de weergave (zie `text_markup_view.dart`).
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
/// Kolommen komen onder elkaar, tabelcellen gescheiden door twee spaties.
String stripTextMarkup(String source) {
  return _plainSections(parseTextDocument(source)).join('\n');
}

List<String> _plainSections(List<TextMarkupSection> sections) {
  return [
    for (final section in sections)
      ...switch (section) {
        TextMarkupLines(:final lines) => lines.map((l) => l.plainText),
        TextMarkupTable(:final rows) => rows.map(
          (row) => row.map((cell) => cell.map((s) => s.text).join()).join('  '),
        ),
        TextMarkupColumns(:final columns) => columns.expand(_plainSections),
      },
  ];
}

/// Maximum aantal kolommen naast elkaar.
const maxTextColumns = 3;

/// Een stuk van de tekst: gewone regels, een tabel of een rij kolommen.
sealed class TextMarkupSection {
  const TextMarkupSection();
}

class TextMarkupLines extends TextMarkupSection {
  const TextMarkupLines(this.lines);

  final List<TextMarkupBlock> lines;
}

/// Tabel; de eerste rij is de kop. Alle rijen hebben evenveel cellen.
class TextMarkupTable extends TextMarkupSection {
  const TextMarkupTable(this.rows);

  final List<List<List<TextMarkupSpan>>> rows;

  int get columnCount => rows.first.length;
}

/// Rij kolommen; elke kolom bevat regels en tabellen (geen kolommen).
class TextMarkupColumns extends TextMarkupSection {
  const TextMarkupColumns(this.columns);

  final List<List<TextMarkupSection>> columns;
}

/// Zet [source] om naar stukken: gewone regels, tabellen en kolommen.
List<TextMarkupSection> parseTextDocument(String source) {
  final lines = source.split('\n');
  final sections = <TextMarkupSection>[];
  final flow = <String>[];
  var i = 0;

  void flushFlow() {
    sections.addAll(_parseFlow(flow));
    flow.clear();
  }

  while (i < lines.length) {
    if (!_isColumnStart(lines[i])) {
      flow.add(lines[i]);
      i++;
      continue;
    }
    flushFlow();
    final columns = <List<TextMarkupSection>>[];
    while (i < lines.length &&
        _isColumnStart(lines[i]) &&
        columns.length < maxTextColumns) {
      i++; // `{`
      final columnLines = <String>[];
      while (i < lines.length && !_isColumnEnd(lines[i])) {
        columnLines.add(lines[i]);
        i++;
      }
      if (i < lines.length) i++; // `}`
      columns.add(_parseFlow(columnLines));
      // Witregels tussen twee blokken horen bij de rij.
      var next = i;
      while (next < lines.length && lines[next].trim().isEmpty) {
        next++;
      }
      if (next < lines.length && _isColumnStart(lines[next])) i = next;
    }
    sections.add(TextMarkupColumns(columns));
  }
  flushFlow();
  return sections;
}

bool _isColumnStart(String line) => line.trim() == '{';
bool _isColumnEnd(String line) => line.trim() == '}';

/// Regels en tabellen (zonder kolommen).
List<TextMarkupSection> _parseFlow(List<String> lines) {
  final sections = <TextMarkupSection>[];
  final plain = <String>[];

  void flushPlain() {
    if (plain.isEmpty) return;
    sections.add(TextMarkupLines(plain.map(_parseLine).toList()));
    plain.clear();
  }

  var i = 0;
  while (i < lines.length) {
    if (_isTableRow(lines[i]) &&
        i + 1 < lines.length &&
        _isTableSeparator(lines[i + 1])) {
      flushPlain();
      final rows = [_tableCells(lines[i])];
      i += 2;
      while (i < lines.length && _isTableRow(lines[i])) {
        rows.add(_tableCells(lines[i]));
        i++;
      }
      sections.add(_buildTable(rows));
      continue;
    }
    plain.add(lines[i]);
    i++;
  }
  flushPlain();
  return sections;
}

bool _isTableRow(String line) => line.trimLeft().startsWith('|');

final _separatorCell = RegExp(r'^\s*:?-+:?\s*$');

bool _isTableSeparator(String line) {
  if (!_isTableRow(line)) return false;
  final cells = _tableCells(line);
  return cells.isNotEmpty && cells.every(_separatorCell.hasMatch);
}

/// `| a | b |` → `['a', 'b']`; de buitenste pipes zijn optioneel aan het eind.
List<String> _tableCells(String line) {
  var content = line.trim();
  if (content.startsWith('|')) content = content.substring(1);
  if (content.endsWith('|')) content = content.substring(0, content.length - 1);
  return content.split('|').map((cell) => cell.trim()).toList();
}

TextMarkupTable _buildTable(List<List<String>> rows) {
  final width = rows.first.length;
  return TextMarkupTable([
    for (final row in rows)
      [
        for (var c = 0; c < width; c++)
          _parseInline(c < row.length ? row[c] : ''),
      ],
  ]);
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
