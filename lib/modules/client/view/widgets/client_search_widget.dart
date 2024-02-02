import 'package:flutter/material.dart';
import 'package:myclients/config/master_colors.dart';
import 'package:myclients/config/master_config.dart';
import 'package:myclients/modules/client/core/provider/client_provider.dart';
import 'package:myclients/modules/common/core/utils/dimesions.dart';
import 'package:myclients/modules/common/core/utils/utils.dart';
import 'package:provider/provider.dart';

class ClientSearchWidget extends StatefulWidget {
  const ClientSearchWidget(
      {super.key,
      required this.searchController,
      required this.funSetstate,
      this.width});
  final TextEditingController searchController;
  final Function funSetstate;
  final double? width;

  @override
  State<ClientSearchWidget> createState() => _ClientSearchWidgetState();
}

class _ClientSearchWidgetState extends State<ClientSearchWidget> {
  final debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final ClientProvider provider = Provider.of<ClientProvider>(context);
    return Container(
      width: widget.width ?? Dimensions.screenWidth(context) * 0.3,
      alignment: Alignment.center,
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.height10(context) / 2),
      decoration: BoxDecoration(
          color: MasterColors.white,
          border: Border.all(color: MasterColors.secondary30),
          borderRadius: BorderRadius.circular(MasterConfig.borderRadious)),
      child: TextField(
        readOnly: false,
        autofocus: false,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        maxLines: null,
        controller: widget.searchController,
        onChanged: (String value) {
          widget.funSetstate();

          debouncer.run(() {
            if (widget.searchController.text != '') {
              provider.searchClient(value);
            }
            setState(() {});
          });
        },
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: MasterColors.black),
        onTap: () async {
          widget.funSetstate();
          debouncer.run(() {
            if (widget.searchController.text != '') {
              provider.searchClient(widget.searchController.text);
            }
            setState(() {});
          });
        },
        decoration: InputDecoration(
          fillColor: MasterColors.white,
          contentPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.height10(context) / 2),
          border: InputBorder.none,
          hintText: "Search clients...",
          hintStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: MasterColors.secondary20),
          suffixIcon: Icon(
            Icons.search,
            color: MasterColors.secondary30,
          ),
        ),
      ),
    );
  }
}
