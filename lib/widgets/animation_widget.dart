import 'package:flutter/material.dart'; 
import '../widgets/text_widget.dart'; 


class BounceWidget extends StatefulWidget {
  final Widget child;
  final double end;

  const BounceWidget({
    Key? key,
    required this.child,
    this.end = 1.05,
  }) : super(key: key);

  @override
  State<BounceWidget> createState() => _BounceWidgetState();
}

class _BounceWidgetState extends State<BounceWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      reverseDuration: const Duration(milliseconds: 700),
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    animation = Tween<double>(
      begin: 0.9,
      end: widget.end,
    ).animate(animController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animController.forward();
        }
      });
    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: animation.value,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
}

///旋转动画
class RotateWidget extends StatefulWidget {
  final Widget child;
  final bool isStop;

  const RotateWidget({
    Key? key,
    required this.child,
    this.isStop = false,
  }) : super(key: key);

  @override
  State<RotateWidget> createState() => RotateWidgetState();
}

class RotateWidgetState extends State<RotateWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      reverseDuration: const Duration(milliseconds: 700),
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    animation = Tween<double>(
      begin: 1,
      end: 300,
    ).animate(animController)
      ..addListener(() {
        setState(() {
          if (widget.isStop) {
            animController.stop();
          } else {
            animController.forward();
          }
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animController.repeat();
        } else if (status == AnimationStatus.dismissed) {
          animController.forward();
        }
      });
    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // return Transform.rotate(
    //   angle: animController.value,
    //   child: widget.child,
    // );
    return Center(
      child: RotationTransition(
          alignment: Alignment.center,
          turns: animController,
          child: widget.child),
    );
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
}

class AnimationText extends StatefulWidget {
  const AnimationText({
    Key? key,
    required this.numValue,
    required this.unit,
    required this.color,
    required this.letterSpacing,
    this.currency = "",
    this.size = 16,
    this.decimal = 2,
  }) : super(key: key);

  final double numValue;
  final Color color;
  final double letterSpacing;
  final String unit;
  final String currency;
  final double size;
  final int decimal; //小数位

  @override
  State<AnimationText> createState() => _AnimationTextState();
}

class _AnimationTextState extends State<AnimationText>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animController;

  double addValue = 0.0;

  final Accumulator _accumulator = Accumulator();

  @override
  void initState() {
    super.initState();
    _accumulator.increment(widget.numValue ~/ 10);

    animController = AnimationController(
      reverseDuration: const Duration(milliseconds: 100),
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animController)
      ..addListener(() {
        setState(() {
          double newValue = 0;
          if (widget.numValue == 1.00) return;
          if (widget.numValue < 1000) {
            newValue = (widget.numValue / 50.23);
          } else {
            newValue = (widget.numValue / 300.23);
          }
          addValue += newValue;
        });
      })
      ..addStatusListener((status) {
        setState(() {
          if (addValue <= 1.00) {
            addValue = 0.00;
            // animController.stop();
          }
          if (addValue >= widget.numValue) {
            addValue = widget.numValue;
            animController.stop();
          }
        });
        if (status == AnimationStatus.completed) {
          animController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animController.forward();
        }
      });
    animController.forward();
  }

  // @override
  // void didUpdateWidget(covariant AnimationText oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   animController.reverse();
  // }
  @override
  Widget build(BuildContext context) {
    return syText(
        text: widget.unit +
            addValue.toStringAsFixed(widget.decimal) +
            widget.currency,
        // color: widget.color,
        fontSize: widget.size,
        fontWeight: FontWeight.bold,
        letterSpacing: widget.letterSpacing);
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
}
