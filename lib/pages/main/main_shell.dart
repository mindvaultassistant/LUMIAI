import 'package:flutter/material.dart';

class MainShellPage extends StatefulWidget {
  MainShellPage({super.key});

  @override
  State<MainShellPage> createState() => _MainShellPageState();
}

class _MainShellPageState extends State<MainShellPage> {
  final _prompt = TextEditingController();
  ThemeMode _themeMode = ThemeMode.dark;

  @override
  void dispose() {
    _prompt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final balance = '120';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0F17),
        title: const Text('LumiAI'),
        actions: [
          IconButton(
            onPressed: _openSettings,
            icon: const Icon(Icons.tune_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _balanceCard(balance: balance),
          const SizedBox(height: 12),
          _promptCard(controller: _prompt),
          const SizedBox(height: 12),
          _gridTemplates(),
          const SizedBox(height: 12),
          _primaryButton(
            text: 'Generate',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mock generate (no backend yet)')),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Future<void> _openSettings() async {
    if (!mounted) return;

    await showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0B0D12),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.tune_rounded, color: Colors.white),
                    const SizedBox(width: 10),
                    const Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Theme',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                _segmentedTheme(
                  current: _themeMode,
                  onChange: (m) {
                    setState(() => _themeMode = m);
                  },
                ),
                const SizedBox(height: 14),
                const Text(
                  'Language',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _pill(label: 'EN', onTap: () {}),
                    _pill(label: 'TR', onTap: () {}),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _pill({required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF151926),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF23283A)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

Widget _balanceCard({required String balance}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFF23283A)),
      color: const Color(0xFF0B0D12).withOpacity(0.78),
      boxShadow: const [
        BoxShadow(
          blurRadius: 24,
          spreadRadius: 0,
          offset: Offset(0, 10),
          color: Color(0x33000000),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              colors: [Color(0xFF2C7CFF), Color(0xFF7A5CFF)],
            ),
          ),
          child: const Icon(Icons.auto_awesome_rounded, color: Colors.white),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'Your balance',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          balance,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(width: 6),
        const Text(
          'Coins',
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}

Widget _promptCard({required TextEditingController controller}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFF23283A)),
      color: const Color(0xFF0B0D12).withOpacity(0.78),
      boxShadow: const [
        BoxShadow(
          blurRadius: 24,
          spreadRadius: 0,
          offset: Offset(0, 10),
          color: Color(0x33000000),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Prompt',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF151926),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF23283A)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: TextField(
            controller: controller,
            maxLines: 6,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Type your request...',
              hintStyle: TextStyle(color: Colors.white54),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Cost: 5 coins',
          style: TextStyle(
            color: Colors.white60,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget _gridTemplates() {
  final items = const [
    _TemplateItem(
      title: 'Image',
      subtitle: 'Cinematic',
      icon: Icons.image_rounded,
      prompt: 'Create a cinematic photo...',
    ),
    _TemplateItem(
      title: 'Text',
      subtitle: 'Copywriting',
      icon: Icons.text_fields_rounded,
      prompt: 'Write a product description...',
    ),
    _TemplateItem(
      title: 'Ideas',
      subtitle: '10 concepts',
      icon: Icons.lightbulb_rounded,
      prompt: 'Generate 10 ideas...',
    ),
    _TemplateItem(
      title: 'Prompt',
      subtitle: 'Ready-made',
      icon: Icons.auto_awesome_rounded,
      prompt: 'Make a premium prompt...',
    ),
  ];

  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: items.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.35,
    ),
    itemBuilder: (context, i) {
      final it = items[i];
      return _templateCard(
        title: it.title,
        subtitle: it.subtitle,
        icon: it.icon,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Mock template: ${it.prompt}')),
          );
        },
      );
    },
  );
}

Widget _templateCard({
  required String title,
  required String subtitle,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(18),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF23283A)),
        color: const Color(0xFF0B0D12).withOpacity(0.72),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color(0xFF151926),
              border: Border.all(color: const Color(0xFF23283A)),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white60,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _primaryButton({required String text, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(18),
    child: Container(
      height: 54,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF2C7CFF), Color(0xFF7A5CFF)],
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 26,
            offset: Offset(0, 12),
            color: Color(0x44000000),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
  );
}

Widget _segmentedTheme({
  required ThemeMode current,
  required ValueChanged<ThemeMode> onChange,
}) {
  Widget chip(String label, ThemeMode mode) {
    final selected = current == mode;
    return InkWell(
      onTap: () => onChange(mode),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF2C7CFF) : const Color(0xFF151926),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? const Color(0xFF2C7CFF) : const Color(0xFF23283A),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: [
      chip('System', ThemeMode.system),
      chip('Dark', ThemeMode.dark),
      chip('Light', ThemeMode.light),
    ],
  );
}

class _TemplateItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String prompt;
  const _TemplateItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.prompt,
  });
}
