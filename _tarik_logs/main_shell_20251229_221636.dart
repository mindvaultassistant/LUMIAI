import 'package:flutter/material.dart';

class MainShellPage extends StatefulWidget {
  const MainShellPage({super.key});

  @override
  State<MainShellPage> createState() => _MainShellPageState();
}

class _MainShellPageState extends State<MainShellPage> {
  int _tab = 0;

  final _prompt = TextEditingController();
  String _mode = "Photo";
  double _balance = 128.0;

  @override
  void dispose() {
    _prompt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      _HomeTab(
        prompt: _prompt,
        mode: _mode,
        balance: _balance,
        onModeChanged: (v) => setState(() => _mode = v),
        onBalanceChanged: (v) => setState(() => _balance = v),
        onGenerate: () {
          FocusScope.of(context).unfocus();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Generate: pipeline hazır (UI temel akış)"),
            ),
          );
        },
      ),
      const _CreateTab(),
      const _LibraryTab(),
      const _MarketTab(),
      const _SettingsTab(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0B0D14),
      body: SafeArea(child: pages[_tab]),
      bottomNavigationBar: _BottomBar(
        index: _tab,
        onChanged: (i) => setState(() => _tab = i),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab({
    required this.prompt,
    required this.mode,
    required this.balance,
    required this.onModeChanged,
    required this.onBalanceChanged,
    required this.onGenerate,
  });

  final TextEditingController prompt;
  final String mode;
  final double balance;
  final ValueChanged<String> onModeChanged;
  final ValueChanged<double> onBalanceChanged;
  final VoidCallback onGenerate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopHeader(balance: balance),
          const SizedBox(height: 14),
          _HeroCard(
            title: "Premium Ultra",
            subtitle: "Rakiplerden hafif, ama prod-ready temel yapı.",
            right: const Icon(Icons.auto_awesome_rounded, color: Colors.white),
          ),
          const SizedBox(height: 14),
          _SectionTitle(title: "Create"),
          const SizedBox(height: 10),
          _PromptCard(
            controller: prompt,
            mode: mode,
            onModeChanged: onModeChanged,
          ),
          const SizedBox(height: 12),
          _QuickActionsRow(),
          const SizedBox(height: 14),
          _GenerateButton(onTap: onGenerate),
          const SizedBox(height: 18),
          _SectionTitle(title: "Essentials"),
          const SizedBox(height: 10),
          _EssentialsGrid(),
          const SizedBox(height: 18),
          _SectionTitle(title: "Recent"),
          const SizedBox(height: 10),
          _RecentList(),
          const SizedBox(height: 18),
          _SectionTitle(title: "Balance"),
          const SizedBox(height: 10),
          _BalanceCard(value: balance, onChanged: onBalanceChanged),
        ],
      ),
    );
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader({required this.balance});
  final double balance;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _LumiBadge(),
        const Spacer(),
        _Pill(icon: Icons.bolt_rounded, text: "${balance.toStringAsFixed(0)}"),
        const SizedBox(width: 10),
        const _Pill(icon: Icons.notifications_none_rounded, text: " "),
      ],
    );
  }
}

class _LumiBadge extends StatelessWidget {
  const _LumiBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF12172A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF23283A)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.blur_on_rounded, color: Colors.white, size: 18),
          SizedBox(width: 8),
          Text(
            "LumiAI",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF12172A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF23283A)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          if (text.trim().isNotEmpty) ...[
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.title,
    required this.subtitle,
    required this.right,
  });

  final String title;
  final String subtitle;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF171C31), Color(0xFF0F1220)],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF2B3150)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF23283A),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(child: right),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w900,
        fontSize: 14,
        letterSpacing: 0.2,
      ),
    );
  }
}

class _PromptCard extends StatelessWidget {
  const _PromptCard({
    required this.controller,
    required this.mode,
    required this.onModeChanged,
  });

  final TextEditingController controller;
  final String mode;
  final ValueChanged<String> onModeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF12172A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF23283A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.tune_rounded, color: Colors.white70, size: 18),
              const SizedBox(width: 8),
              const Text(
                "Mode",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              _ModeDropdown(value: mode, onChanged: onModeChanged),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            minLines: 3,
            maxLines: 6,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              hintText:
                  "Prompt yaz… (ör: neon premium avatar, cinematic light, ultra detail)",
              hintStyle: const TextStyle(
                color: Colors.white38,
                fontWeight: FontWeight.w700,
              ),
              filled: true,
              fillColor: const Color(0xFF0E1120),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFF23283A)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFF23283A)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFF4B57FF),
                  width: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const _HintRow(),
        ],
      ),
    );
  }
}

class _ModeDropdown extends StatelessWidget {
  const _ModeDropdown({required this.value, required this.onChanged});
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1120),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF23283A)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: const Color(0xFF0E1120),
          iconEnabledColor: Colors.white70,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
          items: const [
            DropdownMenuItem(value: "Photo", child: Text("Photo")),
            DropdownMenuItem(value: "Avatar", child: Text("Avatar")),
            DropdownMenuItem(value: "Video", child: Text("Video")),
            DropdownMenuItem(value: "Voice", child: Text("Voice")),
          ],
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

class _HintRow extends StatelessWidget {
  const _HintRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: const [
        _Chip(text: "Ultra"),
        _Chip(text: "Cinematic"),
        _Chip(text: "Clean face"),
        _Chip(text: "4K"),
        _Chip(text: "No blur"),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1120),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFF23283A)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w900,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _QuickAction(
            icon: Icons.photo_camera_back_rounded,
            text: "Import",
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _QuickAction(icon: Icons.layers_rounded, text: "Templates"),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _QuickAction(icon: Icons.shield_rounded, text: "Safe"),
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF12172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF23283A)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white70, size: 18),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _GenerateButton extends StatelessWidget {
  const _GenerateButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF4B57FF), Color(0xFF8A3FFC)],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              blurRadius: 22,
              offset: Offset(0, 10),
              color: Color(0x332B33FF),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            "GENERATE",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

class _EssentialsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Row(
          children: [
            Expanded(
              child: _MiniCard(
                title: "Avatar",
                subtitle: "Face + style",
                icon: Icons.face_retouching_natural_rounded,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _MiniCard(
                title: "Video",
                subtitle: "Short / Reel",
                icon: Icons.movie_creation_rounded,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _MiniCard(
                title: "Voice",
                subtitle: "TTS / Clone",
                icon: Icons.graphic_eq_rounded,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _MiniCard(
                title: "Market+",
                subtitle: "Packs",
                icon: Icons.storefront_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MiniCard extends StatelessWidget {
  const _MiniCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF12172A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF23283A)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF0E1120),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF23283A)),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    color: Colors.white54,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Colors.white54),
        ],
      ),
    );
  }
}

class _RecentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = const [
      ("Neon avatar", "Avatar • Ultra"),
      ("Cinematic product", "Photo • Clean"),
      ("Short reel", "Video • 9:16"),
    ];

    return Column(
      children: [
        for (final it in items) ...[
          _RecentItem(title: it.$1, subtitle: it.$2),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _RecentItem extends StatelessWidget {
  const _RecentItem({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF12172A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF23283A)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF0E1120),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF23283A)),
            ),
            child: const Icon(
              Icons.image_rounded,
              color: Colors.white70,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    color: Colors.white54,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.more_horiz_rounded, color: Colors.white54),
        ],
      ),
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.value, required this.onChanged});
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF12172A),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF23283A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Token",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          Text(
            value.toStringAsFixed(0),
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w900,
              fontSize: 22,
            ),
          ),
          Slider(
            value: value.clamp(0, 999),
            min: 0,
            max: 999,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.index, required this.onChanged});
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0B0D14),
        border: Border(top: BorderSide(color: Color(0xFF23283A))),
      ),
      child: BottomNavigationBar(
        currentIndex: index,
        onTap: onChanged,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0B0D14),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded),
            label: "Create",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_rounded),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_rounded),
            label: "Market",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

class _CreateTab extends StatelessWidget {
  const _CreateTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Create (temel yapı hazır)",
        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _LibraryTab extends StatelessWidget {
  const _LibraryTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Library (history/outputs)",
        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _MarketTab extends StatelessWidget {
  const _MarketTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Market+ (packs/templates)",
        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _SettingsTab extends StatelessWidget {
  const _SettingsTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Settings (i18n / account / premium)",
        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w900),
      ),
    );
  }
}
