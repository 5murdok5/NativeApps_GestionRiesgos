// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ModelReport {
  String? path;
  String? description;
  int? date;
  ModelReport({
    this.path,
    this.description,
    this.date,
  });

  ModelReport copyWith({
    String? path,
    String? description,
    int? date,
  }) {
    return ModelReport(
      path: path ?? this.path,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'description': description,
      'date': date,
    };
  }

  factory ModelReport.fromMap(Map<String, dynamic> map) {
    return ModelReport(
      path: map['path'] != null ? map['path'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      date: map['date'] != null ? map['date'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelReport.fromJson(String source) =>
      ModelReport.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ModelReport(path: $path, description: $description, date: $date)';

  @override
  bool operator ==(covariant ModelReport other) {
    if (identical(this, other)) return true;

    return other.path == path &&
        other.description == description &&
        other.date == date;
  }

  @override
  int get hashCode => path.hashCode ^ description.hashCode ^ date.hashCode;
}
