import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myclients/config/master_colors.dart';
import 'package:myclients/config/master_config.dart';
import 'package:myclients/modules/client/core/view_object/client.dart';
import 'package:myclients/modules/common/core/utils/dimesions.dart';
import 'package:myclients/modules/common/core/utils/utils.dart';
import 'package:myclients/modules/common/views/button_widget_with_round_corner.dart';
import 'package:myclients/modules/common/views/dialog/warning_dialog_view.dart';
import 'package:myclients/modules/common/views/textfield_widget_with_icon.dart';

class ClientDialogView extends StatefulWidget {
  const ClientDialogView({
    Key? key,
    required this.onPressed,
    this.isEdit = false,
    this.client,
  }) : super(key: key);
  final Function onPressed;
  final ClientVO? client;
  final bool isEdit;
  @override
  State<ClientDialogView> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<ClientDialogView> {
  @override
  Widget build(BuildContext context) {
    return NewDialog(
      onPressed: widget.onPressed,
      client: widget.client,
    );
  }
}

class NewDialog extends StatefulWidget {
  const NewDialog({
    Key? key,
    required this.onPressed,
    this.client,
  }) : super(key: key);
  final Function onPressed;
  final ClientVO? client;

  @override
  State<NewDialog> createState() => _NewDialogState();
}

class _NewDialogState extends State<NewDialog> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  bool isPersonalDetails = true;
  bool isPersonalComplete = false;
  bool isContactComplete = false;
  @override
  void initState() {
    if (widget.client != null) {
      isPersonalComplete = true;
      isContactComplete = true;
      firstname.text = widget.client?.firstName ?? "";
      lastname.text = widget.client?.lastName ?? "";
      phoneNumber.text = widget.client?.phoneNumber ?? "";
      email.text = widget.client?.email ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget headerWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Create a new Client',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: MasterColors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: Icon(
                  Icons.close,
                  color: MasterColors.secondary70,
                ),
              )
            ],
          ),
        ),
      ],
    );

    return Dialog(
      backgroundColor: MasterColors.white,
      child: Container(
        width: Dimensions.screenWidth(context) * 0.3,
        decoration: BoxDecoration(
            color: MasterColors.appBarTitleColor,
            borderRadius: BorderRadius.circular(MasterConfig.borderRadious)),
        padding: EdgeInsets.all(Dimensions.height10(context)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            headerWidget,
            SizedBox(
              height: Dimensions.height10(context),
            ),
            _ProcessBarWidget(isPersonalDetails: isPersonalDetails),
            SizedBox(
              height: Dimensions.height10(context),
            ),
            isPersonalDetails
                ? _FirstNameandLastNameWidget(
                    firstname: firstname,
                    lastname: lastname,
                    check: checkPersonalDetails,
                  )
                : EmailandPhoneNumberWidget(
                    email: email,
                    phoneNumber: phoneNumber,
                    check: checkContactDetails,
                  ),
            SizedBox(
              height: Dimensions.height10(context),
            ),
            Row(
                mainAxisAlignment: isPersonalDetails
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (!isPersonalDetails)
                    InkWell(
                      onTap: () {
                        setState(() {
                          isPersonalDetails = true;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: MasterColors.mainColor,
                          ),
                          Text(
                            "Back",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: MasterColors.mainColor,
                                  fontWeight: FontWeight.w500,
                                ),
                          )
                        ],
                      ),
                    ),
                  ButtonWidgetRoundCorner(
                      colorData: isPersonalDetails
                          ? isPersonalComplete
                              ? MasterColors.buttonColor
                              : MasterColors.inActiveColor
                          : isContactComplete
                              ? MasterColors.buttonColor
                              : MasterColors.inActiveColor,
                      hasShadow: false,
                      width: Dimensions.height40(context) * 3,
                      height: Dimensions.height40(context),
                      titleText: isPersonalDetails ? "Continue" : "Create",
                      titleTextColor: MasterColors.white,
                      onPressed: () {
                        if (isPersonalDetails && isPersonalComplete) {
                          setState(() {
                            isPersonalDetails = false;
                          });
                        } else if (!isPersonalDetails &&
                            isContactComplete &&
                            isPersonalComplete) {
                          if (!Utils.checkEmailFormat(email.text)) {
                            callWarningDialog(
                                context, "Invalid Email Address!");
                          } else {
                            widget.onPressed(ClientVO(
                                id: widget.client?.id ?? "",
                                firstName: firstname.text,
                                lastName: lastname.text,
                                phoneNumber: phoneNumber.text,
                                email: email.text));

                            context.pop();
                          }
                        }
                      })
                ])
          ],
        ),
      ),
    );
  }

  checkPersonalDetails() {
    setState(() {
      isPersonalComplete = firstname.text != "" && lastname.text != "";
    });
  }

  checkContactDetails() {
    setState(() {
      isContactComplete = phoneNumber.text != "" && email.text != "";
    });
  }

  dynamic callWarningDialog(BuildContext context, String text) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return WarningDialog(
            message: text,
            onPressed: () {},
          );
        });
  }
}

class _ProcessBarWidget extends StatelessWidget {
  const _ProcessBarWidget({required this.isPersonalDetails});
  final bool isPersonalDetails;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _ProcessItemWidget(
          index: "1",
          name: "Personal Details",
          isActive: isPersonalDetails,
        ),
        if (Utils.isDesktop(context))
          SizedBox(
            width: Dimensions.screenWidth(context) * 0.1,
            child: Divider(
              color: MasterColors.secondary30,
            ),
          ),
        _ProcessItemWidget(
          index: "2",
          name: "Contact Details",
          isActive: !isPersonalDetails,
        )
      ],
    );
  }
}

class _FirstNameandLastNameWidget extends StatelessWidget {
  const _FirstNameandLastNameWidget(
      {required this.firstname, required this.lastname, required this.check});
  final TextEditingController firstname;
  final TextEditingController lastname;
  final Function check;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MasterTextFieldWidget(
          check: check,
          textEditingController: firstname,
          hintText: "First Name",
        ),
        SizedBox(
          height: Dimensions.height10(context),
        ),
        MasterTextFieldWidget(
          check: check,
          textEditingController: lastname,
          hintText: "Last Name",
        ),
      ],
    );
  }
}

class EmailandPhoneNumberWidget extends StatelessWidget {
  const EmailandPhoneNumberWidget({
    super.key,
    required this.email,
    required this.phoneNumber,
    required this.check,
  });
  final TextEditingController email;
  final TextEditingController phoneNumber;
  final Function check;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MasterTextFieldWidget(
          check: check,
          textEditingController: email,
          hintText: "Email",
        ),
        SizedBox(
          height: Dimensions.height10(context),
        ),
        MasterTextFieldWidget(
          check: check,
          textEditingController: phoneNumber,
          hintText: "Phone Number",
        ),
      ],
    );
  }
}

class _ProcessItemWidget extends StatelessWidget {
  const _ProcessItemWidget(
      {required this.index, required this.name, required this.isActive});
  final String index, name;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: Dimensions.height5(context)),
          alignment: Alignment.center,
          width: Dimensions.height15(context),
          height: Dimensions.height15(context),
          decoration: BoxDecoration(
              color:
                  isActive ? MasterColors.mainColor : MasterColors.secondary30,
              borderRadius: BorderRadius.circular(MasterConfig.borderRadious)),
          child: Text(
            index,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: MasterColors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Text(
          name,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: isActive ? MasterColors.black : MasterColors.secondary30,
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    );
  }
}
