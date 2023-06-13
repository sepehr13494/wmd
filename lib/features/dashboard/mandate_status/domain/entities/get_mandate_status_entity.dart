import 'package:equatable/equatable.dart';
class GetMandateStatusEntity extends Equatable {
  final int mandateId;
  final String dataSource;
  final bool synced;
    const GetMandateStatusEntity({required this.mandateId, required this.dataSource, required this.synced});
    
    Map<String, dynamic> toJson() => {
    
    };

    @override
    List<Object?> get props => [];
}
    