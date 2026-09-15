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

  testWidgets('tp/sl switch matches the 44x24 design control', (tester) async {
    await pumpCard(tester);

    expect(tester.getSize(find.byType(Switch)), const Size(44, 24));
  });

  testWidgets('dragging the ruler moves the price and the change together', (
    tester,
  ) async {
    final price = await pumpCard(tester);

    await tester.drag(find.byKey(rulerKey), const Offset(60, 0));
    await tester.pump();

    expect(double.parse(price.text), greaterThan(100));
    expect(double.parse(textOf(tester, changeKey)), greaterThan(0));
  });

  testWidgets('change is measured against the reference price, not the field', (
    tester,
  ) async {
    // A take profit already sat at 110 while the market is at 100.
    await pumpCard(tester, initial: '110', referencePrice: 100);

    expect(textOf(tester, changeKey), '10');
  });
}
