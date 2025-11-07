import 'package:equatable/equatable.dart';

import 'author_dto.dart';

class AuthorsResponse extends Equatable {
  const AuthorsResponse({
    required this.numFound,
    required this.start,
    required this.numFoundExact,
    required this.docs,
  });

  factory AuthorsResponse.fromJson(Map<String, dynamic> json) {
    final docs = <AuthorDto>[];
    (json['docs'] ?? []).forEach((v) {
      docs.add(AuthorDto.fromJson(v));
    });
    return AuthorsResponse(
      numFound: json['numFound'] ?? -1,
      start: json['start'] ?? -1,
      numFoundExact: json['numFoundExact'] ?? false,
      docs: docs,
    );
  }

  final int numFound;
  final int start;
  final bool numFoundExact;
  final List<AuthorDto> docs;

  @override
  List<Object?> get props => [numFound, start, numFoundExact, docs];
}
