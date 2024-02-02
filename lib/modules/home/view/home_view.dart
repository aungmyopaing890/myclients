// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myclients/config/master_config.dart';
import 'package:myclients/modules/client/core/provider/client_provider.dart';
import 'package:myclients/modules/client/core/repository/client_repository.dart';
import 'package:myclients/modules/client/core/view_object/client.dart';
import 'package:myclients/modules/common/core/utils/dimesions.dart';
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
                return clientProvider;
              }),
        ],
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: MasterColors.appBackgorundColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    await clientProvider.insert(ClientVO(
                        id: "test11",
                        firstName: "AA",
                        lastName: "Aung",
                        phoneNumber: "0999048304",
                        email: "aung@gmail.com"));
                  },
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.height10(context)),
                    decoration: BoxDecoration(
                        color: MasterColors.buttonColor,
                        borderRadius:
                            BorderRadius.circular(MasterConfig.borderRadious)),
                    child: const Text(
                      "data",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
