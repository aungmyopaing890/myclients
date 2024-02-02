import 'package:myclients/modules/common/core/view_object/master_object.dart';

class ClientVO extends MasterObject<ClientVO> {
  ClientVO({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  @override
  String getPrimaryKey() {
    return id ?? '';
  }

  String name() {
    return "$firstName $lastName";
  }

  @override
  ClientVO fromMap(dynamic dynamicData) {
    if (dynamicData != null) {
      return ClientVO(
        id: dynamicData['id'],
        firstName: dynamicData['first_name'],
        lastName: dynamicData['last_name'],
        email: dynamicData['email'],
        phoneNumber: dynamicData['phone_number'],
      );
    } else {
      return ClientVO();
    }
  }

  @override
  Map<String, dynamic>? toMap(ClientVO object) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = object.id;
    data['first_name'] = object.firstName;
    data['last_name'] = object.lastName;
    data['email'] = object.email;
    data['phone_number'] = object.phoneNumber;
    return data;
  }

  @override
  List<ClientVO> fromMapList(List<dynamic> dynamicDataList) {
    final List<ClientVO> subUserList = <ClientVO>[];
    for (dynamic dynamicData in dynamicDataList) {
      if (dynamicData != null) {
        subUserList.add(fromMap(dynamicData));
      }
    }
    return subUserList;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ClientVO> objectList) {
    final List<Map<String, dynamic>?> mapList = <Map<String, dynamic>?>[];
    for (ClientVO? data in objectList) {
      if (data != null) {
        mapList.add(toMap(data));
      }
    }
    return mapList;
  }
}
