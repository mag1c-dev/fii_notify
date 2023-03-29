import 'package:equatable/equatable.dart';

abstract class Usecase<Type, Param> {
  Type call(Param param);
}

class NoParam extends Equatable {
  @override
  List<Object?> get props => [];
}
