import 'package:equatable/equatable.dart';
import 'package:loczone/core/utils/app_strings.dart';

abstract class Failure extends Equatable {
  final String? message;
  const Failure({this.message});

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = AppStrings.serverError});

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = AppStrings.networkError});

  @override
  List<Object?> get props => [message];
}

class ResponseFailure extends Failure {
  const ResponseFailure({required super.message});

  @override
  List<Object?> get props => [message];
}
