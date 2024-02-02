// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:myclients/config/master_colors.dart';
import 'package:flutter/material.dart';
import 'package:myclients/config/route/route_paths.dart';
import 'package:myclients/modules/client/core/provider/client_provider.dart';
import 'package:myclients/modules/client/core/repository/client_repository.dart';
import 'package:myclients/modules/common/core/utils/dimesions.dart';
import 'package:myclients/modules/language/core/app_localization.dart';
import 'package:provider/provider.dart';

class AppLoadingScreen extends StatefulWidget {
  const AppLoadingScreen({super.key});

  @override
  State<AppLoadingScreen> createState() => _AppLoadingScreenState();
}

class _AppLoadingScreenState extends State<AppLoadingScreen>
    with TickerProviderStateMixin {
  Future<dynamic> callDateFunction(ClientProvider clientProvider) async {
    Future.delayed(const Duration(seconds: 2));
    await clientProvider.insertJson();
    context.go(RoutePaths.home);
  }

  @override
  Widget build(BuildContext context) {
    final ClientRepository clientRepository =
        Provider.of<ClientRepository>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ClientProvider>(
            lazy: false,
            create: (BuildContext context) {
              ClientProvider clientProvider =
                  ClientProvider(repository: clientRepository);
              callDateFunction(clientProvider);
              return clientProvider;
            }),
      ],
      child: Scaffold(
        backgroundColor: MasterColors.appBackgorundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: Dimensions.height10(context) / 2),
                child: Text("app_name".tr),
              ),
              SizedBox(
                width: Dimensions.height40(context),
                height: Dimensions.height40(context),
                child: const LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black12),
                    backgroundColor: Colors.black12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
