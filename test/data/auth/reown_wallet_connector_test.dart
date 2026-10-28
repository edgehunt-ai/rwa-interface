import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/config/privy_configuration.dart';
import 'package:nobell/data/auth/reown_wallet_connector.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:reown_appkit/reown_appkit.dart';

void main() {
  Future<BuildContext> mount(WidgetTester tester) async {
    late BuildContext context;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (value) {
            context = value;
            return const SizedBox();
          },
        ),
      ),
    );
    return context;
  }

  ReownWalletConnector connector(_Modal modal) => ReownWalletConnector(
    const ReownConfiguration(projectId: 'test-project'),
    createModal: (context) => modal..context = context,
  );

  testWidgets('does not toggle an already open SDK modal', (tester) async {
    final context = await mount(tester);
    final modal = _Modal()..isOpen = true;
    await expectLater(
      connector(modal).connect(context),
      throwsA(
        isA<IdentityFailure>().having(
          (e) => e.reason,
          'reason',
          contains('already open'),
        ),
      ),
    );
    expect(modal.opens, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('concurrent connects share one initialization and open', (
    tester,
  ) async {
    final context = await mount(tester);
    final barrier = Completer<void>();
    final modal = _Modal()..onOpen = () => barrier.future;
    final adapter = connector(modal);
    final first = adapter.connect(context);
    final second = adapter.connect(context);
    expect(identical(first, second), isTrue);
    final check = expectLater(first, throwsA(isA<IdentityFailure>()));
    await tester.pump();
    expect(modal.opens, 1);
    expect(modal.inits, 1);
    barrier.complete();
    await check;
    expect(tester.takeException(), isNull);
  });

  testWidgets('async-void SDK failure returns its cause and allows retry', (
    tester,
  ) async {
    final context = await mount(tester);
    final modal = _Modal()
      ..onOpen = () async {
        // Reproduce Reown 1.9.0 closeModal -> _close -> WidgetStack.getCurrent.
        void close() async {
          throw StateError('No element');
        }

        close();
        await Future<void>.value();
      };
    final adapter = connector(modal);
    await expectLater(
      adapter.connect(context),
      throwsA(
        isA<IdentityFailure>().having((e) => e.reason, 'reason', 'No element'),
      ),
    );
    modal.onOpen = null;
    await expectLater(
      adapter.connect(context),
      throwsA(
        isA<IdentityFailure>().having(
          (e) => e.reason,
          'reason',
          contains('not completed'),
        ),
      ),
    );
    expect(modal.opens, 2);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'SDK failure retains a safe reason without stack or credentials',
    (tester) async {
      final context = await mount(tester);
      final modal = _Modal()
        ..onOpen = () async {
          throw Exception('Relay unavailable token=secret\nat internal.frame');
        };
      await expectLater(
        connector(modal).connect(context),
        throwsA(
          isA<IdentityFailure>().having(
            (e) => e.reason,
            'reason',
            'Exception: Relay unavailable token=<redacted>',
          ),
        ),
      );
    },
  );

  testWidgets('closed screen cannot open the wallet modal', (tester) async {
    final context = await mount(tester);
    await tester.pumpWidget(const SizedBox());
    final modal = _Modal();
    await expectLater(
      connector(modal).connect(context),
      throwsA(isA<IdentityFailure>()),
    );
    expect(modal.inits, 0);
  });
}

class _Modal implements ReownAppKitModal {
  BuildContext? context;
  int opens = 0;
  int inits = 0;
  Future<void> Function()? onOpen;

  @override
  bool isOpen = false;
  @override
  bool get isConnected => false;
  @override
  BuildContext? get modalContext => context?.mounted == true ? context : null;
  @override
  ReownAppKitModalSession? get session => null;
  @override
  ReownAppKitModalNetworkInfo? get selectedChain => null;
  @override
  Future<void> init() async {
    inits++;
  }

  @override
  Future<void> openModalView([Widget? startWidget]) async {
    opens++;
    await onOpen?.call();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
