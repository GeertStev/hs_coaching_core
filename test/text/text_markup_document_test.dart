import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/text/text_markup.dart';

/// Platte tekst van regels, voor korte verwachtingen.
List<String> plain(TextMarkupSection section) =>
    (section as TextMarkupLines).lines.map((l) => l.plainText).toList();

List<List<String>> cells(TextMarkupSection section) => [
  for (final row in (section as TextMarkupTable).rows)
    [for (final cell in row) cell.map((s) => s.text).join()],
];

void main() {
  test('gewone tekst is één stuk regels', () {
    final sections = parseTextDocument('a\n\nb');
    expect(sections, hasLength(1));
    expect(plain(sections.single), ['a', '', 'b']);
  });

  group('kolommen', () {
    test('twee blokken met tekst ervoor en erna', () {
      final sections = parseTextDocument(
        'Intro\n{\nKolom 1\n\nmeer\n}\n{\nKolom 2\n}\nSlot',
      );
      expect(sections, hasLength(3));
      expect(plain(sections[0]), ['Intro']);
      final columns = (sections[1] as TextMarkupColumns).columns;
      expect(columns, hasLength(2));
      expect(plain(columns[0].single), ['Kolom 1', '', 'meer']);
      expect(plain(columns[1].single), ['Kolom 2']);
      expect(plain(sections[2]), ['Slot']);
    });

    test('witregels tussen blokken horen bij dezelfde rij', () {
      final sections = parseTextDocument('{\na\n}\n\n{\nb\n}');
      expect((sections.single as TextMarkupColumns).columns, hasLength(2));
    });

    test('max 3 per rij, een vierde blok start een nieuwe rij', () {
      final sections = parseTextDocument('{\na\n}\n{\nb\n}\n{\nc\n}\n{\nd\n}');
      expect(sections, hasLength(2));
      expect((sections[0] as TextMarkupColumns).columns, hasLength(3));
      expect((sections[1] as TextMarkupColumns).columns, hasLength(1));
    });

    test('zonder sluitende } loopt de kolom door tot het einde', () {
      final sections = parseTextDocument('{\na\nb');
      final columns = (sections.single as TextMarkupColumns).columns;
      expect(plain(columns.single.single), ['a', 'b']);
    });

    test('haakjes midden in een regel blijven tekst', () {
      final sections = parseTextDocument('set {a} en }');
      expect(plain(sections.single), ['set {a} en }']);
    });
  });

  group('tabellen', () {
    test('kop, scheiding en rijen, met opmaak in cellen', () {
      final sections = parseTextDocument(
        'Voor\n| Oefening | Tijd |\n|---|:---:|\n| **Sprint** | 30s |\n| Rust |\nNa',
      );
      expect(sections, hasLength(3));
      expect(plain(sections[0]), ['Voor']);
      expect(cells(sections[1]), [
        ['Oefening', 'Tijd'],
        ['Sprint', '30s'],
        ['Rust', ''], // aangevuld tot de breedte van de kop
      ]);
      final sprint = (sections[1] as TextMarkupTable).rows[1][0].single;
      expect(sprint.bold, isTrue);
      expect(plain(sections[2]), ['Na']);
    });

    test('zonder scheidingsregel is het gewone tekst', () {
      final sections = parseTextDocument('| a | b |\n| c | d |');
      expect(plain(sections.single), ['| a | b |', '| c | d |']);
    });

    test('tabel in een kolom', () {
      final sections = parseTextDocument('{\n| a |\n|---|\n| b |\n}\n{\nx\n}');
      final columns = (sections.single as TextMarkupColumns).columns;
      expect(cells(columns[0].single), [
        ['a'],
        ['b'],
      ]);
    });
  });

  test('stripTextMarkup laat kolom- en tabelcodes weg', () {
    expect(
      stripTextMarkup('{\n**a**\n}\n{\nb\n}\n| x | y |\n|---|---|\n| 1 | 2 |'),
      'a\nb\nx  y\n1  2',
    );
  });
}
