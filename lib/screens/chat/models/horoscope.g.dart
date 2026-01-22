// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horoscope.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************



class HoroscopeAdapter extends TypeAdapter<Horoscope> {
  @override
  final int typeId = 1;

  @override
  Horoscope read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Horoscope(
        Id: fields[0] as int,
        myId: fields[1] as String,
        otheruserId: fields[2] as String,
        birth_chart: fields[3] as String,
        gunmilan: fields[4] as String
    );
  }

  @override
  void write(BinaryWriter writer, Horoscope obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.Id)
      ..writeByte(1)
      ..write(obj.myId)
      ..writeByte(2)
      ..write(obj.otheruserId)
      ..writeByte(3)
      ..write(obj.birth_chart)
      ..writeByte(4)
      ..write(obj.gunmilan);

  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is HoroscopeAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
