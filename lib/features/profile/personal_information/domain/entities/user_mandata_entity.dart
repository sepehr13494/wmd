import 'package:equatable/equatable.dart';

class UserMandateEntity extends Equatable {
  final String mandateId;
  final String dataSource;
  final String syncStatus;

  const UserMandateEntity({
    required this.mandateId,
    required this.dataSource,
    required this.syncStatus,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mandateId'] = mandateId;
    data['dataSource'] = dataSource;
    data['synced'] = syncStatus;

    return data;
  }

  @override
  List<Object?> get props => [
        mandateId,
        dataSource,
        syncStatus,
      ];
}

//create entitiy for with tojson