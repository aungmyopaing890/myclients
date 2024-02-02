// ignore_for_file: constant_identifier_names

import 'package:myclients/modules/common/core/db/app_db_service.dart';
import 'package:myclients/modules/common/core/view_object/master_object.dart';
import 'package:myclients/modules/common/core/view_object/map_object.dart';
import 'package:flutter/material.dart';
import 'package:sembast/sembast.dart';

abstract class MasterDbService<T extends MasterObject<T>> {
  String sortingKey = 'sort';
  late T obj;

  late StoreRef<String?, dynamic> dao;

  Future<Database> get db async => await AppDataBaseService.instance.database;

  void init(T obj) {
    debugPrint("=========Init ${getStoreName()} DB===============");
    dao = stringMapStoreFactory.store(getStoreName());
    this.obj = obj;
  }

  String getStoreName();

  dynamic getPrimaryKey(T object);
  Filter getFilter(String guid);

  Future<dynamic> insert(T object) async =>
      await dao.record(object.getPrimaryKey()).put(await db, obj.toMap(object));

  Future<dynamic> insertAll(List<T> objectList) async {
    final List<String> idList = <String>[];
    final dynamic recordSnapshots = await dao.find(
      await db,
      finder: Finder(),
    );
    int count = recordSnapshots.length;
    for (T data in objectList) {
      idList.add(data.getPrimaryKey() ?? '');
    }
    final List<Map<String, dynamic>?> jsonList = obj.toMapList(objectList);
    for (int i = 0; i < jsonList.length; i++) {
      jsonList[i]![sortingKey] = count++;
    }
    await dao.records(idList).put(await db, jsonList);
  }

  Future<T> getOne({Finder? finder, required String guid}) async {
    dynamic data = await dao.find(
      await db,
      finder: finder ?? Finder(filter: getFilter(guid)),
    );
    return obj.fromMap(data[0]);
  }

  Future<List<T>> getAll({
    Finder? finder,
  }) async {
    return obj.fromMapList(await dao.find(
      await db,
      finder: finder ?? Finder(),
    ));
  }

  Future<dynamic> updateWithFinder(T object) async => await dao.update(
        await db,
        object.toMap(object),
        finder: Finder(filter: getFilter(object.getPrimaryKey() ?? "")),
      );

  Future<dynamic> deleteAll() async => await dao.delete(await db);

  Future<dynamic> delete(String guid, {Finder? finder}) async =>
      await dao.delete(
        await db,
        finder: finder ?? Finder(filter: getFilter(guid)),
      );

  Future<dynamic> deleteWithFinder(Finder finder) async {
    await dao.delete(
      await db,
      finder: finder,
    );
  }

  Future<List<T>> getAllByMap<K extends MasterMapObject<dynamic, dynamic>>(
    String primaryKey,
    String paramKey,
    MasterDbService<MasterObject<dynamic>> mapDao,
    dynamic mapObj, {
    List<SortOrder>? sortOrderList,
  }) async {
    final List<MasterObject<dynamic>> dataList = await mapDao.getAll(
        finder: Finder(
            filter: Filter.equals("map_key", paramKey),
            sortOrders: <SortOrder>[SortOrder('sorting', true)]));
    final List<String> valueList = mapObj.getIdList(dataList);
    final Finder finder = Finder(
      filter: Filter.inList(primaryKey, valueList),
    );
    if (sortOrderList != null && sortOrderList.isNotEmpty) {
      finder.sortOrders = sortOrderList;
    }
    final dynamic recordSnapshots = await dao.find(
      await db,
      finder: finder,
    );
    final List<T> resultList = <T>[];
    // sorting
    for (String id in valueList) {
      for (dynamic snapshot in recordSnapshots) {
        if (snapshot.value[primaryKey] == id) {
          resultList.add(obj.fromMap(snapshot.value));
          break;
        }
      }
    }
    return resultList;
  }
}
