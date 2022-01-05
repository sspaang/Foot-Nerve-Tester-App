import 'package:hive/hive.dart';

part 'test_result.g.dart';

@HiveType(typeId: 0)
class TestResult extends HiveObject {
  @HiveField(0)
  late String? spot;

  @HiveField(1)
  late bool? isFeel;

  @HiveField(2)
  late DateTime? testDate;
}
