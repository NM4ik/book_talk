import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:flutter/material.dart';

class ColorPaletteScreen extends StatelessWidget {
  const ColorPaletteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookTalkTheme theme = BookTalkTheme();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('ColorPalette'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ColorPaletteBuilderWidget(
                  palette: theme.lightTheme.colorPalette!,
                  title: 'Light',
                ),
                const Divider(
                  height: 80,
                ),
                _ColorPaletteBuilderWidget(
                  palette: theme.darkTheme.colorPalette!,
                  title: 'Dark',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorPaletteBuilderWidget extends StatefulWidget {
  const _ColorPaletteBuilderWidget({
    required this.palette,
    required this.title,
  });

  final ColorPalette palette;
  final String title;

  @override
  State<_ColorPaletteBuilderWidget> createState() =>
      _ColorPaletteBuilderWidgetState();
}

class _ColorPaletteBuilderWidgetState
    extends State<_ColorPaletteBuilderWidget> {
  late final palette = widget.palette;
  List<(Color, String)> get items => [
        (palette.backgroundColor, 'background'),
        (palette.primary, 'primary'),
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(widget.title),
        ),
        Wrap(
          runSpacing: 30,
          spacing: 30,
          children: items
              .map((paletteItem) => _ColorPaletteItemWidget(
                  color: paletteItem.$1, name: paletteItem.$2))
              .toList(),
        ),
      ],
    );
  }
}

class _ColorPaletteItemWidget extends StatelessWidget {
  const _ColorPaletteItemWidget({
    required this.color,
    required this.name,
    super.key,
  });

  final Color color;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(1, 1),
                blurRadius: 3,
                spreadRadius: 1,
              )
            ],
            borderRadius: BorderRadius.circular(7),
            color: color,
          ),
        ),
        Text(name),
      ],
    );
  }
}
