import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/core/error/failure.dart';

void main() {
  group('Failure Tests', () {
    test('should check equality of Failure objects', () {
      const failure1 = LocalDatabaseFailure(message: "Database error occurred");
      const failure2 = LocalDatabaseFailure(message: "Database error occurred");
      const failure3 = ApiFailure(message: "API error", statusCode: 500);

      expect(failure1, equals(failure2)); // Same messages should be equal
      expect(failure1,
          isNot(equals(failure3))); // Different classes should not be equal
    });

    test('should retain correct message and properties', () {
      const localDbFailure = LocalDatabaseFailure(message: "Local DB error");
      const apiFailure = ApiFailure(message: "API failed", statusCode: 404);
      const sharedPrefsFailure = SharedPrefsFailure(message: "Prefs error");

      expect(localDbFailure.message, "Local DB error");
      expect(apiFailure.message, "API failed");
      expect(apiFailure.statusCode, 404);
      expect(sharedPrefsFailure.message, "Prefs error");
    });
  });
}
