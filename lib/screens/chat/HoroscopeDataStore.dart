

import 'package:community_matrimonial/screens/chat/models/horoscope.dart';
import 'package:community_matrimonial/screens/chat/models/message.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HoroscopeDataStore {
  static const boxName = "horoscope";



  // Get reference to an already opened box
  static Box<Horoscope> box = Hive.box<Horoscope>(boxName);

  /// Add new user
  Future<void> addMessage({required Horoscope horoscope}) async {
    await box.add(horoscope);

  }


}
