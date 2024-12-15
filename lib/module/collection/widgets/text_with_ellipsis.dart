import 'package:flutter/material.dart';

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

    final fullTextWidth = _measureTextWidth(text, textStyle);

    if (fullTextWidth <= maxWidth) {
      return Text(text, style: textStyle);
    }

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
