class ClassEntity {
  final String id;
  final String name;
  final String description;
  final String date;
  final int capacity;
  final String teacherName;
  final int availableSpots;
  final int confirmedReservations;
  final int waitlistCount;
  final List<String> reservedUserIds;

  ClassEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.capacity,
    required this.teacherName,
    required this.availableSpots,
    required this.confirmedReservations,
    required this.waitlistCount,
    required this.reservedUserIds,
  });
}
