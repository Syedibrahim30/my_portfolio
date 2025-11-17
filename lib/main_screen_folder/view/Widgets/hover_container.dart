import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HoverContainer extends StatefulWidget {
  final Widget child;

  final Color color;
  final double? height;
  final double? weight;

  const HoverContainer({
    super.key,
    this.height,
    this.weight,
    required this.child,

    this.color = const Color(0xfff4623a),
  });

  @override
  State<HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<HoverContainer> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        height: widget.height,
        width: widget.weight,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          color: widget.color,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            if (_hover)
              BoxShadow(blurRadius: 10, color: Colors.white.withOpacity(0.25)),
          ],
        ),
        transform: Matrix4.identity()..scale(_hover ? 1.05 : 1.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 2.sp),
          child: widget.child,
        ),
      ),
    );
  }
}

//=====================================without Color================================

class HoverWithoutColorContainer extends StatefulWidget {
  final Widget child;

  final Color color;

  const HoverWithoutColorContainer({
    super.key,
    required this.child,

    this.color = const Color(0xfff4623a),
  });

  @override
  State<HoverWithoutColorContainer> createState() =>
      _HoverWithoutColorContainerState();
}

class _HoverWithoutColorContainerState
    extends State<HoverWithoutColorContainer> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          color: Color(0xff121212),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            if (_hover)
              BoxShadow(blurRadius: 10, color: Colors.white.withOpacity(0.25)),
          ],
        ),
        transform: Matrix4.identity()..scale(_hover ? 1.05 : 1.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 2.sp),
          child: widget.child,
        ),
      ),
    );
  }
}

//====================================circle Container============================
class HoverCircleContainer extends StatefulWidget {
  final Widget child;

  final Color color;

  const HoverCircleContainer({
    super.key,
    required this.child,

    this.color = const Color(0xfff4623a),
  });

  @override
  State<HoverCircleContainer> createState() => _HoverCircleContainerState();
}

class _HoverCircleContainerState extends State<HoverCircleContainer> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          color: widget.color,
          shape: BoxShape.circle,
          boxShadow: [
            if (_hover)
              BoxShadow(blurRadius: 10, color: Colors.white.withOpacity(0.25)),
          ],
        ),
        transform: Matrix4.identity()..scale(_hover ? 1.05 : 1.0),
        child: Padding(padding: EdgeInsets.all(8.0), child: widget.child),
      ),
    );
  }
}
