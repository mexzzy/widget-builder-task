import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:re_editor/re_editor.dart';

class DartCodeEditor extends StatefulWidget {
  const DartCodeEditor({super.key});

  @override
  State<DartCodeEditor> createState() => _DartCodeEditorState();
}

class _DartCodeEditorState extends State<DartCodeEditor> {
  late CodeLineEditingController _controller;

  final String dartCode = """import 'package:flutter/material.dart';

class Step {
  final String title;
  final String? description;
  final bool isCompleted;
  final bool isActive;
  final String? floatLabel;
  final Icon? floatIcon;
  final Widget? content;
  
  const Step({
    required this.title,
    this.description,
    this.isCompleted = false,
    this.isActive = false,
    this.floatLabel,
    this.floatIcon,
    this.content,
  });
  
  Step copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    bool? isActive,
    String? floatLabel,
    Icon? floatIcon,
    Widget? content,
  }) {
    return Step(
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isActive: isActive ?? this.isActive,
      floatLabel: floatLabel ?? this.floatLabel,
      floatIcon: floatIcon ?? this.floatIcon,
      content: content ?? this.content,
    );
  }
}""";

  @override
  void initState() {
    super.initState();
    _controller = CodeLineEditingController.fromText(dartCode);

    // Listen to text changes
    _controller.addListener(() {
      debugPrint('Code changed: ${_controller.text.length} characters');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _formatCode() {
    // Basic Dart code formatting
    String currentText = _controller.text;
    String formattedText = _formatDartCode(currentText);
    _controller.text = formattedText;
  }

  String _formatDartCode(String code) {
    List<String> lines = code.split('\n');
    List<String> formattedLines = [];
    int indentLevel = 0;

    for (String line in lines) {
      String trimmed = line.trim();
      if (trimmed.isEmpty) {
        formattedLines.add('');
        continue;
      }

      // Decrease indent for closing braces
      if (trimmed.startsWith('}')) {
        indentLevel = (indentLevel - 1).clamp(0, double.infinity).toInt();
      }

      // Add indentation
      String indent = '  ' * indentLevel;
      formattedLines.add('$indent$trimmed');

      // Increase indent for opening braces
      if (trimmed.endsWith('{') || trimmed.endsWith('({')) {
        indentLevel++;
      }
    }

    return formattedLines.join('\n');
  }

  void _handleKeyEvent(KeyEvent event) {
    // Handle keyboard shortcuts
    if (event is KeyDownEvent) {
      final isControlPressed = HardwareKeyboard.instance
              .isLogicalKeyPressed(LogicalKeyboardKey.control) ||
          HardwareKeyboard.instance
              .isLogicalKeyPressed(LogicalKeyboardKey.meta);
      final isShiftPressed = HardwareKeyboard.instance
          .isLogicalKeyPressed(LogicalKeyboardKey.shift);

      if (isControlPressed && event.logicalKey == LogicalKeyboardKey.keyS) {
        _formatCode();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Code formatted and saved!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } else if (isControlPressed &&
          isShiftPressed &&
          event.logicalKey == LogicalKeyboardKey.keyF) {
        _formatCode();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Code formatted!'),
            backgroundColor: Colors.blue,
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: _handleKeyEvent,
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1117),
        appBar: AppBar(
          title: const Text('Dart Code Editor - step.dart'),
          backgroundColor: const Color(0xFF21262D),
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: _formatCode,
              icon: const Icon(Icons.auto_fix_high),
              tooltip: 'Format Code (Ctrl+Shift+F)',
            ),
            IconButton(
              onPressed: () {
                // Copy to clipboard
                Clipboard.setData(ClipboardData(text: _controller.text));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Code copied to clipboard!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              icon: const Icon(Icons.copy),
              tooltip: 'Copy Code',
            ),
            IconButton(
              onPressed: () {
                _formatCode();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Code saved successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              icon: const Icon(Icons.save),
              tooltip: 'Save File (Ctrl+S)',
            ),
          ],
        ),
        body: Column(
          children: [
            // File tabs simulation
            Container(
              height: 40,
              color: const Color(0xFF1C2128),
              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF0D1117),
                      border: Border(
                        right: BorderSide(color: Color(0xFF30363D), width: 1),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.code,
                          size: 16,
                          color: Colors.blue[300],
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'step.dart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Editor area
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1117),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF30363D),
                    width: 1,
                  ),
                ),
                child: CodeEditor(
                  controller: _controller,
                  style: CodeEditorStyle(
                    // Basic styling that should work
                    fontSize: 14,
                    backgroundColor: const Color(0xFF0D1117),
                    selectionColor:
                        const Color(0xFF264F78).withValues(alpha: 0.4),
                    cursorColor: const Color(0xFFE6EDF3),
                  ),
                  onChanged: (text) {
                    // Handle text changes
                  },
                ),
              ),
            ),
          ],
        ),

        // Status bar
        bottomNavigationBar: Container(
          height: 30,
          color: const Color(0xFF21262D),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Icon(
                Icons.circle,
                color: Colors.green,
                size: 8,
              ),
              const SizedBox(width: 8),
              Text(
                'Dart • ${_controller.text.split('\n').length} lines • ${_controller.text.length} characters',
                style: const TextStyle(
                  color: Color(0xFF8B949E),
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              const Text(
                'Spaces: 2',
                style: TextStyle(
                  color: Color(0xFF8B949E),
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'UTF-8',
                style: TextStyle(
                  color: Color(0xFF8B949E),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
