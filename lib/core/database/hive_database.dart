import 'package:hive/hive.dart';

class HiveHelper {
  late Box _hiveBox;

  Future<void> createBox(String boxName) async {
    _hiveBox = await Hive.openBox(boxName);
  }

  Future<void> putData({required String key, required dynamic value}) async {
    await _hiveBox.put(key, value);
  }

  dynamic getData({required String key}) {
    return _hiveBox.get(key);
  }

  Future<void> deleteData({required String key}) async {
    await _hiveBox.delete(key);
  }

  Future<void> deleteAllData() async {
    await _hiveBox.deleteAll(_hiveBox.keys);
  }
}
