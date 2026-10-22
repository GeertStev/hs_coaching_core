import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/text/text_markup.dart';

void main() {
  const p = TextMarkupBlockType.paragraph;

  test('gewone tekst blijft ongewijzigd (bestaande teksten)', () {
    expect(parseTextMarkup('Warm up\n\n3 x 50m'), const [
      TextMarkupBlock(p, [TextMarkupSpan('Warm up')]),
      TextMarkupBlock(p, []),
      TextMarkupBlock(p, [TextMarkupSpan('3 x 50m')]),
    ]);
  });

  test('vet, cursief en onderlijnd', () {
    expect(parseTextMarkup('a **b** _c_ ++d++').single.spans, const [
      TextMarkupSpan('a '),
      TextMarkupSpan('b', bold: true),
      TextMarkupSpan(' '),
      TextMarkupSpan('c', italic: true),
      TextMarkupSpan(' '),
      TextMarkupSpan('d', underline: true),
    ]);
  });

  test('geneste opmaak', () {
    expect(parseTextMarkup('**vet _en cursief_**').single.spans, const [
      TextMarkupSpan('vet ', bold: true),
      TextMarkupSpan('en cursief', bold: true, italic: true),
    ]);
  });

  test('twee titelgroottes', () {
    final blocks = parseTextMarkup('# Groot\n## Klein **vet**\n#geen titel');
    expect(
      blocks[0],
      const TextMarkupBlock(TextMarkupBlockType.heading1, [
        TextMarkupSpan('Groot'),
      ]),
    );
    expect(
      blocks[1],
      const TextMarkupBlock(TextMarkupBlockType.heading2, [
        TextMarkupSpan('Klein '),
        TextMarkupSpan('vet', bold: true),
      ]),
    );
    expect(
      blocks[2],
      const TextMarkupBlock(p, [TextMarkupSpan('#geen titel')]),
    );
  });

  test('code zonder sluitcode blijft tekst', () {
    expect(parseTextMarkup('snake_case en 2 ** 3').single.spans, const [
      TextMarkupSpan('snake_case en 2 ** 3'),
    ]);
    expect(parseTextMarkup('****').single.spans, const [
      TextMarkupSpan('****'),
    ]);
  });

  test('opmaak loopt niet door naar de volgende regel', () {
    final blocks = parseTextMarkup('**a\nb**');
    expect(blocks[0].spans, const [TextMarkupSpan('**a')]);
    expect(blocks[1].spans, const [TextMarkupSpan('b**')]);
  });

  test('stripTextMarkup geeft de tekst zonder codes', () {
    expect(
      stripTextMarkup('# Titel\nDit is **vet** en _schuin_ en ++onder++'),
      'Titel\nDit is vet en schuin en onder',
    );
  });
}
