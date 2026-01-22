

import 'package:community_matrimonial/screens/chat/models/message.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class MessageDataStore {
  static const boxName = "messages";



  // Get reference to an already opened box
  static Box<Message123> box = Hive.box<Message123>(boxName);



  /// Add new user
  Future<void> addMessage({required Message123 message}) async {
    await box.add(message);

    print(message.content+"{}{}");
  }

  /// show user list
  Future<void> getMessage({required String id})async{
    await box.get(id);
  }

  /// update user data
  Future<void> updateUser({required int index,required Message123 message}) async {
    await box.putAt(index,message);
  }

  /// delete user
  Future<void> deleteUser({required int index}) async {
    await box.deleteAt(index);
  }

  Future<void> clearData({required int index}) async {
    await box.clear();
  }

}
