import 'package:flutter/material.dart';
import 'package:lumiai/l10n_gen/app_localizations.dart';

import 'language_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> _openLanguage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LanguagePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    Widget card({required Widget child}) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withOpacity(0.06),
          border: Border.all(color: Colors.white.withOpacity(0.12)),
        ),
        child: child,
      );
    }

    Widget item({
      required IconData icon,
      required String title,
      String? subtitle,
      VoidCallback? onTap,
    }) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: subtitle == null ? null : Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Account',
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 10),
                  Text(l10n.guestNotSignedIn),
                ],
              ),
            ),
            const SizedBox(height: 14),
            card(
              child: Column(
                children: [
                  item(
                    icon: Icons.language,
                    title: l10n.languageTitle,
                    subtitle: '31 languages enabled',
                    onTap: _openLanguage,
                  ),
                  const Divider(height: 1),
                  item(
                    icon: Icons.palette_outlined,
                    title: 'Theme',
                    subtitle: 'Light / Dark',
                    onTap: null,
                  ),
                  const Divider(height: 1),
                  item(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                    subtitle: 'Coming soon',
                    onTap: null,
                  ),
                  const Divider(height: 1),
                  item(
                    icon: Icons.lock_outline,
                    title: 'Privacy',
                    subtitle: 'Coming soon',
                    onTap: null,
                  ),
                  const Divider(height: 1),
                  item(
                    icon: Icons.description_outlined,
                    title: 'Terms',
                    subtitle: 'Coming soon',
                    onTap: null,
                  ),
                  const Divider(height: 1),
                  item(
                    icon: Icons.info_outline,
                    title: 'About',
                    subtitle: 'LumiAI v1.0.0',
                    onTap: null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Actions',
                      style: TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: null,
                    child: Text(l10n.signOut),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
