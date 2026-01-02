import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

class LocalStorageFailure extends Failure {}

class NoteNotFoundFailure extends Failure {}

class UnexpectedFailure extends Failure {
  final String message;
  const UnexpectedFailure([this.message = 'An unexpected error occurred']);
  @override
  String toString() => 'UnexpectedException: $message';
}
