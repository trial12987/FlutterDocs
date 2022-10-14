import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: SampleApp()));

class SampleApp extends StatefulWidget {
  const SampleApp({super.key});

  @override
  State<SampleApp> createState() => _SampleAppState();
}

class _SampleAppState extends State<SampleApp>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curve;
  double imageSize = 100;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    curve = CurvedAnimation(
      parent: controller,
      curve: Curves.slowMiddle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Listener(
          onPointerSignal: (pointerSignal) {
            if (pointerSignal is PointerScrollEvent) {
              Offset offset = pointerSignal.scrollDelta;
              var imgSize = imageSize;

              if (offset.direction > 0) {
                imgSize = 1000;
              } else {
                imgSize = 100;
              }
              setState(() {
                imageSize = imgSize;
              });
            }
          },
          child: GestureDetector(
            onDoubleTap: () {
              if (controller.isCompleted) {
                controller.reverse();
              } else {
                controller.forward();
              }
            },
            child: RotationTransition(
              turns: curve,
              child: FlutterLogo(
                size: imageSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
