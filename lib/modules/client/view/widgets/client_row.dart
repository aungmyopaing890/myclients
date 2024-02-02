import 'package:flutter/material.dart';
import 'package:myclients/config/master_colors.dart';
import 'package:myclients/config/master_config.dart';
import 'package:myclients/modules/client/core/view_object/client.dart';
import 'package:myclients/modules/common/core/utils/dimesions.dart';

class ClientRowWidget extends StatelessWidget {
  final ClientVO client;
  final bool isLast;
  const ClientRowWidget({Key? key, required this.client, required this.isLast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.height20(context),
          horizontal: Dimensions.height10(context)),
      margin: EdgeInsets.symmetric(horizontal: Dimensions.height10(context)),
      decoration: BoxDecoration(
        borderRadius: isLast
            ? const BorderRadius.only(
                bottomRight: Radius.circular(MasterConfig.borderRadious),
                bottomLeft: Radius.circular(MasterConfig.borderRadious))
            : BorderRadius.zero,
        color: MasterColors.white,
        border: Border(
          top: BorderSide(color: MasterColors.secondary30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Dimensions.screenWidth(context) * 0.15,
            alignment: Alignment.centerLeft,
            child: Text(
              client.name(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700, color: MasterColors.textColor2),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: Dimensions.screenWidth(context) * 0.15,
            alignment: Alignment.centerLeft,
            child: Text(
              client.phoneNumber ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: Dimensions.screenWidth(context) * 0.15,
            alignment: Alignment.centerLeft,
            child: Text(
              client.email ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
