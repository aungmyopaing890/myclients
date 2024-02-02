import 'package:flutter/material.dart';
import 'package:myclients/config/master_colors.dart';
import 'package:myclients/config/master_config.dart';
import 'package:myclients/modules/common/core/utils/dimesions.dart';
import 'package:myclients/modules/common/views/button_widget_with_round_corner.dart';

class ConfirmDialogView extends StatefulWidget {
  const ConfirmDialogView(
      {Key? key,
      this.description,
      this.leftButtonText,
      this.rightButtonText,
      this.title,
      this.onAgreeTap})
      : super(key: key);

  final String? description, leftButtonText, rightButtonText, title;
  final Function? onAgreeTap;

  @override
  State<ConfirmDialogView> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<ConfirmDialogView> {
  @override
  Widget build(BuildContext context) {
    return NewDialog(widget: widget);
  }
}

class NewDialog extends StatelessWidget {
  const NewDialog({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ConfirmDialogView widget;

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
                widget.title ?? 'Confirmation',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: MasterColors.mainColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );

    return Dialog(
      backgroundColor: MasterColors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MasterConfig.borderRadious)),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.height15(context)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            headerWidget,
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                  top: Dimensions.height10(context),
                  bottom: Dimensions.height15(context)),
              child: Text(
                widget.description!,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: MasterColors.textColor3,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              ButtonWidgetRoundCorner(
                  colorData: Colors.grey[50]!,
                  hasShadow: false,
                  width: Dimensions.height40(context) * 3,
                  height: Dimensions.height30(context),
                  titleText: widget.leftButtonText!,
                  titleTextColor: MasterColors.mainColor,
                  outlineColor: MasterColors.mainColor,
                  hasBorder: true,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              SizedBox(
                width: Dimensions.height10(context),
              ),
              ButtonWidgetRoundCorner(
                  colorData: MasterColors.mainColor,
                  hasShadow: false,
                  width: Dimensions.height40(context) * 3,
                  height: Dimensions.height30(context),
                  titleText: widget.rightButtonText!,
                  titleTextColor: MasterColors.white,
                  onPressed: () {
                    widget.onAgreeTap!();
                  }),
            ])
          ],
        ),
      ),
    );
  }
}
