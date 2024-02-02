// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myclients/modules/client/core/provider/client_provider.dart';
import 'package:myclients/modules/client/core/repository/client_repository.dart';
import 'package:myclients/modules/client/core/view_object/client.dart';
import 'package:myclients/modules/client/view/client_table_list_view.dart';
import 'package:myclients/modules/client/view/widgets/client_create_dialog_view.dart';
import 'package:myclients/modules/client/view/widgets/client_search_widget.dart';
import 'package:myclients/modules/common/core/utils/dimesions.dart';
import 'package:myclients/modules/common/views/button_widget_with_round_corner.dart';
import 'package:myclients/modules/common/views/dialog/confirm_dialog_view.dart';
import 'package:myclients/config/master_colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late Animation<double> animation;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  late ClientProvider clientProvider;

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() {
      return showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ConfirmDialogView(
                title: 'Confirm',
                description: 'Are you sure You want To Quit',
                leftButtonText: 'Cancel',
                rightButtonText: 'Ok',
                onAgreeTap: () {
                  Navigator.pop(context, true);
                });
          }).then((dynamic value) {
        if (value) {
          SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
        }
        return value;
      });
    }

    final ClientRepository clientRepository =
        Provider.of<ClientRepository>(context);

    return WillPopScope(
      onWillPop: onWillPop,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ClientProvider>(
              lazy: false,
              create: (BuildContext context) {
                clientProvider = ClientProvider(repository: clientRepository);
                clientProvider.loadDataList();
                return clientProvider;
              }),
        ],
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: MasterColors.appBackgorundColor,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(Dimensions.height30(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin:
                          EdgeInsets.only(bottom: Dimensions.height10(context)),
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
                        searchController: searchController,
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
                                  return ClientCreateDialogView(
                                    onPressed: (ClientVO client) {
                                      clientProvider.insert(client);
                                    },
                                  );
                                });
                          }),
                    ],
                  ),
                  ClientTableView(
                    searchController: searchController,
                    isSearch: searchController.text != "",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
