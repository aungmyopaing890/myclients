import 'package:myclients/modules/common/core/view_object/master_object.dart';

abstract class MasterMapObject<T, R> extends MasterObject<T> {
  List<String> getIdList(List<T> mapList);

  T fromPsObject({
    required R obj,
    required String type,
  });
}
