import 'package:flutter/material.dart';
import 'package:myclients/config/master_colors.dart';
import 'package:myclients/config/master_config.dart';
import 'package:myclients/modules/common/core/utils/dimesions.dart';

import '../button_widget_with_round_corner.dart';

class WarningDialog extends StatefulWidget {
  const WarningDialog({
    super.key,
    this.message,
    this.onPressed,
    this.titleText,
  });

  final String? message;
  final Function? onPressed;
  final String? titleText;

  @override
  State<WarningDialog> createState() => _WarningDialogState();
}

class _WarningDialogState extends State<WarningDialog> {
  @override
  Widget build(BuildContext context) {
    return _NewDialog(widget: widget);
  }
}

class _NewDialog extends StatelessWidget {
  const _NewDialog({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final WarningDialog widget;

  @override
  Widget build(BuildContext context) {
    final Widget headerWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.titleText ?? 'Warning',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: MasterColors.textColor2,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: MasterColors.black,
            ))
      ],
    );
    return Dialog(
        backgroundColor: MasterColors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MasterConfig.borderRadious)),
        child: Container(
            width: Dimensions.screenWidth(context) * 0.3,
            padding: EdgeInsets.all(Dimensions.height15(context)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  headerWidget,
                  Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height15(context),
                        bottom: Dimensions.height20(context)),
                    child: Text(
                      widget.message!,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: MasterColors.black,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                  ButtonWidgetRoundCorner(
                      colorData: MasterColors.mainColor,
                      hasShadow: false,
                      width: MediaQuery.of(context).size.width,
                      height: Dimensions.height40(context),
                      titleText: 'Ok',
                      titleTextColor: MasterColors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget.onPressed!();
                      }),
                ],
              ),
            )));
  }
}
