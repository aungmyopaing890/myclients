import 'package:flutter/material.dart';
import 'package:myclients/config/master_colors.dart';
import 'package:myclients/config/master_config.dart';
import 'package:myclients/modules/client/core/provider/client_provider.dart';
import 'package:myclients/modules/client/core/view_object/client.dart';
import 'package:myclients/modules/client/view/widgets/client_create_dialog_view.dart';
import 'package:myclients/modules/common/core/utils/dimesions.dart';
import 'package:myclients/modules/common/views/dialog/confirm_dialog_view.dart';
import 'package:provider/provider.dart';

class ClientRowWidget extends StatelessWidget {
  final ClientVO client;
  final bool isLast;
  const ClientRowWidget({Key? key, required this.client, required this.isLast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ClientProvider provider = Provider.of<ClientProvider>(context);

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
          Container(
            width: Dimensions.screenWidth(context) * 0.15,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return ClientDialogView(
                            client: client,
                            onPressed: (ClientVO client) {
                              provider.update(client);
                            },
                          );
                        });
                  },
                  child: Icon(
                    Icons.edit,
                    color: MasterColors.buttonColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmDialogView(
                            title: "Are You Sure To Delete?",
                            leftButtonText: "Cancel",
                            rightButtonText: "Delete",
                            onAgreeTap: () {
                              provider.delete(client.id ?? "");
                              Navigator.pop(context);
                            },
                          );
                        });
                  },
                  child: Icon(
                    Icons.delete,
                    color: MasterColors.ionRejectColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
