import 'package:lumiai/core/supabase_client.dart';

class CharacterItem {
  final String id;
  final String name;

  const CharacterItem({required this.id, required this.name});
}

class AiCharacterService {
  static Future<List<CharacterItem>> fetchActiveCharacters() async {
    final res = await SB.client
        .from('ai_characters')
        .select('id,name,is_active')
        .eq('is_active', true)
        .order('created_at', ascending: true);

    final list = (res as List)
        .map((e) => e as Map<String, dynamic>)
        .map(
          (m) => CharacterItem(
            id: (m['id'] ?? '').toString(),
            name: (m['name'] ?? '').toString(),
          ),
        )
        .where((c) => c.id.isNotEmpty && c.name.isNotEmpty)
        .toList();

    return list;
  }

  static Future<void> setActiveCharacterForCurrentUser(
    String characterId,
  ) async {
    final user = SB.client.auth.currentUser;
    if (user == null) return;

    await SB.client.from('user_profiles').upsert({
      'user_id': user.id,
      'active_character_id': characterId,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }
}
