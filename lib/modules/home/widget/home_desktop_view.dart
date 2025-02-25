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

class HomeDesktopView extends StatefulWidget {
  const HomeDesktopView({super.key, required this.searchController});
  final TextEditingController searchController;

  @override
  State<HomeDesktopView> createState() => _HomeDesktopViewState();
}

class _HomeDesktopViewState extends State<HomeDesktopView> {
  @override
  Widget build(BuildContext context) {
    final ClientProvider provider = Provider.of<ClientProvider>(context);

    return Container(
      padding: EdgeInsets.all(Dimensions.height30(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: Dimensions.height10(context)),
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
                searchController: widget.searchController,
                funSetstate: () {
                  setState(() {});
                },
              ),
              ButtonWidgetRoundCorner(
                  colorData: MasterColors.mainColor,
                  hasShadow: false,
                  width: Dimensions.height40(context) * 3,
                  height: Dimensions.height40(context),
                  titleText: "Create new client",
                  titleTextColor: MasterColors.white,
                  onPressed: () {
                    // clientProvider.insertJson();
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return ClientDialogView(
                            onPressed: (ClientVO client) {
                              provider.insert(client);
                            },
                          );
                        });
                  }),
            ],
          ),
          ClientTableView(
            searchController: widget.searchController,
            isSearch: widget.searchController.text != "",
          )
        ],
      ),
    );
  }
}
