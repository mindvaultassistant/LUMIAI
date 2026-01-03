import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lumiai/core/app_settings_controller.dart';
import 'package:lumiai/pages/setup/setup_sheet.dart';

class SetupGate extends StatefulWidget {
  final SharedPreferences prefs;
  final AppSettingsController controller;
  final Widget child;

  const SetupGate({
    super.key,
    required this.prefs,
    required this.controller,
    required this.child,
  });

  @override
  State<SetupGate> createState() => _SetupGateState();
}

class _SetupGateState extends State<SetupGate> {
  bool _opened = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_opened) return;
    _opened = true;

    final done = widget.prefs.getBool('setup_done_v1') ?? false;
    if (done) return;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black.withOpacity(0.55),
        builder: (_) => SetupSheet(
          prefs: widget.prefs,
          controller: widget.controller,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
