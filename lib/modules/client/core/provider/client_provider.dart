// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myclients/modules/client/core/repository/client_repository.dart';
import 'package:myclients/modules/client/core/view_object/client.dart';

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

  Future<void> insert(ClientVO clientVO) async {
    await _repository.insert(clientVO);
    await loadDataList();
    notifyListeners();
  }

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
