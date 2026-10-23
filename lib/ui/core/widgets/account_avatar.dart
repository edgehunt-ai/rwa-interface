import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

const _fallbackAvatarAsset = 'assets/figma/home_markets/account_avatar.webp';

class AccountAvatar extends StatelessWidget {
  const AccountAvatar({super.key, required this.avatarUri, this.size = 40});

  final Uri? avatarUri;
  final double size;

  @override
  Widget build(BuildContext context) {
    final url = avatarUri?.toString().trim();
    final fallback = Image.asset(_fallbackAvatarAsset, fit: BoxFit.cover);
    return SizedBox.square(
      dimension: size,
      child: url == null || url.isEmpty
          ? fallback
          : CachedNetworkImage(
              imageUrl: url,
              cacheKey: url,
              fit: BoxFit.cover,
              placeholder: (_, _) => fallback,
              errorWidget: (_, _, _) => fallback,
            ),
    );
  }
}
