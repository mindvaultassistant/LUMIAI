import 'package:flutter/material.dart';
import 'package:lumiai/services/ai_character_service.dart';

class CharacterPicker extends StatefulWidget {
  final String? initialCharacterId;
  final ValueChanged<String>? onChanged;

  const CharacterPicker({super.key, this.initialCharacterId, this.onChanged});

  @override
  State<CharacterPicker> createState() => _CharacterPickerState();
}

class _CharacterPickerState extends State<CharacterPicker> {
  bool _loading = true;
  List<CharacterItem> _chars = const [];
  String? _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.initialCharacterId;
    _load();
  }

  Future<void> _load() async {
    try {
      final list = await AiCharacterService.fetchActiveCharacters();
      setState(() {
        _chars = list;
        if (_selectedId == null && _chars.isNotEmpty) {
          _selectedId = _chars.first.id;
        }
        _loading = false;
      });
    } catch (_) {
      setState(() {
        _chars = const [];
        _loading = false;
      });
    }
  }

  Future<void> _setAndSave(String id) async {
    setState(() => _selectedId = id);
    await AiCharacterService.setActiveCharacterForCurrentUser(id);
    widget.onChanged?.call(id);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const SizedBox(
        height: 48,
        child: Center(
          child: SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (_chars.isEmpty) {
      return const SizedBox(
        height: 48,
        child: Center(child: Text('No characters')),
      );
    }

    final selected = _selectedId ?? _chars.first.id;

    return SizedBox(
      height: 48,
      child: DropdownButtonFormField<String>(
        value: selected,
        isExpanded: true,
        decoration: const InputDecoration(
          labelText: 'Character',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        items: _chars
            .map(
              (c) => DropdownMenuItem<String>(
                value: c.id,
                child: Text(c.name, overflow: TextOverflow.ellipsis),
              ),
            )
            .toList(),
        onChanged: (v) {
          if (v == null) return;
          _setAndSave(v);
        },
      ),
    );
  }
}
