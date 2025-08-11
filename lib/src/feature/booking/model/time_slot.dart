/// {@template time_slot}
/// Simple model to represent a time slot.
/// {@endtemplate}
class TimeSlot {
  /// {@macro time_slot}
  const TimeSlot({
    /// The datetime of the time slot.
    required this.time,

    /// The status of the time slot.
    this.status = TimeSlotStatus.available,
  });

  /// The datetime of the time slot.
  final DateTime time;

  /// The status of the time slot.
  final TimeSlotStatus status;

  /// Whether the time slot is available.
  bool get isAvailable => status.isAvailable;
}

/// Represents a booked time slot, which is always unavailable.
class BookedTimeSlot extends TimeSlot {
  /// Creates a [BookedTimeSlot] with the specified [time], [department], and [user].
  /// The [status] is always set to [TimeSlotStatus.booked].
  const BookedTimeSlot({
    required super.time,
    required this.department,
    required this.user,
    super.status = TimeSlotStatus.booked,
  });

  /// The department associated with the booking.
  final String department;

  /// The user who booked the time slot.
  final String user;

  @override
  bool get isAvailable => false;
}

/// Enum representing the status of a time slot.
enum TimeSlotStatus {
  /// Indicates the time slot is available.
  available,

  /// Indicates the time slot is booked.
  booked;

  /// Creates a [TimeSlotStatus] from a JSON string.
  factory TimeSlotStatus.fromJson(String json) => switch (json) {
    'booked' => booked,
    _ => available,
  };

  /// Converts the [TimeSlotStatus] to a JSON string.
  String toJson() => switch (this) {
    booked => 'booked',
    _ => 'available',
  };

  /// Checks if the time slot is available.
  bool get isAvailable => this == TimeSlotStatus.available;
}

class TimeSlotDto {
  const TimeSlotDto({
    required this.time,
    required this.status,
    required this.user,
    required this.department,
  });

  factory TimeSlotDto.fromJson(Map<String, dynamic> json) => TimeSlotDto(
    time: DateTime.parse(json['time'].toString()),
    status: json['status'] as String,
    user: json['user'] as String?,
    department: json['department'] as String?,
  );

  factory TimeSlotDto.fromEntity(TimeSlot timeSlot) => TimeSlotDto(
    time: timeSlot.time,
    status: timeSlot.status.toJson(),
    user: null,
    department: null,
  );

  final DateTime time;
  final String status;
  final String? user;
  final String? department;

  TimeSlot toEntity() {
    if (department != null && user != null) {
      return BookedTimeSlot(time: time, department: department!, user: user!);
    }

    return TimeSlot(time: time);
  }
}
