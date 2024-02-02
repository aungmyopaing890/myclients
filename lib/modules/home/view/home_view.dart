// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myclients/modules/common/views/dialog/confirm_dialog_view.dart';
import 'package:myclients/config/master_colors.dart';

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

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: MasterColors.appBackgorundColor,
        body: const Column(
          children: [
            Text(
              "data",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
