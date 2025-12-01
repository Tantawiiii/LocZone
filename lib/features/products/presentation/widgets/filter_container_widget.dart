import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loczone/core/utils/app_colors.dart';
import 'package:loczone/core/utils/app_strings.dart';

class FilterContainerWidget extends StatefulWidget {
  final VoidCallback? onFilterPressed;
  final bool isActive;
  final String? filterCount;

  const FilterContainerWidget({
    super.key,
    this.onFilterPressed,
    this.isActive = false,
    this.filterCount,
  });

  @override
  State<FilterContainerWidget> createState() => _FilterContainerWidgetState();
}

class _FilterContainerWidgetState extends State<FilterContainerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: widget.isActive ? AppColors.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.1),
                    blurRadius: _isHovered ? 15 : 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border:
                    widget.isActive
                        ? null
                        : Border.all(
                          color:
                              _isHovered
                                  ? AppColors.primaryColor
                                  : Colors.grey.shade300,
                          width: _isHovered ? 2 : 1,
                        ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onFilterPressed,
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  onTapCancel: _onTapCancel,
                  borderRadius: BorderRadius.circular(25),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.filter_list,
                          color:
                              widget.isActive
                                  ? Colors.white
                                  : AppColors.primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          height: 30.h,
                          width: 1.5,
                          color:
                              widget.isActive
                                  ? Colors.white54
                                  : Colors.grey.shade300,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          AppStrings.filter,
                          style: TextStyle(
                            color:
                                widget.isActive
                                    ? Colors.white
                                    : AppColors.primaryColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (widget.filterCount != null) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  widget.isActive
                                      ? Colors.white24
                                      : AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              widget.filterCount!,
                              style: TextStyle(
                                color:
                                    widget.isActive
                                        ? Colors.white
                                        : AppColors.primaryColor,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.filter_alt_outlined,

                          color:
                              widget.isActive
                                  ? Colors.white
                                  : AppColors.primaryColor,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
