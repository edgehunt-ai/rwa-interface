import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/ui/features/orders/views/tp_sl_editor_card.dart';

import '../../../../helpers/test_app.dart';

void main() {
  const priceKey = Key('tp-price');
  const changeKey = Key('tp-change');
  const rulerKey = Key('tp-ruler');

  Future<TextEditingController> pumpCard(
    WidgetTester tester, {
    String initial = '100',
    double? referencePrice,
    ValueNotifier<double?>? referencePriceListenable,
    bool isLong = true,
    bool isTakeProfit = true,
    bool enabled = true,
  }) async {
    final price = TextEditingController(text: initial);
    addTearDown(price.dispose);
    await tester.pumpWidget(
      buildTestApp(
        TpSlEditorCard(
          title: isTakeProfit ? 'Take Profit' : 'Stop Loss',
          isLong: isLong,
          isTakeProfit: isTakeProfit,
          controller: price,
          enabled: enabled,
          onEnabledChanged: (_) {},
          referencePrice: referencePrice,
          referencePriceListenable: referencePriceListenable,
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
    expect(find.text('Win'), findsOneWidget);
    expect(find.text('Change'), findsNothing);
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

    await tester.enterText(find.byKey(changeKey), '5');
    await tester.pump();

    expect(price.text, '105');
    // The binding settles instead of ping-ponging between the two fields.
    expect(textOf(tester, changeKey), '5');
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

  testWidgets('right drag at the minimum keeps the ratio at zero', (
    tester,
  ) async {
    final price = await pumpCard(tester);

    await tester.drag(find.byKey(rulerKey), const Offset(60, 0));
    await tester.pump();

    expect(price.text, '100');
    expect(textOf(tester, changeKey), '0');
  });

  testWidgets('left drag increases the expected win from the current value', (
    tester,
  ) async {
    final price = await pumpCard(tester);
    final ruler = find.byKey(rulerKey);

    await tester.drag(ruler, const Offset(-60, 0));
    await tester.pump();

    expect(double.parse(price.text), greaterThan(100));
    expect(double.parse(textOf(tester, changeKey)), greaterThan(0));
  });

  testWidgets('empty trigger ruler starts from the current reference price', (
    tester,
  ) async {
    final price = await pumpCard(tester, initial: '', referencePrice: 100);

    await tester.drag(find.byKey(rulerKey), const Offset(-60, 0));
    await tester.pump();

    expect(double.parse(price.text), greaterThan(100));
  });

  for (final isLong in [true, false]) {
    for (final isTakeProfit in [true, false]) {
      final rises = isLong == isTakeProfit;
      final label = isTakeProfit ? 'Win' : 'Loss';
      testWidgets(
        '$label 10% calculates the ${isLong ? 'Long' : 'Short'} trigger',
        (tester) async {
          final price = await pumpCard(
            tester,
            referencePrice: 100,
            isLong: isLong,
            isTakeProfit: isTakeProfit,
          );
          expect(find.text(label), findsOneWidget);
          expect(textOf(tester, changeKey), '0');
          expect(find.text('Change'), findsNothing);

          await tester.enterText(find.byKey(changeKey), '10');
          await tester.pump();
          expect(price.text, rises ? '110' : '90');

          await tester.enterText(
            find.byKey(priceKey),
            rises ? '112.5' : '87.5',
          );
          await tester.pump();
          expect(textOf(tester, changeKey), '12.5');

          await tester.drag(find.byKey(rulerKey), const Offset(-120, 0));
          await tester.pump();
          final nextPrice = double.parse(price.text);
          expect(textOf(tester, changeKey), matches(RegExp(r'^\d+$')));
          expect(nextPrice, rises ? greaterThan(112.5) : lessThan(87.5));
          expect(double.parse(textOf(tester, changeKey)), greaterThan(12.5));
          await tester.drag(find.byKey(rulerKey), const Offset(60, 0));
          await tester.pump();
          expect(
            double.parse(price.text),
            rises ? lessThan(nextPrice) : greaterThan(nextPrice),
          );
          expect(
            double.parse(textOf(tester, changeKey)),
            greaterThanOrEqualTo(0),
          );

          final ruler = find.byKey(rulerKey);
          await tester.drag(ruler, Offset(tester.getSize(ruler).width * 2, 0));
          await tester.pump();
          expect(textOf(tester, changeKey), '0');
          expect(price.text, '100');

          await tester.drag(ruler, const Offset(-30, 0));
          await tester.pump();
          expect(double.parse(textOf(tester, changeKey)), greaterThan(0));
          expect(
            double.parse(price.text),
            rises ? greaterThan(100) : lessThan(100),
          );
        },
      );
    }
  }

  for (final isLong in [true, false]) {
    for (final isTakeProfit in [true, false]) {
      final rises = isLong == isTakeProfit;
      testWidgets(
        'wrong-direction price has no positive ratio: long=$isLong tp=$isTakeProfit',
        (tester) async {
          final price = await pumpCard(
            tester,
            referencePrice: 100,
            isLong: isLong,
            isTakeProfit: isTakeProfit,
          );
          await tester.enterText(find.byKey(priceKey), rises ? '90' : '110');
          await tester.pump();
          final ratio = tester.widget<TextField>(find.byKey(changeKey));
          expect(ratio.controller!.text, isEmpty);
          expect(ratio.decoration!.hintText, '—');
          expect(ratio.decoration!.suffixText, isNull);
          expect(price.text, rises ? '90' : '110');

          await tester.enterText(find.byKey(changeKey), '10');
          await tester.pump();
          expect(price.text, rises ? '110' : '90');
          expect(textOf(tester, changeKey), '10');
          expect(
            tester
                .widget<TextField>(find.byKey(changeKey))
                .decoration!
                .suffixText,
            '%',
          );
        },
      );
    }
  }

  testWidgets(
    'reference movement clears a ratio that now has the wrong direction',
    (tester) async {
      final reference = ValueNotifier<double?>(100);
      addTearDown(reference.dispose);
      await pumpCard(
        tester,
        initial: '110',
        referencePriceListenable: reference,
      );
      expect(textOf(tester, changeKey), '10');
      reference.value = 120;
      await tester.pump();
      expect(textOf(tester, changeKey), isEmpty);
      expect(
        tester.widget<TextField>(find.byKey(changeKey)).decoration!.hintText,
        '—',
      );
      reference.value = 100;
      await tester.pump();
      expect(textOf(tester, changeKey), '10');
    },
  );

  testWidgets('ratios reject signs and malformed numbers but allow decimals', (
    tester,
  ) async {
    final price = await pumpCard(tester);
    final field = find.byKey(changeKey);
    expect(tester.widget<TextField>(field).keyboardType.signed, isFalse);
    await tester.enterText(field, '2.5');
    await tester.pump();
    expect(price.text, '102.5');
    for (final invalid in ['-5', '+5', '1e2', 'NaN', 'Infinity', '1.2.3']) {
      await tester.enterText(field, invalid);
      await tester.pump();
      expect(textOf(tester, changeKey), '2.5');
      expect(price.text, '102.5');
    }
    await tester.enterText(field, '0.5');
    await tester.pump();
    expect(price.text, '100.5');
  });

  testWidgets('manual ratio decimals are preserved until the user drags', (
    tester,
  ) async {
    final price = await pumpCard(tester);
    await tester.enterText(find.byKey(changeKey), '5.123456789');
    await tester.pump();
    expect(textOf(tester, changeKey), '5.123456789');
    expect(price.text, '105.12');

    await tester.drag(find.byKey(rulerKey), const Offset(-60, 0));
    await tester.pump();
    final ratio = textOf(tester, changeKey);
    expect(ratio, matches(RegExp(r'^\d+$')));
    expect(double.parse(price.text), 100 + int.parse(ratio));
  });

  for (final isLong in [true, false]) {
    for (final isTakeProfit in [true, false]) {
      testWidgets(
        'drag truncates ratio and price: long=$isLong tp=$isTakeProfit',
        (tester) async {
          final price = await pumpCard(
            tester,
            initial: '100.75',
            referencePrice: 100.75,
            isLong: isLong,
            isTakeProfit: isTakeProfit,
          );
          tester.widget<TpSlTickRuler>(find.byKey(rulerKey)).onChanged(10.99);
          await tester.pump();
          expect(textOf(tester, changeKey), '10');
          expect(price.text, isLong == isTakeProfit ? '110' : '90');

          await tester.enterText(
            find.byKey(priceKey),
            isLong == isTakeProfit ? '112.123456789' : '89.123456789',
          );
          await tester.pump();
          expect(
            price.text,
            isLong == isTakeProfit ? '112.123456789' : '89.123456789',
          );
          await tester.enterText(find.byKey(changeKey), '10.123456789');
          await tester.pump();
          expect(textOf(tester, changeKey), '10.123456789');
          expect(price.text, contains('.'));
        },
      );
    }
  }

  testWidgets(
    'integer trigger truncation avoids floating point off-by-one errors',
    (tester) async {
      final price = await pumpCard(tester, isTakeProfit: false);
      tester.widget<TpSlTickRuler>(find.byKey(rulerKey)).onChanged(80.99);
      await tester.pump();
      expect(textOf(tester, changeKey), '80');
      expect(price.text, '20');
      tester.widget<TpSlTickRuler>(find.byKey(rulerKey)).onChanged(90.99);
      await tester.pump();
      expect(textOf(tester, changeKey), '90');
      expect(price.text, '10');
    },
  );

  testWidgets('clearing a ratio clears its stale trigger', (tester) async {
    final price = await pumpCard(tester, initial: '110', referencePrice: 100);
    await tester.enterText(find.byKey(changeKey), '');
    await tester.pump();
    expect(price.text, isEmpty);
  });

  testWidgets('falling triggers stay positive on input and long left drags', (
    tester,
  ) async {
    final price = await pumpCard(tester, isTakeProfit: false);
    await tester.enterText(find.byKey(changeKey), '10');
    await tester.pump();
    await tester.enterText(find.byKey(changeKey), '100');
    await tester.pump();
    expect(textOf(tester, changeKey), '10');
    expect(price.text, '90');

    final ruler = find.byKey(rulerKey);
    await tester.drag(ruler, Offset(-tester.getSize(ruler).width * 2, 0));
    await tester.pump();
    expect(double.parse(price.text), greaterThan(0));
    expect(double.parse(price.text), lessThan(90));
  });

  testWidgets(
    'live reference updates drive both ratio and trigger calculation',
    (tester) async {
      final reference = ValueNotifier<double?>(100);
      addTearDown(reference.dispose);
      final price = await pumpCard(
        tester,
        initial: '110',
        referencePrice: 100,
        referencePriceListenable: reference,
      );
      expect(textOf(tester, changeKey), '10');
      reference.value = 110;
      await tester.pump();
      expect(textOf(tester, changeKey), '0');
      await tester.enterText(find.byKey(changeKey), '10');
      await tester.pump();
      expect(price.text, '121');
    },
  );

  testWidgets(
    'reversing direction during a drag reduces the ratio above the minimum',
    (tester) async {
      final price = await pumpCard(tester, initial: '110', referencePrice: 100);
      final gesture = await tester.startGesture(
        tester.getCenter(find.byKey(rulerKey)),
      );
      await gesture.moveBy(const Offset(-180, 0));
      await tester.pump();
      final leftPrice = price.text;
      await gesture.moveBy(const Offset(160, 0));
      await tester.pump();
      expect(double.parse(price.text), lessThan(double.parse(leftPrice)));
      expect(double.parse(textOf(tester, changeKey)), greaterThanOrEqualTo(0));
      await gesture.up();
    },
  );

  testWidgets('disabled TP/SL does not respond to left drags', (tester) async {
    final price = await pumpCard(tester, enabled: false);
    await tester.drag(find.byKey(rulerKey), const Offset(-60, 0));
    await tester.pump();
    expect(price.text, '100');
    expect(tester.widget<TextField>(find.byKey(changeKey)).enabled, isFalse);
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

  testWidgets('unbounded ruler ticks visibly move while dragging', (
    tester,
  ) async {
    var draggedValue = 100.0;
    await tester.pumpWidget(
      buildTestApp(
        TpSlTickRuler(
          key: rulerKey,
          semanticLabel: 'Price',
          value: 100,
          minimum: 0,
          maximum: 110,
          divisions: 20,
          unbounded: true,
          onChanged: (value) => draggedValue = value,
        ),
      ),
    );

    final gesture = await tester.startGesture(
      tester.getCenter(find.byKey(rulerKey)),
    );
    await gesture.moveBy(const Offset(-60, 0));
    await tester.pump();

    final customPaint = find.descendant(
      of: find.byKey(rulerKey),
      matching: find.byType(CustomPaint),
    );
    final painter = tester.widget<CustomPaint>(customPaint).painter as dynamic;
    expect(painter.value, draggedValue);
    expect(painter.minimum, 0);
    expect(painter.maximum, 110);
    expect(draggedValue / (110 / 20), isNot(equals(20)));
    expect(customPaint, paints..rect());
    await gesture.up();
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
