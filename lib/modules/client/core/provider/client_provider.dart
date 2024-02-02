// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myclients/config/master_config.dart';
import 'package:myclients/modules/client/core/repository/client_repository.dart';
import 'package:myclients/modules/client/core/view_object/client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ClientProvider extends ChangeNotifier {
  ClientProvider({
    required ClientRepository repository,
    int limit = 0,
  }) {
    _repository = repository;
    debugPrint('${runtimeType.toString()} Init $hashCode');
    _listObjectSubScription();
  }

  late ClientRepository _repository;

  List<ClientVO> data = [];
  bool isLoading = false;

  late StreamController<List<ClientVO>> dataListStreamController;
  late StreamSubscription<List<ClientVO>> _dataListStreamSubscription;

  void _listObjectSubScription() {
    dataListStreamController = StreamController<List<ClientVO>>.broadcast();
    _dataListStreamSubscription =
        dataListStreamController.stream.listen((List<ClientVO> resource) async {
      data = resource;
    });
  }

  Future<void> loadDataList() async {
    isLoading = true;
    await _repository.loadDataList(streamController: dataListStreamController);
    isLoading = false;
    notifyListeners();
  }

  List<ClientVO> searchData = [];

  Future<void> searchClient(String keyword) async {
    isLoading = true;
    searchData.clear();
    if (hasData) {
      for (var client in data) {
        if (client.name().toLowerCase().contains(keyword.toLowerCase())) {
          searchData.add(client);
        }
      }
    }
    isLoading = false;
    notifyListeners();
  }

  bool get hasSerchData {
    return searchDataLength > 0;
  }

  int get searchDataLength {
    return searchData.length;
  }

  ClientVO getSearhListIndexOf(int index) {
    if (searchData != null && searchData.isNotEmpty && dataLength > index) {
      return searchData[index];
    } else {
      return ClientVO();
    }
  }

  Future<void> insert(ClientVO clientVO) async {
    clientVO.id = const Uuid().v4();
    await _repository.insert(clientVO);
    await loadDataList();
    notifyListeners();
  }

  Future<void> insertJson() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    bool isInserted =
        shared.getBool(MasterConfig.is_json_inserted_to_db) ?? false;
    if (!isInserted) {
      for (var e in await _loadFromAsset()) {
        e.id = const Uuid().v4();
        await _repository.insert(e);
      }
      shared.setBool(MasterConfig.is_json_inserted_to_db, true);
    }
    notifyListeners();
  }

  Future<List<ClientVO>> _loadFromAsset() async => ClientVO().fromMapList(
      json.decode(await rootBundle.loadString('assets/clients.json')));

  Future<dynamic> delete(String id) async {
    var res = await _repository.delete(id);
    notifyListeners();
    loadDataList();
    return res;
  }

  Future<dynamic> deleteAll() async {
    var res = await _repository.deleteAll();
    notifyListeners();
    loadDataList();
    return res;
  }

  bool get hasData {
    return dataLength > 0;
  }

  int get dataLength {
    return data.length;
  }

  List<ClientVO>? getDataList() {
    if (data != null && data.isNotEmpty) {
      return data;
    } else {
      return [];
    }
  }

  ClientVO getListIndexOf(int index) {
    if (data != null && data.isNotEmpty && data.length > index) {
      return data[index];
    } else {
      return ClientVO();
    }
  }

  @override
  void dispose() {
    _stopSubscription();
    debugPrint('${runtimeType.toString()} Dispose $hashCode');
    super.dispose();
  }

  void _stopSubscription() {
    _dataListStreamSubscription.cancel();
  }
}
