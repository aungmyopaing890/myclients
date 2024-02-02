// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myclients/modules/client/core/provider/client_provider.dart';
import 'package:myclients/modules/client/core/repository/client_repository.dart';
import 'package:myclients/modules/common/views/dialog/confirm_dialog_view.dart';
import 'package:myclients/config/master_colors.dart';
import 'package:myclients/modules/common/views/responsive.dart';
import 'package:myclients/modules/home/widget/home_desktop_view.dart';
import 'package:myclients/modules/home/widget/home_mobile_view.dart';
import 'package:myclients/modules/home/widget/home_tablet_view.dart';
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
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: MasterColors.appBackgorundColor,
          ),
          body: SingleChildScrollView(
            child: Responsive(
                desktop: HomeDesktopView(
                  searchController: searchController,
                ),
                mobile: HomeMobileView(
                  searchController: searchController,
                ),
                tablet: HomeTabletView(
                  searchController: searchController,
                )),
          ),
        ),
      ),
    );
  }
}
