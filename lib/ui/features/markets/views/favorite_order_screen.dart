import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../providers/favorite_order_provider.dart';
import '../providers/market_providers.dart';

class FavoriteOrderScreen extends ConsumerStatefulWidget {
  const FavoriteOrderScreen({super.key});
  @override
  ConsumerState<FavoriteOrderScreen> createState() =>
      _FavoriteOrderScreenState();
}

class _FavoriteOrderScreenState extends ConsumerState<FavoriteOrderScreen> {
  bool _saveFailed = false;
  Future<void> _save() async {
    final session = ref.read(sessionGenerationProvider);
    final saved = await ref.read(favoriteOrderProvider.notifier).save();
    if (!mounted || session != ref.read(sessionGenerationProvider)) return;
    if (saved) {
      Navigator.of(context).pop();
    } else {
      setState(() => _saveFailed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final products = ref.watch(favoriteOrderProvider);
    final saving = ref.watch(favoritesCommandProvider).isLoading;
    ref.listen(sessionGenerationProvider, (_, _) {
      setState(() => _saveFailed = false);
    });
    final commands = ref.read(favoriteOrderProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.marketFavoritesReorder)),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(l10n.marketFavoritesCompleteSet),
            ),
            if (_saveFailed)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(l10n.marketFavoritesOrderChanged),
              ),
            Expanded(
              child: products.when(
                skipLoadingOnRefresh: false,
                loading: () => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 12),
                      Text(l10n.marketFavoritesLoadingAll),
                    ],
                  ),
                ),
                error: (_, _) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(l10n.marketFavoritesLoadFailed),
                      ),
                      TextButton(
                        onPressed: () => ref.invalidate(favoriteOrderProvider),
                        child: Text(l10n.portfolioRefresh),
                      ),
                    ],
                  ),
                ),
                data: (items) => items.isEmpty
                    ? Center(child: Text(l10n.marketFavoritesEmpty))
                    : ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final product = items[index];
                          return ListTile(
                            key: ValueKey(product.ref),
                            title: Text(
                              '${product.symbol} · ${product.kind == MarketProductKind.perp ? 'HIP3' : 'bStocks'}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  tooltip: l10n.marketFavoriteMoveUp,
                                  icon: const Icon(Icons.arrow_upward),
                                  onPressed: saving || index == 0
                                      ? null
                                      : () => commands.move(index, index - 1),
                                ),
                                IconButton(
                                  tooltip: l10n.marketFavoriteMoveDown,
                                  icon: const Icon(Icons.arrow_downward),
                                  onPressed: saving || index == items.length - 1
                                      ? null
                                      : () => commands.move(index, index + 1),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed:
                      saving ||
                          products.isLoading ||
                          products.hasError ||
                          (products.value?.length ?? 0) < 2
                      ? null
                      : _save,
                  child: Text(
                    saving
                        ? l10n.marketFavoritesSaving
                        : l10n.marketFavoritesSaveOrder,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
