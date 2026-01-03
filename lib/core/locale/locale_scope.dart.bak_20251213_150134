import 'package:flutter/widgets.dart';
import 'locale_controller.dart';

class LocaleScope extends InheritedNotifier<LocaleController> {
  const LocaleScope({
    super.key,
    required LocaleController controller,
    required Widget child,
  }) : super(notifier: controller, child: child);

  static LocaleController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LocaleScope>();
    if (scope == null || scope.notifier == null) {
      throw StateError('LocaleScope not found');
    }
    return scope.notifier!;
  }
}
