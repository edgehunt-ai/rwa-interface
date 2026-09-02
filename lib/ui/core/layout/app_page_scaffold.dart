import 'package:flutter/material.dart';

class AppPageScaffold extends StatelessWidget {
  const AppPageScaffold({
    super.key,
    required this.body,
    this.title,
    this.bottomAction,
    this.scrollable = false,
  });

  final Widget body;
  final String? title;
  final Widget? bottomAction;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final content = scrollable
        ? SingleChildScrollView(
            padding: EdgeInsets.only(bottom: viewInsets.bottom),
            child: body,
          )
        : Padding(
            padding: EdgeInsets.only(bottom: viewInsets.bottom),
            child: body,
          );

    return Scaffold(
      appBar: title == null ? null : AppBar(title: Text(title!)),
      body: SafeArea(child: content),
      bottomNavigationBar: bottomAction == null
          ? null
          : SafeArea(minimum: const EdgeInsets.all(16), child: bottomAction!),
    );
  }
}
