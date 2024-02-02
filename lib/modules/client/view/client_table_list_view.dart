import 'package:flutter/material.dart';
import 'package:myclients/config/master_colors.dart';
import 'package:myclients/config/master_config.dart';
import 'package:myclients/modules/client/core/provider/client_provider.dart';
import 'package:myclients/modules/client/view/widgets/client_row.dart';
import 'package:myclients/modules/common/core/utils/dimesions.dart';
import 'package:provider/provider.dart';

class ClientTableView extends StatelessWidget {
  const ClientTableView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.height20(context)),
      child: Column(
        children: [
          const ClientTableTitle(),
          Consumer<ClientProvider>(builder:
              (BuildContext context, ClientProvider pro, Widget? child) {
            return MediaQuery.removePadding(
                removeTop: true,
                removeBottom: true,
                context: context,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: pro.dataLength,
                    itemBuilder: (context, index) {
                      return ClientRowWidget(
                        isLast: pro.dataLength == index + 1,
                        client: pro.getListIndexOf(index),
                      );
                    }));
          }),
        ],
      ),
    );
  }
}

class ClientTableTitle extends StatelessWidget {
  const ClientTableTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.height20(context),
          horizontal: Dimensions.height10(context)),
      margin: EdgeInsets.symmetric(horizontal: Dimensions.height10(context)),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(MasterConfig.borderRadious),
            topRight: Radius.circular(MasterConfig.borderRadious)),
        color: MasterColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Dimensions.screenWidth(context) * 0.15,
            alignment: Alignment.centerLeft,
            child: Text(
              "Name",
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            width: Dimensions.screenWidth(context) * 0.15,
            alignment: Alignment.centerLeft,
            child: Text(
              "Phone",
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            width: Dimensions.screenWidth(context) * 0.15,
            alignment: Alignment.centerLeft,
            child: Text(
              "Email",
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
