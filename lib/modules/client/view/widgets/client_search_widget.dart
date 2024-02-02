import 'package:flutter/material.dart';
import 'package:myclients/config/master_colors.dart';
import 'package:myclients/config/master_config.dart';
import 'package:myclients/modules/common/core/utils/dimesions.dart';

class ClientSearchWidget extends StatelessWidget {
  const ClientSearchWidget({super.key, required this.searchController});
  final TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.screenWidth(context) * 0.3,
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
        controller: searchController,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: MasterColors.black),
        onTap: () async {},
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
