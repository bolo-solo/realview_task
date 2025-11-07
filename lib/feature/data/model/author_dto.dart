import 'package:equatable/equatable.dart';

class AuthorDto extends Equatable {
  const AuthorDto({
    required this.authorName,
    required this.id,
    required this.topWork,
    required this.ratingsAverage,
    required this.currentlyReading,
    required this.workCount,
  });

  factory AuthorDto.fromJson(Map<String, dynamic> json) => AuthorDto(
    authorName: json['name'] ?? '',
    id: json['key'] ?? '',
    topWork: json['top_work'] ?? '',
    ratingsAverage: (json['ratings_average'] != null)
        ? (json['ratings_average'] as num).toDouble()
        : 0.0,
    currentlyReading: json['currently_reading_count'] ?? 0,
    workCount: json['work_count'] ?? 0,
  );

  final String authorName;
  final String id;
  final String topWork;
  final double ratingsAverage;
  final int currentlyReading;
  final int workCount;

  @override
  List<Object?> get props => [
    authorName,
    id,
    topWork,
    ratingsAverage,
    currentlyReading,
    workCount,
  ];
}
