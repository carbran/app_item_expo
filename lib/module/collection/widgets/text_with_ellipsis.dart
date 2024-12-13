import 'package:flutter/material.dart';

// class TruncatedTextExample extends StatelessWidget {
//   final String text = 'Colecionador de: Livros, Quadrinhos, Action Figures, Lego, Vinil, Moedas';

//   const TruncatedTextExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Texto Truncado com "e mais"'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return TextWithEllipsis(
//               text: text,
//               maxWidth: constraints.maxWidth,
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class TextWithEllipsis extends StatelessWidget {
  final String text;
  final double maxWidth;

  const TextWithEllipsis({
    super.key,
    required this.text,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium!;
    const ellipsisText = ' e mais';

    // Measure the width of the ellipsis
    // final ellipsisWidth = _measureTextWidth(ellipsisText, textStyle);

    // Measure the width of the full text
    final fullTextWidth = _measureTextWidth(text, textStyle);

    // If the text fits, show it all
    if (fullTextWidth <= maxWidth) {
      return Text(text, style: textStyle);
    }

    // Otherwise, truncate the text
    String truncatedText = '';
    for (final word in text.split(' ')) {
      final candidateText =
          truncatedText.isEmpty ? word : '$truncatedText $word';
      final candidateWidth =
          _measureTextWidth(candidateText + ellipsisText, textStyle);

      if (candidateWidth > maxWidth) break;
      truncatedText = candidateText;
    }

    return RichText(
      text: TextSpan(
        text: truncatedText,
        style: textStyle,
        children: [
          TextSpan(
            text: ellipsisText,
            style: textStyle.copyWith(color: Colors.blue),
          ),
        ],
      ),
    );
  }

  double _measureTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 2,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }
}
