import 'dart:async';
import 'package:flutter/material.dart';

class animationHeart extends StatefulWidget {
  final bool isRunning;

  const animationHeart({Key? key, required this.isRunning}) : super(key: key);

  @override
  _animationHeartState createState() => _animationHeartState();
}

class _animationHeartState extends State<animationHeart> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _beatAnimation;
  List<Offset> _heartOffsets = [];
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _isRunning = widget.isRunning;
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _beatAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    if (_isRunning) {
      _startHeartbeatAnimation();
    }
  }

  @override
  void didUpdateWidget(covariant animationHeart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRunning && !_isRunning) {
      _startHeartbeatAnimation();
      _isRunning = true;
    } else if (!widget.isRunning && _isRunning) {
      _stopHeartbeatAnimation();
      _isRunning = false;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startHeartbeatAnimation() {
    _animationController.repeat(reverse: true);
  }

  void _stopHeartbeatAnimation() {
    _animationController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1 + 0.5 * _animationController.value,
            child: Opacity(
              opacity: 1 - _animationController.value,
              child: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 30.0,
              ),
            ),
          );
        },
     ),
);}
}