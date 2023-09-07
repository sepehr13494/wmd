import 'package:equatable/equatable.dart';

class UserMandateEntity extends Equatable {
  final String mandateId;
  final String dataSource;
  final bool synced;

  const UserMandateEntity({
    required this.mandateId,
    required this.dataSource,
    required this.synced,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mandateId'] = mandateId;
    data['dataSource'] = dataSource;
    data['synced'] = synced;

    return data;
  }

  @override
  List<Object?> get props => [
        mandateId,
        dataSource,
        synced,
      ];
}

//create entitiy for with tojson