import 'package:unity_app/features/classes/domain/class_entity.dart';

class ClassModel extends ClassEntity {
  ClassModel({
    required super.id,
    required super.name,
    required super.description,
    required super.date,
    required super.capacity,
    required super.teacherName,
    required super.availableSpots,
    required super.confirmedReservations,
    required super.waitlistCount,
    required super.reservedUserIds,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    final teacher = json['teacher'] as Map<String, dynamic>;
    final reservations = (json['reservation'] as List<dynamic>? ?? []);

    return ClassModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      date: json['date'],
      capacity: json['capacity'],
      teacherName: teacher['name'],
      availableSpots: json['availableSpots'],
      confirmedReservations: json['confirmedReservations'],
      waitlistCount: json['waitlistCount'],
      reservedUserIds: reservations
          .map((r) => r['user_id'] as String)
          .toList(),
    );
  }
}
