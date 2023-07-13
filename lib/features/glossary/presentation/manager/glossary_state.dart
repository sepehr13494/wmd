part of 'glossary_cubit.dart';

abstract class GlossaryState {}

class GetGlossariesLoaded extends Equatable with GlossaryState{
  final List<GetGlossariesEntity> getGlossariesEntities;
  

  GetGlossariesLoaded({
    required this.getGlossariesEntities,
    
  });

  @override
  List<Object?> get props => [
    getGlossariesEntities,
    
  ];
}

    