import 'package:unity_app/features/classes/domain/class_entity.dart';

class ClassModel extends ClassEntity {
  ClassModel({
    required super.id,
    required super.title,
    required super.description,
    required super.instructor,
    required super.scheduledAt,
    super.duration,
    super.availableSpots,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      instructor: json['instructor'] ?? '',
      scheduledAt: json['scheduledAt'] ?? json['scheduled_at'] ?? '',
      duration: json['duration'],
      availableSpots: json['availableSpots'] ?? json['available_spots'],
    );
  }
}
