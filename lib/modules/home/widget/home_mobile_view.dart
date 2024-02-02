import 'package:flutter/material.dart';
import 'package:myclients/config/master_colors.dart';
import 'package:myclients/modules/client/core/provider/client_provider.dart';
import 'package:myclients/modules/client/core/view_object/client.dart';
import 'package:myclients/modules/client/view/client_table_list_view.dart';
import 'package:myclients/modules/client/view/widgets/client_create_dialog_view.dart';
import 'package:myclients/modules/client/view/widgets/client_search_widget.dart';
import 'package:myclients/modules/common/core/utils/dimesions.dart';
import 'package:myclients/modules/common/views/button_widget_with_round_corner.dart';
import 'package:provider/provider.dart';

class HomeMobileView extends StatefulWidget {
  const HomeMobileView({super.key, required this.searchController});
  final TextEditingController searchController;

  @override
  State<HomeMobileView> createState() => _HomeMobileViewState();
}

class _HomeMobileViewState extends State<HomeMobileView> {
  @override
  Widget build(BuildContext context) {
    final ClientProvider provider = Provider.of<ClientProvider>(context);

    return Container(
      padding: EdgeInsets.all(Dimensions.height5(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: Dimensions.height5(context)),
              height: Dimensions.height30(context),
              child: Text(
                "Clients",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w700),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClientSearchWidget(
                width: Dimensions.screenWidth(context) * 0.6,
                searchController: widget.searchController,
                funSetstate: () {
                  setState(() {});
                },
              ),
              IconButtonWidgetRoundCorner(
                colorData: MasterColors.mainColor,
                hasShadow: false,
                width: Dimensions.height30(context),
                height: Dimensions.height30(context),
                onPressed: () {
                  showDialog<dynamic>(
                      context: context,
                      builder: (BuildContext context) {
                        return ClientDialogView(
                          onPressed: (ClientVO client) {
                            provider.insert(client);
                          },
                        );
                      });
                },
                iconData: Icons.add,
              ),
            ],
          ),
          ClientTableView(
            horizontalPadding: Dimensions.height5(context),
            searchController: widget.searchController,
            isSearch: widget.searchController.text != "",
          )
        ],
      ),
    );
  }
}
