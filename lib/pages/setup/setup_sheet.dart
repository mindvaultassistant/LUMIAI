import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lumiai/core/app_settings_controller.dart';

class SetupSheet extends StatefulWidget {
  final SharedPreferences prefs;
  final AppSettingsController controller;

  const SetupSheet({
    super.key,
    required this.prefs,
    required this.controller,
  });

  @override
  State<SetupSheet> createState() => _SetupSheetState();
}

class _SetupSheetState extends State<SetupSheet> {
  String _lang = 'tr';
  ThemeMode _theme = ThemeMode.dark;

  @override
  void initState() {
    super.initState();

    // Eğer önceki ayar varsa onu baz al
    // (controller.value -> AppSettings; alan adlarını bilmediğimiz için minimal gidiyoruz)
    // Varsayılan: TR + Dark
  }

  Future<void> _applyAndClose() async {
    // Dil
    await widget.controller.setLocale(Locale(_lang));

    // Tema
    await widget.controller.setThemeMode(_theme);

    await widget.prefs.setBool('setup_done_v1', true);

    if (mounted) Navigator.of(context).pop();
  }

  Widget _pill({
    required bool selected,
    required Widget child,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? Colors.white : Colors.white24,
            width: 1,
          ),
          color: selected ? Colors.white.withOpacity(0.10) : Colors.white.withOpacity(0.04),
        ),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            color: selected ? Colors.white : Colors.white70,
            fontWeight: FontWeight.w600,
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final bottom = media.viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
        decoration: BoxDecoration(
          color: const Color(0xFF0B0F1A),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.55),
              blurRadius: 30,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '✨ LumiAI’ye Hoş Geldin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Deneyimini sana göre ayarlayalım.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.72),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Dil',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.82),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _pill(
                    selected: _lang == 'tr',
                    onTap: () => setState(() => _lang = 'tr'),
                    child: const Text('🇹🇷 Türkçe'),
                  ),
                  _pill(
                    selected: _lang == 'en',
                    onTap: () => setState(() => _lang = 'en'),
                    child: const Text('🇬🇧 English'),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Text(
                'Tema',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.82),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _pill(
                    selected: _theme == ThemeMode.dark,
                    onTap: () => setState(() => _theme = ThemeMode.dark),
                    child: const Text('🌙 Koyu'),
                  ),
                  _pill(
                    selected: _theme == ThemeMode.light,
                    onTap: () => setState(() => _theme = ThemeMode.light),
                    child: const Text('☀️ Açık'),
                  ),
                  _pill(
                    selected: _theme == ThemeMode.system,
                    onTap: () => setState(() => _theme = ThemeMode.system),
                    child: const Text('🖥️ Sistem'),
                  ),
                ],
              ),

              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _applyAndClose,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Devam Et',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Ayarları istediğin zaman değiştirebilirsin',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.55),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
