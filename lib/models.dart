class Reservation {
  final int id;
  final String userEmail;
  final CabinType cabinType;
  final ReservationType reservationType;
  final String reservationDate;
  final int nights;
  final double totalAmount;
  final String status;
  final String createdAt;

  Reservation({
    required this.id,
    required this.userEmail,
    required this.cabinType,
    required this.reservationType,
    required this.reservationDate,
    required this.nights,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      userEmail: json['user_email'],
      cabinType: CabinType.fromJson(json['cabin_type']),
      reservationType: ReservationType.fromJson(json['reservation_type']),
      reservationDate: json['reservation_date'],
      nights: json['nights'],
      totalAmount: json['total_amount'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_email': userEmail,
      'cabin_type': cabinType.toJson(),
      'reservation_type': reservationType.toJson(),
      'reservation_date': reservationDate,
      'nights': nights,
      'total_amount': totalAmount,
      'status': status,
      'created_at': createdAt,
    };
  }
}

class CabinType {
  final int id;
  final String cabinName;
  final int capacity;

  CabinType({
    required this.id,
    required this.cabinName,
    required this.capacity,
  });

  factory CabinType.fromJson(Map<String, dynamic> json) {
    return CabinType(
      id: json['id'],
      cabinName: json['cabin_name'],
      capacity: json['capacity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cabin_name': cabinName,
      'capacity': capacity,
    };
  }
}

class ReservationType {
  final int id;
  final String reservationName;
  final String startTime;
  final String endTime;

  ReservationType({
    required this.id,
    required this.reservationName,
    required this.startTime,
    required this.endTime,
  });

  factory ReservationType.fromJson(Map<String, dynamic> json) {
    return ReservationType(
      id: json['id'],
      reservationName: json['reservation_name'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reservation_name': reservationName,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}
