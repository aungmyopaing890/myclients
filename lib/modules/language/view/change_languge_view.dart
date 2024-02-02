import 'package:myclients/config/master_config.dart';
import 'package:myclients/modules/common/core/utils/dimesions.dart';
import 'package:myclients/modules/common/core/utils/utils.dart';
import 'package:myclients/modules/language/core/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../config/master_colors.dart';
import '../core/view_object.dart/language.dart';

class ChangeLanguageView extends StatefulWidget {
  const ChangeLanguageView({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageView> createState() => _ChangeLanguageViewState();
}

class _ChangeLanguageViewState extends State<ChangeLanguageView> {
  @override
  Widget build(BuildContext context) {
    final AppLocalization appLocalization =
        Provider.of<AppLocalization>(context);

    return Scaffold(
      backgroundColor: MasterColors.primaryDarkWhite,
      appBar: AppBar(
        backgroundColor: MasterColors.appBarBackgorundColor,
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
              margin: EdgeInsets.all(Dimensions.height10(context)),
              decoration: BoxDecoration(
                  color: MasterColors.white,
                  borderRadius: BorderRadius.circular(50)),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: MasterColors.mainColor,
                size: Dimensions.height20(context),
              )),
        ),
        title: Text("change_languge".tr,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: MasterColors.white, fontWeight: FontWeight.w500)),
        elevation: 0,
        iconTheme: IconThemeData(
          color: MasterColors.black,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Utils.getBrightnessForAppBar(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                      margin:
                          EdgeInsets.only(top: Dimensions.height15(context)),
                      alignment: Alignment.center,
                      width: Dimensions.screenWidth(context) * 0.8,
                      // height: Dimesion.screeHigh * 0.2,
                      child: Image.asset("assets/images/bg/language_bg.png")),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: Dimensions.height15(context)),
                    width: Dimensions.screenWidth(context) * 0.4,
                    height: Dimensions.screenHeight(context) * 0.2,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(Dimensions.height10(context)),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(MasterConfig.borderRadious),
                        border: Border.all(color: MasterColors.mainColor)),
                    child: Text(
                      "hello_at_changelanguage".tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: MasterColors.black),
                    ),
                  ),
                ),
              ],
            ),
            MediaQuery.removePadding(
                context: context,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 0.9,
                        crossAxisSpacing: Dimensions.height20(context),
                        mainAxisSpacing: Dimensions.height10(context),
                        mainAxisExtent: Dimensions.height40(context) * 1.5),
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: MasterConfig.supportedLanguages.length,
                    itemBuilder: (context, index) {
                      Language language =
                          MasterConfig.supportedLanguages[index];
                      final bool isChecked =
                          appLocalization.currentLocale.languageCode ==
                              language.languageCode;
                      return InkWell(
                        onTap: () async {
                          await appLocalization
                              .setLocale(Locale(language.languageCode));
                          // ignore: use_build_context_synchronously
                          // context.go('/');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.height20(context),
                          ),
                          decoration: BoxDecoration(
                            // color: MasterColors.secondary400,
                            border: Border.all(
                                color: isChecked
                                    ? MasterColors.activeColor
                                    : MasterColors.inActiveColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.height10(context)),
                          child: Row(
                            children: [
                              if (isChecked)
                                const CheckedIconWidget()
                              else
                                Icon(
                                  Icons.circle_outlined,
                                  color: MasterColors.inActiveColor,
                                  size: 25,
                                ),
                              SizedBox(
                                width: Dimensions.height10(context),
                              ),
                              Text(
                                language.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: MasterColors.black),
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}

class CheckedIconWidget extends StatelessWidget {
  const CheckedIconWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: MasterColors.inActiveColor,
      ),
      child: Center(
          child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: MasterColors.white,
        ),
        child: Center(
          child: Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: MasterColors.activeColor,
            ),
          ),
        ),
      )),
    );
  }
}
