// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<Message123> {
  @override
  final int typeId = 0;

  @override
  Message123 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message123(
      Id: fields[0] as int,
      content: fields[1] as String,
      sender: fields[2] as String,
      status: fields[3] as String,
      datetime: fields[4] as String,
      time: fields[5] != null ? fields[5] as String : "",
      replyId: fields[6] != null ? fields[6] as String : "",
       reciever_id:  fields[7] != null ? fields[7] as String : ""
    );
  }

  @override
  void write(BinaryWriter writer, Message123 obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.Id)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.sender)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.datetime)
      ..writeByte(5)
      ..write(obj.time)
       ..writeByte(6)
    ..write(obj.replyId)
      ..writeByte(7)
      ..write(obj.reciever_id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
