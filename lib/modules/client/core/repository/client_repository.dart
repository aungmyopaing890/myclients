import 'dart:async';

import 'package:myclients/modules/client/core/service/client_db_service.dart';
import 'package:myclients/modules/client/core/view_object/client.dart';

class ClientRepository {
  ClientRepository({required ClientDbService dbService}) {
    _dbService = dbService;
  }

  late ClientDbService _dbService;
  Future<void> loadDataList({
    required StreamController<List<ClientVO>> streamController,
  }) async {
    var data = await _dbService.getAll();
    streamController.sink.add(data);
  }

  Future<void> loadData(
      {required StreamController<ClientVO> streamController,
      required String id}) async {
    var data = await _dbService.getOne(guid: id);
    streamController.sink.add(data);
  }

  Future<dynamic> insert(ClientVO object) async {
    return await _dbService.insert(object);
  }

  Future<dynamic> update(ClientVO object) async {
    return await _dbService.updateWithFinder(object);
  }

  Future<dynamic> delete(String id) async {
    return await _dbService.delete(id);
  }

  Future<dynamic> deleteAll() async {
    return await _dbService.deleteAll();
  }
}
