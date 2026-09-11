import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/hip3_live.dart';
import '../../domain/models/market_product.dart';
import 'hip3_live_provider.dart';
import 'hip3_live_scope.dart';
import 'session_scope.dart';

typedef Hip3MarketLiveRequest = ({MarketProductRef product, String? interval});

final hip3MarketLiveProvider = Provider.autoDispose
    .family<Hip3LiveConnection, Hip3MarketLiveRequest>((ref, request) {
      final product = request.product;
      if (!ref.watch(hip3LiveEnabledProvider) ||
          product.kind != MarketProductKind.perp ||
          product.productId == null ||
          product.environment == null) {
        return const Hip3LiveConnection(Hip3LivePhase.disabled);
      }
      final generation = ref.watch(sessionGenerationProvider).value;
      final identity = ref.watch(hip3LiveIdentityProvider);
      final value = identity.asData?.value;
      if (value == null || value.generation != generation) {
        return const Hip3LiveConnection(Hip3LivePhase.disabled);
      }
      return ref.watch(
        hip3LiveConnectionProvider((
          query: Hip3LiveQuery(
            signer: value.signer,
            environment: value.environment,
            channels: {
              'hip3:price:${product.environment}:${product.productId}',
              if (request.interval != null)
                'hip3:candle:${product.environment}:${request.interval}:${product.productId}',
            },
          ),
          generation: generation,
        )),
      );
    });
