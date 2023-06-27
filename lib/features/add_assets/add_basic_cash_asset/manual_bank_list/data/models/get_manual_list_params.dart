import 'package:equatable/equatable.dart';

class GetManualListParams extends Equatable {
    final String bankName;
    final String? recordCount;
    final String? sort;

    const GetManualListParams({
        required this.bankName,
        this.recordCount,
        this.sort,
    });

    factory GetManualListParams.fromJson(Map<String, dynamic> json) =>
        GetManualListParams(
            bankName: json['bankName'],
            recordCount: json['recordCount'],
            sort: json['sort'],
        );

    Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "recordCount": recordCount,
        "sort": sort,
    };

    @override
    List<Object?> get props => [
        bankName,
        recordCount,
        sort,
    ];

    static const tParams = GetManualListParams(bankName: "bankName");
}
