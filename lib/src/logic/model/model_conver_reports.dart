import 'package:gestionriesgos/src/logic/model/model_report.dart';
import 'dart:convert';

class ModelConvertReport {
  List<ModelReport>? list;
  ModelConvertReport({
    this.list,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'list': list?.map((x) => x.toMap()).toList(),
    };
  }

  factory ModelConvertReport.fromMap(Map<String, dynamic> map) {
    return ModelConvertReport(
      list: map['list'] != null
          ? List<ModelReport>.from(
              (map['list'] as List<dynamic>).map<ModelReport?>(
                (x) => ModelReport.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelConvertReport.fromJson(String source) =>
      ModelConvertReport.fromMap(json.decode(source) as Map<String, dynamic>);
}
