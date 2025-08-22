import 'package:isar/isar.dart';

part 'vital_signs_entity.g.dart';

@collection
class VitalSignsEntity {
  Id isarId = Isar.autoIncrement;
  final DateTime createdAt;
  final double tempC;
  final int bpSys;
  final int bpDia;
  final int heartRate;

  VitalSignsEntity({
    required this.createdAt,
    required this.tempC,
    required this.bpSys,
    required this.bpDia,
    required this.heartRate,
  });
}