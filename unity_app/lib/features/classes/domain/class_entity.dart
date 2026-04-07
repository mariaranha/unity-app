class ClassEntity {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final String scheduledAt;
  final int? duration;
  final int? availableSpots;

  ClassEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.scheduledAt,
    this.duration,
    this.availableSpots,
  });
}
