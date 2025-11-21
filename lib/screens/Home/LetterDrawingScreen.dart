import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:scribble/scribble.dart';

class LetterDrawingScreen extends StatefulWidget {
  final String letter;

  const LetterDrawingScreen({super.key, required this.letter});

  @override
  State<LetterDrawingScreen> createState() => _LetterDrawingScreenState();
}

class _LetterDrawingScreenState extends State<LetterDrawingScreen> {
  late ScribbleNotifier notifier;

  // Local UI state (avoid reading notifier internals)
  Color selectedColor = Colors.brown;
  double brushSize = 5.0;

  @override
  void initState() {
    super.initState();
    notifier = ScribbleNotifier();

    // Apply initial values to the notifier so new strokes use them.
    notifier.setColor(selectedColor);
    notifier.setStrokeWidth(brushSize);
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  // -------------------------
  // Color picker dialog
  // -------------------------
  void _openColorPicker() {
    Color temp = selectedColor;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Pick a Color"),
        content: BlockPicker(
          pickerColor: temp,
          onColorChanged: (color) {
            // update immediately so user sees preview in picker (BlockPicker returns instantly)
            temp = color;
            // apply changes (we'll also close after pick)
            setState(() {
              selectedColor = color;
            });
            notifier.setColor(color); // affects only future strokes
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  // -------------------------
  // Brush size dialog
  // -------------------------
  void _openBrushSizeDialog() {
    double tempSize = brushSize;
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) {
          return Dialog(
            backgroundColor: Colors.white,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Brush Size",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[700],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: tempSize * 2,
                    width: tempSize * 2,
                    decoration: BoxDecoration(
                      color: selectedColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Slider(
                    min: 2,
                    max: 30,
                    value: tempSize,
                    onChanged: (val) {
                      setDialogState(() => tempSize = val);
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${tempSize.round()}px",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.brown[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child:
                          const Text("Cancel", style: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            // Apply new brush size locally and to notifier
                            setState(() {
                              brushSize = tempSize;
                            });
                            notifier.setStrokeWidth(tempSize); // affects future strokes
                            Navigator.of(context).pop();
                          },
                          child: const Text("Apply", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // -------------------------
  // Build UI (keeps your original layout)
  // -------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Color(0xFF6E4D3F)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Draw ${widget.letter}',
          style: const TextStyle(
            color: Color(0xFF6E4D3F),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          /// Background
          Positioned.fill(
            child: Image.asset(
              "assets/images/drawing/ic_latter_draw_bg.png",
              fit: BoxFit.fill,
            ),
          ),

          /// Big Letter
          Align(
            alignment: const Alignment(0.0, -0.5),
            child: Text(
              widget.letter,
              style: const TextStyle(
                fontSize: 300,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
          ),

          /// Drawing canvas with Scribble
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              margin: const EdgeInsets.only(top: 100, bottom: 200),
              child: Scribble(
                notifier: notifier,
                drawPen: true,   // <-- valid for your version
              ),
            ),
          ),

          /// Tools bottom bar (UI same as your Signature version)
          Positioned(
            bottom: 180,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Brush size
                IconButton(
                  icon: const Icon(Icons.brush, size: 30),
                  onPressed: _openBrushSizeDialog,
                ),

                /// Color picker (uses local selectedColor for icon)
                IconButton(
                  icon: Icon(Icons.circle, color: selectedColor, size: 30),
                  onPressed: _openColorPicker,
                ),

                /// Undo
                IconButton(
                  icon: const Icon(Icons.undo, size: 30),
                  onPressed: notifier.undo,
                ),

                /// Clear
                IconButton(
                  icon: const Icon(Icons.clear, size: 30),
                  onPressed: notifier.clear,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
