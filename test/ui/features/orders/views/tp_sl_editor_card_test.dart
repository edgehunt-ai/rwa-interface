import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/ui/features/orders/views/tp_sl_editor_card.dart';

import '../../../../helpers/test_app.dart';

void main() {
  const priceKey = Key('tp-price');
  const changeKey = Key('tp-change');
  const rulerKey = Key('tp-ruler');

  Future<TextEditingController> pumpCard(
    WidgetTester tester, {
    String initial = '100',
    double? referencePrice,
  }) async {
    final price = TextEditingController(text: initial);
    addTearDown(price.dispose);
    await tester.pumpWidget(
      buildTestApp(
        TpSlEditorCard(
          title: 'Take Profit',
          controller: price,
          enabled: true,
          onEnabledChanged: (_) {},
          referencePrice: referencePrice,
          inputKey: priceKey,
          changeKey: changeKey,
          rulerKey: rulerKey,
        ),
      ),
    );
    return price;
  }

  String textOf(WidgetTester tester, Key key) =>
      tester.widget<TextField>(find.byKey(key)).controller!.text;

  testWidgets('tp/sl amounts are borderless fields the trader taps into', (
    tester,
  ) async {
    await pumpCard(tester);

    for (final key in [priceKey, changeKey]) {
      final decoration = tester.widget<TextField>(find.byKey(key)).decoration!;
      expect(decoration.border, InputBorder.none);
      expect(decoration.enabledBorder, InputBorder.none);
      expect(decoration.focusedBorder, InputBorder.none);
      expect(decoration.filled, isFalse);
    }
    expect(find.text('Price'), findsOneWidget);
    expect(find.text('Change'), findsOneWidget);
  });

  testWidgets('editing the price restates the change percent', (tester) async {
    await pumpCard(tester);
    expect(textOf(tester, changeKey), '0');

    await tester.enterText(find.byKey(priceKey), '110');
    await tester.pump();

    expect(textOf(tester, changeKey), '10');
  });

  testWidgets('editing the change percent restates the price', (tester) async {
    final price = await pumpCard(tester);

    await tester.enterText(find.byKey(changeKey), '-5');
    await tester.pump();

    expect(price.text, '95');
    // The binding settles instead of ping-ponging between the two fields.
    expect(textOf(tester, changeKey), '-5');
  });

  testWidgets('editing change trims a single trailing decimal zero', (
    tester,
  ) async {
    final price = await pumpCard(tester);

    await tester.enterText(find.byKey(changeKey), '5.1');
    await tester.pump();

    expect(price.text, '105.1');
  });

  testWidgets('tp/sl switch matches the 44x24 design control', (tester) async {
    await pumpCard(tester);

    expect(tester.getSize(find.byType(Switch)), const Size(44, 24));
  });

  testWidgets('dragging the ruler follows the finger direction', (
    tester,
  ) async {
    final price = await pumpCard(tester);

    await tester.drag(find.byKey(rulerKey), const Offset(60, 0));
    await tester.pump();

    expect(double.parse(price.text), lessThan(100));
    expect(double.parse(textOf(tester, changeKey)), lessThan(0));
  });

  testWidgets('dragging the ruler to its lower bound reaches zero', (
    tester,
  ) async {
    final price = await pumpCard(tester);
    final ruler = find.byKey(rulerKey);

    await tester.drag(ruler, Offset(tester.getSize(ruler).width, 0));
    await tester.pump();

    expect(price.text, '0');
    expect(textOf(tester, changeKey), '-100');
  });

  testWidgets('dragging left can raise a price from zero', (tester) async {
    final price = await pumpCard(tester, initial: '0', referencePrice: 100);

    await tester.drag(find.byKey(rulerKey), const Offset(-60, 0));
    await tester.pump();

    expect(double.parse(price.text), greaterThan(0));
  });

  testWidgets('unbounded drag distance scales from the current price', (
    tester,
  ) async {
    double? priceFrom100;
    double? priceFrom50;
    await tester.pumpWidget(
      buildTestApp(
        Column(
          children: [
            TpSlTickRuler(
              key: const Key('price-100-ruler'),
              semanticLabel: 'Price 100',
              value: 100,
              minimum: 0,
              maximum: 110,
              divisions: 20,
              unbounded: true,
              onChanged: (value) => priceFrom100 = value,
            ),
            TpSlTickRuler(
              key: const Key('price-50-ruler'),
              semanticLabel: 'Price 50',
              value: 50,
              minimum: 0,
              maximum: 110,
              divisions: 20,
              unbounded: true,
              onChanged: (value) => priceFrom50 = value,
            ),
          ],
        ),
      ),
    );

    await tester.drag(
      find.byKey(const Key('price-100-ruler')),
      const Offset(60, 0),
    );
    await tester.drag(
      find.byKey(const Key('price-50-ruler')),
      const Offset(60, 0),
    );

    expect(priceFrom100, isNotNull);
    expect(priceFrom50, isNotNull);
    expect(priceFrom100! / 100, closeTo(priceFrom50! / 50, 0.000001));
  });

  testWidgets('a new drag continues from the previously dragged price', (
    tester,
  ) async {
    final price = await pumpCard(tester);
    final ruler = find.byKey(rulerKey);

    await tester.drag(ruler, const Offset(-300, 0));
    await tester.pump();
    final firstDragPrice = double.parse(price.text);
    expect(firstDragPrice, greaterThan(110));

    await tester.drag(ruler, const Offset(-30, 0));
    await tester.pump();

    expect(double.parse(price.text), greaterThan(firstDragPrice));
  });

  testWidgets('change is measured against the reference price, not the field', (
    tester,
  ) async {
    // A take profit already sat at 110 while the market is at 100.
    await pumpCard(tester, initial: '110', referencePrice: 100);

    expect(textOf(tester, changeKey), '10');
  });
}
