import 'package:flutter/material.dart';
import '../models/ppe_data.dart';
import '../services/tts_service.dart';

class CategoryScreen extends StatefulWidget {
  final PpeCategory category;

  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final Map<String, bool> _checkedItems = {};
  final TtsService _tts = TtsService();
  bool _allDone = false;

  @override
  void initState() {
    super.initState();
    _speakNextItem();
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  List<String> get items => widget.category.items;
  bool get isEndOfShift => widget.category.name == 'Travel Home';

  int get checkedCount =>
      _checkedItems.values.where((v) => v == true).length;

  void _speakNextItem() {
    for (final item in items) {
      if (!(_checkedItems[item] ?? false)) {
        final phrase = _tts.buildPhrase(widget.category.name, item);
        _tts.speak(phrase);
        return;
      }
    }
  }

  void _onItemTap(String item) {
    final wasChecked = _checkedItems[item] ?? false;
    setState(() {
      _checkedItems[item] = !wasChecked;
    });

    if (!wasChecked) {
      // Just checked an item — speak the next unchecked one
      final allChecked = items.every((i) => _checkedItems[i] ?? false);
      if (allChecked) {
        setState(() => _allDone = true);
        _tts.speak(isEndOfShift
            ? 'All done! Drive safe out there.'
            : 'All clear! Stay safe.');
      } else {
        _speakNextItem();
      }
    }
  }

  void _reset() {
    setState(() {
      _checkedItems.clear();
      _allDone = false;
    });
    _speakNextItem();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = isEndOfShift ? Colors.blueGrey[300]! : Colors.amber;
    final progress = items.isEmpty ? 0.0 : checkedCount / items.length;

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Icon(widget.category.icon, color: accentColor, size: 22),
            const SizedBox(width: 10),
            Text(
              widget.category.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white54),
            tooltip: 'Reset',
            onPressed: _reset,
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress section
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _allDone
                          ? isEndOfShift
                              ? '✓ All done — drive safe!'
                              : '✓ All clear!'
                          : 'Check each item before proceeding',
                      style: TextStyle(
                        color: _allDone ? accentColor : Colors.white54,
                        fontSize: 13,
                        fontWeight:
                            _allDone ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    Text(
                      '$checkedCount / ${items.length}',
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: Colors.white12,
                    valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                  ),
                ),
              ],
            ),
          ),

          // Items list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isChecked = _checkedItems[item] ?? false;
                return _PpeItemTile(
                  item: item,
                  isChecked: isChecked,
                  accentColor: accentColor,
                  onTap: () => _onItemTap(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PpeItemTile extends StatelessWidget {
  final String item;
  final bool isChecked;
  final Color accentColor;
  final VoidCallback onTap;

  const _PpeItemTile({
    required this.item,
    required this.isChecked,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isChecked
              ? accentColor.withOpacity(0.12)
              : const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isChecked ? accentColor.withOpacity(0.5) : Colors.white12,
            width: 1.5,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onTap,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Row(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      isChecked
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_unchecked_rounded,
                      key: ValueKey(isChecked),
                      color: isChecked ? accentColor : Colors.white24,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        color:
                            isChecked ? Colors.white54 : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: isChecked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: Colors.white38,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
