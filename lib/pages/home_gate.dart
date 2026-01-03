import 'package:flutter/material.dart';

class HomeGate extends StatefulWidget {
  const HomeGate({super.key});

  @override
  State<HomeGate> createState() => _HomeGateState();
}

class _HomeGateState extends State<HomeGate> {
  final _prompt = TextEditingController();
  int _balance = 999;

  final List<_Template> _templates = const [
    _Template("Instagram Satış Postu", "Dokun – prompt dolsun"),
    _Template("Viral Reels Fikri", "Dokun – prompt dolsun"),
    _Template("SEO Blog Yazısı", "Dokun – prompt dolsun"),
    _Template("Ürün Açıklaması", "Dokun – prompt dolsun"),
    _Template("Görsel Prompt (Ultra)", "Dokun – prompt dolsun"),
    _Template("Marka Slogan + Bio", "Dokun – prompt dolsun"),
    _Template("Film Sahnesi", "Dokun – prompt dolsun"),
    _Template("Storyboard + Shotlist", "Dokun – prompt dolsun"),
  ];

  @override
  void dispose() {
    _prompt.dispose();
    super.dispose();
  }

  void _fillTemplate(_Template t) {
    setState(() {
      _prompt.text = "${t.title}\n\n";
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("LumiAI"),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: "Settings",
            onPressed: () {
              // TODO: Settings page (theme/locale) bağlanacak
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Settings: TODO")),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: cs.outlineVariant.withOpacity(0.5)),
                    ),
                    child: Row(
                      children: [
                        const Text("Your balance", style: TextStyle(fontWeight: FontWeight.w600)),
                        const Spacer(),
                        Text("$_balance", style: const TextStyle(fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: cs.outlineVariant.withOpacity(0.5)),
                  ),
                  child: const Text("Coins", style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 14),

            Text("Prompt", style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest.withOpacity(0.45),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: cs.outlineVariant.withOpacity(0.5)),
              ),
              child: TextField(
                controller: _prompt,
                minLines: 5,
                maxLines: 8,
                decoration: const InputDecoration(
                  hintText: "Type your request...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Text("Cost: 5 coins", style: TextStyle(color: cs.onSurfaceVariant)),
                const Spacer(),
              ],
            ),

            const SizedBox(height: 14),
            Text("Templates", style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),

            GridView.builder(
              itemCount: _templates.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.25,
              ),
              itemBuilder: (context, i) {
                final t = _templates[i];
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _fillTemplate(t),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: cs.outlineVariant.withOpacity(0.5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                        const Spacer(),
                        Text(t.subtitle, style: TextStyle(color: cs.onSurfaceVariant)),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: gerçek generate akışı
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Generate: TODO")),
                  );
                },
                child: const Text("Generate", style: TextStyle(fontWeight: FontWeight.w900)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Template {
  final String title;
  final String subtitle;
  const _Template(this.title, this.subtitle);
}
