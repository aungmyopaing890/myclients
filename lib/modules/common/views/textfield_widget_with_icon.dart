import 'package:flutter/material.dart';
import 'package:myclients/config/master_colors.dart';
import 'package:myclients/modules/common/core/utils/dimesions.dart';
import 'package:myclients/modules/common/core/utils/utils.dart';

class TextFieldWidgetWithIcon extends StatelessWidget {
  const TextFieldWidgetWithIcon(
      {super.key,
      this.textEditingController,
      this.hintText,
      this.height = 44,
      this.keyboardType = TextInputType.text,
      this.clickEnterFunction,
      this.clickSearchButton});

  final TextEditingController? textEditingController;
  final String? hintText;
  final double height;
  final TextInputType keyboardType;
  final Function? clickEnterFunction;
  final Function? clickSearchButton;

  @override
  Widget build(BuildContext context) {
    final Widget productTextFieldWidget = TextField(
      keyboardType: TextInputType.text,
      maxLines: 1,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.left,
      textInputAction: TextInputAction.search,
      controller: textEditingController,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 14,
          color: Utils.isLightMode(context)
              ? const Color(0xFF3C3C3C)
              : MasterColors.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
            left: Dimensions.height10(context),
            bottom: Dimensions.height40(context) / 10),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 14,
            color: Utils.isLightMode(context)
                ? MasterColors.secondary800
                : Colors.black54),
        prefixIcon: InkWell(
            child: Icon(
              Icons.search,
              color: Utils.isLightMode(context)
                  ? MasterColors.secondary600
                  : MasterColors.primaryDarkAccent,
            ),
            onTap: () {
              clickSearchButton!();
            }),
      ),
      onSubmitted: (String value) {
        clickEnterFunction!();
      },
    );

    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: height,
          margin: EdgeInsets.all(Dimensions.height40(context)),
          decoration: BoxDecoration(
            color: MasterColors.secondary50,
            borderRadius: BorderRadius.circular(Dimensions.height40(context)),
          ),
          child: productTextFieldWidget,
        ),
      ],
    );
  }
}

class MasterTextFieldWidget extends StatelessWidget {
  const MasterTextFieldWidget(
      {super.key,
      this.textEditingController,
      this.hintText,
      this.keyboardType = TextInputType.text,
      this.initialValue,
      this.errorString = "Error",
      required this.check});

  final TextEditingController? textEditingController;
  final String? hintText;
  final String? initialValue;
  final TextInputType keyboardType;
  final String errorString;
  final Function check;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hintText != null)
          Text(
            hintText ?? "",
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: MasterColors.textColor1, fontWeight: FontWeight.w600),
          ),
        Container(
          margin: EdgeInsets.only(top: Dimensions.height40(context) / 10),
          decoration: BoxDecoration(
              border: Border.all(color: MasterColors.black),
              borderRadius:
                  BorderRadius.circular(Dimensions.height40(context) / 10)),
          child: Padding(
            padding: EdgeInsets.only(
              left: Dimensions.height10(context),
            ),
            child: TextFormField(
              keyboardType: keyboardType,
              validator: (value) {
                if (value == "") {
                  return errorString;
                }

                return null;
              },
              initialValue: initialValue,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              onChanged: (value) => check(),
              controller: textEditingController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: Dimensions.font12(context),
                    color: Colors.grey.shade500),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MasterPasswordTextFieldWidget extends StatefulWidget {
  const MasterPasswordTextFieldWidget({
    super.key,
    this.textEditingController,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.errorString = "Error",
  });

  final TextEditingController? textEditingController;
  final String? hintText;
  final TextInputType keyboardType;
  final String errorString;

  @override
  State<MasterPasswordTextFieldWidget> createState() =>
      _MasterPasswordTextFieldWidgetState();
}

class _MasterPasswordTextFieldWidgetState
    extends State<MasterPasswordTextFieldWidget> {
  bool _passwordVisible = false;
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.height40(context)),
      decoration: BoxDecoration(
          border: Border.all(color: MasterColors.black),
          color: MasterColors.cardBackgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.height10(context))),
      child: Padding(
        padding: EdgeInsets.only(left: Dimensions.height40(context)),
        child: TextFormField(
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          validator: (value) {
            if (value == "") {
              return widget.errorString;
            }
            return null;
          },
          obscureText: !_passwordVisible,
          controller: widget.textEditingController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: Dimensions.font12(context),
                  color: Colors.grey.shade500),
              suffixIcon: GestureDetector(
                onTap: () => setState(() {
                  _passwordVisible = !_passwordVisible;
                }),
                child: Icon(
                  _passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off_rounded,
                  color: MasterColors.buttonColor,
                ),
              )),
        ),
      ),
    );
  }
}

class MasterTextFieldWidgetWithIcon2 extends StatelessWidget {
  const MasterTextFieldWidgetWithIcon2(
      {super.key,
      this.textEditingController,
      this.hintText,
      this.height = 44,
      this.keyboardType = TextInputType.text,
      this.clickEnterFunction,
      this.onTap,
      this.clickSearchButton});

  final TextEditingController? textEditingController;
  final String? hintText;
  final double height;
  final TextInputType keyboardType;
  final Function? clickEnterFunction;
  final Function? clickSearchButton;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final Widget productTextFieldWidget = Container(
        padding: EdgeInsets.only(
            left: Dimensions.height10(context),
            right: Dimensions.height10(context)),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
              textEditingController!.text == ''
                  ? hintText!
                  : textEditingController!.text,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: MasterColors.secondary700, fontSize: 14)),
        ));

    return InkWell(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: height,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Dimensions.height40(context) / 10),
                  border: Border.all(color: MasterColors.black),
                ),
                child: productTextFieldWidget,
              ),
              Positioned(
                right: 1,
                child: Container(
                  width: 50,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.height10(context)),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: MasterColors.black,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
