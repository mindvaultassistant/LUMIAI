class AICharacter {
  final String id;
  final String slug;
  final String name;
  final String description;
  final String systemPrompt;

  AICharacter({
    required this.id,
    required this.slug,
    required this.name,
    required this.description,
    required this.systemPrompt,
  });

  factory AICharacter.fromMap(Map<String, dynamic> m) => AICharacter(
    id: (m['id'] ?? '').toString(),
    slug: (m['slug'] ?? '').toString(),
    name: (m['name'] ?? '').toString(),
    description: (m['description'] ?? '').toString(),
    systemPrompt: (m['system_prompt'] ?? '').toString(),
  );
}
