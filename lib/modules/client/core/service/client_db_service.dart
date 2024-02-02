// ignore_for_file: constant_identifier_names

import 'package:myclients/modules/client/core/view_object/client.dart';
import 'package:myclients/modules/common/core/db/master_db_service.dart';
import 'package:sembast/sembast.dart';

class ClientDbService extends MasterDbService<ClientVO> {
  ClientDbService._() {
    init(ClientVO());
  }
  static const String STORE_NAME = 'ClientVO';
  final String _primaryKey = 'id';

  // Singleton instance
  static final ClientDbService _singleton = ClientDbService._();

  // Singleton accessor
  static ClientDbService get instance => _singleton;

  @override
  String getStoreName() {
    return STORE_NAME;
  }

  @override
  String? getPrimaryKey(ClientVO object) {
    return object.id;
  }

  @override
  Filter getFilter(String id) {
    return Filter.equals(_primaryKey, id);
  }

  @override
  Future<ClientVO> getOne({Finder? finder, required String guid}) async {
    Filter filter = getFilter(guid);
    dynamic data = await dao.find(
      await db,
      finder: finder ?? Finder(filter: filter),
    );
    dynamic re = obj.fromMap(data[0]);
    return re;
  }
}
