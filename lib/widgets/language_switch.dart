import 'package:flutter/material.dart';
import '../core/locale_scope.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final lc = LocaleScope.of(context);
    return Row(
      children: [
        TextButton(
          onPressed: () => lc.setLocale(const Locale('en')),
          child: const Text('EN'),
        ),
        TextButton(
          onPressed: () => lc.setLocale(const Locale('tr')),
          child: const Text('TR'),
        ),
      ],
    );
  }
}
