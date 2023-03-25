import 'package:equatable/equatable.dart';

class GetGlossariesEntity extends Equatable {
    const GetGlossariesEntity({
        required this.alphabet,
        required this.record,
    });

    final String alphabet;
    final List<RecordEntity> record;



    Map<String, dynamic> toJson() => {
        "alphabet": alphabet,
        "record": List<dynamic>.from(record.map((x) => x.toJson())),
    };

    @override
    List<Object?> get props => [];
}

class RecordEntity extends Equatable{
    const RecordEntity({
        required this.term,
        required this.definition,
    });

    final String term;
    final String definition;


    Map<String, dynamic> toJson() => {
        "term": term,
        "definition": definition,
    };

  @override
  List<Object?> get props => [
      term,
      definition,
  ];
}
    