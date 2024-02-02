import 'dart:async';
import 'dart:io';

import 'package:myclients/config/master_config.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AppDataBaseService {
  AppDataBaseService._internal();

  static final AppDataBaseService _singleton = AppDataBaseService._internal();

  static AppDataBaseService get instance => _singleton;

  Completer<Database>? _dbOpenCompleter;

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer<Database>();
      _openDatabase();
    }
    return _dbOpenCompleter!.future;
  }

  Future<dynamic> _openDatabase() async {
    late Database database;
    if (kIsWeb) {
      database =
          await databaseFactoryWeb.openDatabase(MasterConfig.app_db_name);
    } else {
      final Directory appDocumentDir = await getApplicationDocumentsDirectory();
      await appDocumentDir.create(recursive: true);
      final String dbPath = join(appDocumentDir.path, MasterConfig.app_db_name);
      database = await databaseFactoryIo.openDatabase(dbPath);
    }
    _dbOpenCompleter!.complete(database);
  }
}
