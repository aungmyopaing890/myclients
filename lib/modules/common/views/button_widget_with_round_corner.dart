import 'package:flutter/material.dart';
import 'package:myclients/config/master_colors.dart';
import 'package:myclients/config/master_config.dart';
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
          Radius.circular(MasterConfig.borderRadious),
        ),
        // border: Border.all(color: _outlineColor!),
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
                Radius.circular(MasterConfig.borderRadious))),
        child: InkWell(
          onTap: widget.onPressed as void Function()?,
          highlightColor: MasterColors.iconColor.withOpacity(0.2),
          child: Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  left: Dimensions.height10(context),
                  right: Dimensions.height10(context)),
              child: Text(
                widget.titleText,
                textAlign: widget.titleTextAlign,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: _titleTextColor, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonWithIconWidget extends StatefulWidget {
  const ButtonWithIconWidget(
      {super.key,
      this.onPressed,
      this.titleText = '',
      this.colorData,
      this.width,
      this.gradient,
      this.icon,
      this.iconAlignment = MainAxisAlignment.center,
      this.hasShadow = false,
      this.iconColor});

  final Function? onPressed;
  final String titleText;
  final Color? colorData;
  final double? width;
  final IconData? icon;
  final Gradient? gradient;
  final MainAxisAlignment iconAlignment;
  final bool hasShadow;
  final Color? iconColor;

  @override
  State<ButtonWithIconWidget> createState() => _ButtonWithIconWidgetState();
}

class _ButtonWithIconWidgetState extends State<ButtonWithIconWidget> {
  Color? _color;
  Color? _iconColor;

  @override
  Widget build(BuildContext context) {
    _color = widget.colorData;

    _iconColor = widget.iconColor;

    // _iconColor ??= MasterColors.baseColor;

    _color ??= const Color(0xFFEF5835);

    return Container(
      width: widget.width, //MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        color: _color,
      ),
      child: Material(
        color: _color,
        type: MaterialType.card,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.onPressed as void Function()?,
          highlightColor: MasterColors.buttonColor,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: widget.iconAlignment,
            children: <Widget>[
              if (widget.icon != null) Icon(widget.icon, color: _iconColor),
              if (widget.icon != null && widget.titleText != '')
                SizedBox(
                  width: Dimensions.height10(context) + 2,
                ),
              Text(widget.titleText,
                  style: Theme.of(context).textTheme.labelLarge!),
            ],
          ),
        ),
      ),
    );
  }
}

// class ButtonWidgetWithIconRoundCorner extends StatefulWidget {
//   const ButtonWidgetWithIconRoundCorner(
//       {super.key,
//       this.onPressed,
//       this.titleText = '',
//       this.titleTextAlign = TextAlign.center,
//       this.colorData,
//       this.width,
//       this.icon,
//       this.gradient,
//       this.iconColor,
//       this.iconAlignment = MainAxisAlignment.center,
//       this.hasShadow = false});

//   final Function? onPressed;
//   final String titleText;
//   final Color? colorData;
//   final double? width;
//   final IconData? icon;
//   final Gradient? gradient;
//   final bool hasShadow;
//   final TextAlign titleTextAlign;
//   final MainAxisAlignment iconAlignment;
//   final Color? iconColor;

//   @override
//   State<ButtonWidgetWithIconRoundCorner> createState() =>
//       _ButtonWidgetWithIconRoundCornerState();
// }

// class _ButtonWidgetWithIconRoundCornerState
//     extends State<ButtonWidgetWithIconRoundCorner> {
//   Color? _color;
//   Color? _iconColor;

//   @override
//   Widget build(BuildContext context) {
//     _color = widget.colorData;

//     _iconColor = widget.iconColor;

//     _iconColor ??= MasterColors.white;

//     _color ??= MasterColors.primary500;

//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 40,
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.all(
//           Radius.circular(4.0),
//         ),
//         color: _color,
//       ),
//       child: Material(
//         color: _color,
//         type: MaterialType.card,
//         clipBehavior: Clip.antiAlias,
//         shape: RoundedRectangleBorder(
//             side: BorderSide(color: MasterColors.secondary50),
//             borderRadius:
//                 BorderRadius.all(Radius.circular(Dimesion.height10 - 2))),
//         child: InkWell(
//           onTap: widget.onPressed as void Function()?,
//           highlightColor: MasterColors.primary900,
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: widget.iconAlignment,
//             children: <Widget>[
//               if (widget.icon != null) Icon(widget.icon, color: _iconColor),
//               if (widget.icon != null && widget.titleText != '')
//                 SizedBox(
//                   width: Dimesion.height10 / 2,
//                 ),
//               Text(
//                 widget.titleText.toUpperCase(),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     color: widget.titleText == 'edit_profile__title'.tr ||
//                             widget.titleText == 'Reset'.tr ||
//                             widget.titleText == 'map_filter__reset'.tr
//                         ? MasterColors.mainColor //MasterColors.primary500
//                         : MasterColors.textColor4 //MasterColors.white
//                     ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class ButtonWidgetWithIconRoundCorner2 extends StatefulWidget {
  const ButtonWidgetWithIconRoundCorner2(
      {super.key,
      this.onPressed,
      this.titleText = '',
      this.titleTextAlign = TextAlign.center,
      this.colorData,
      this.width,
      this.icon,
      this.gradient,
      this.iconColor,
      this.iconAlignment = MainAxisAlignment.center,
      this.hasShadow = false});

  final Function? onPressed;
  final String titleText;
  final Color? colorData;
  final double? width;
  final IconData? icon;
  final Gradient? gradient;
  final bool hasShadow;
  final TextAlign titleTextAlign;
  final MainAxisAlignment iconAlignment;
  final Color? iconColor;

  @override
  State<ButtonWidgetWithIconRoundCorner2> createState() =>
      _ButtonWidgetWithIconRoundCorner2State();
}

class _ButtonWidgetWithIconRoundCorner2State
    extends State<ButtonWidgetWithIconRoundCorner2> {
  Color? _color;
  Color? _iconColor;

  @override
  Widget build(BuildContext context) {
    _color = widget.colorData;

    _iconColor = widget.iconColor;

    _iconColor ??= MasterColors.white;

    _color ??= const Color(0xFFEF5835);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFB7B7B7)),
        color: _color,
      ),
      child: Material(
        color: _color,
        type: MaterialType.card,
        clipBehavior: Clip.antiAlias,
        // shape: RoundedRectangleBorder(
        //     side: BorderSide(color: MasterColors.secondary50),
        //     borderRadius:
        //         const BorderRadius.all(Radius.circular(MasterDimesion.height6))),
        child: InkWell(
          onTap: widget.onPressed as void Function()?,
          highlightColor: const Color(0xFFEF5835),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.titleText.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: MasterColors.textColor2,
                      fontWeight: FontWeight.normal //MasterColors.white
                      ),
                ),
              ),
              if (widget.icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(widget.icon, color: _iconColor),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
