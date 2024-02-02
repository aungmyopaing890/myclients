import 'package:flutter/material.dart';
import 'package:myclients/config/master_colors.dart';
import 'package:myclients/modules/common/core/utils/dimesions.dart';

class ButtonWidgetRoundCorner extends StatefulWidget {
  const ButtonWidgetRoundCorner(
      {super.key,
      this.onPressed,
      this.titleText = '',
      this.titleTextColor,
      this.titleTextAlign = TextAlign.center,
      this.colorData,
      this.width,
      this.height,
      this.gradient,
      this.hasBorder = false,
      this.hasShadow = false,
      this.outlineColor});

  final Function? onPressed;
  final String titleText;
  final Color? titleTextColor;
  final Color? colorData;
  final double? width;
  final double? height;
  final bool hasBorder;
  final Gradient? gradient;
  final bool hasShadow;
  final TextAlign titleTextAlign;
  final Color? outlineColor;

  @override
  State<ButtonWidgetRoundCorner> createState() =>
      _ButtonWidgetRoundCornerState();
}

class _ButtonWidgetRoundCornerState extends State<ButtonWidgetRoundCorner> {
  Color? _color;
  Color? _outlineColor;

  Color? _titleTextColor;
  @override
  Widget build(BuildContext context) {
    _color = widget.colorData;

    _titleTextColor = widget.titleTextColor;

    // _titleTextColor ??= MasterColors.baseColor;

    _color ??= const Color(0xFFEF5835);
    _outlineColor = widget.outlineColor ?? _color;
    return Container(
      width: widget.width,
      height: widget.height ?? 46,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        color: _color,
      ),
      child: Material(
        color: _color,
        type: MaterialType.card,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            side: widget.hasBorder
                ? BorderSide(color: _outlineColor!)
                : BorderSide.none,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            )),
        child: InkWell(
          onTap: widget.onPressed as void Function()?,
          highlightColor: MasterColors.iconColor.withOpacity(0.2),
          child: Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.height10(context),
                  horizontal: Dimensions.height10(context)),
              child: Text(
                widget.titleText,
                textAlign: widget.titleTextAlign,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: _titleTextColor, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
