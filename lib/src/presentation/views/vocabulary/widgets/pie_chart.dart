import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;

class PieChart extends StatefulWidget {
  final double radius;
  final int correctAnswers;
  final int incorrectAnswers;
  final Widget child;

  const PieChart({
    super.key,
    required this.radius,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.child,
  });

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  late double _correctAnswers;
  late double _incorrectAnswers;

  @override
  void initState() {
    super.initState();

    final total = (widget.correctAnswers + widget.incorrectAnswers) / 360;

    _correctAnswers = widget.correctAnswers / total;
    _incorrectAnswers =
        (widget.incorrectAnswers + widget.correctAnswers) / total;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.fromRadius(widget.radius),
      child: CustomPaint(
        painter: _ProgressPainter(
          strokeWidth: 15,
          correctAnswersProgress: _correctAnswers,
          incorrectAnswersProgress: _incorrectAnswers,
        ),
        child: widget.child,
      ),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final double strokeWidth;
  final double correctAnswersProgress;
  final double incorrectAnswersProgress;
  const _ProgressPainter({
    required this.strokeWidth,
    required this.correctAnswersProgress,
    required this.incorrectAnswersProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    Paint paint = Paint()
      ..color = Colors.green
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Paint paint2 = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      math.radians(-90),
      math.radians(incorrectAnswersProgress),
      false,
      paint2,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.width / 2),
      math.radians(-90),
      math.radians(correctAnswersProgress),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
