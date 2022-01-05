// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TestResultAdapter extends TypeAdapter<TestResult> {
  @override
  final int typeId = 0;

  @override
  TestResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TestResult()
      ..spot = fields[0] as String?
      ..isFeel = fields[1] as bool?
      ..testDate = fields[2] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, TestResult obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.spot)
      ..writeByte(1)
      ..write(obj.isFeel)
      ..writeByte(2)
      ..write(obj.testDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
