// 📦 Package imports:
import 'package:isar/isar.dart';

part 'vital_signs_entity.g.dart';

/// Represents a vital signs record for local data storage using the Isar database.
///
/// This class is a data model for a collection of vital signs measurements in the
/// Isar database. It includes fields for the date and time of the measurement,
/// body temperature, blood pressure (systolic and diastolic), and heart rate.
///
/// The `@collection` annotation and `part` directive enable Isar to automatically
/// generate the necessary code for database operations on this class.
@collection
class VitalSignsEntity {
  /// The unique identifier for this vital signs record in the Isar database.
  ///
  /// `Isar.autoIncrement` ensures that a new, unique ID is assigned for each
  /// record, which serves as a reliable primary key.
  Id isarId = Isar.autoIncrement;

  /// The date and time when the vital signs were recorded.
  ///
  /// This field is crucial for tracking vital signs over time.
  final DateTime createdAt;

  /// The body temperature in Celsius.
  final double tempC;

  /// The systolic blood pressure reading.
  final int bpSys;

  /// The diastolic blood pressure reading.
  final int bpDia;

  /// The heart rate in beats per minute (BPM).
  final int heartRate;

  /// Creates a new [VitalSignsEntity] instance.
  ///
  /// Requires all vital signs measurements to be provided at the time of creation.
  VitalSignsEntity({
    required this.createdAt,
    required this.tempC,
    required this.bpSys,
    required this.bpDia,
    required this.heartRate,
  });
}
