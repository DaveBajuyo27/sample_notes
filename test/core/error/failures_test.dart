import 'package:flutter_test/flutter_test.dart';
import 'package:sample_notes/core/error/failures.dart';

void main() {
  test('should instantiate LocalStorageFailure', () {
    final failure = LocalStorageFailure();
    expect(failure.props, []);
  });

  test('should instantiate NoteNotFoundFailure', () {
    final failure = NoteNotFoundFailure();
    expect(failure.props, []);
  });

  test('should instantiate UnexpectedFailure', () {
    final failure = UnexpectedFailure();
    expect(failure.props, []);
  });

  test(
    'should properly return failure message when UnexpectedFailure.toString is called',
    () {
      final failureString = UnexpectedFailure('Test Failure').toString();
      expect(failureString, 'UnexpectedException: Test Failure');
    },
  );
}
