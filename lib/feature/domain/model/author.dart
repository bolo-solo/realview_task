import 'package:equatable/equatable.dart';

import '../../data/model/author_dto.dart';

class Author extends Equatable {
  const Author({
    required this.authorName,
    required this.id,
    required this.topWork,
    required this.ratingsAverage,
    required this.currentlyReading,
    required this.workCount,
  });

  factory Author.fromDto(AuthorDto dto) => Author(
    authorName: dto.authorName,
    id: dto.id,
    topWork: dto.topWork,
    ratingsAverage: dto.ratingsAverage,
    currentlyReading: dto.currentlyReading,
    workCount: dto.workCount,
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
