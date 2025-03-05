import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';

void main() {
  group('AuthEntity', () {
    const username = 'priyanka';
    const email = 'priyanka@example.com';
    const password = 'password123';
    const userId = '12345';
    const image = 'image_url';

    test('should create an instance of AuthEntity with given values', () {
      const authEntity = AuthEntity(
        userId: userId,
        image: image,
        username: username,
        email: email,
        password: password,
      );

      expect(authEntity.userId, userId);
      expect(authEntity.image, image);
      expect(authEntity.username, username);
      expect(authEntity.email, email);
      expect(authEntity.password, password);
    });

    test('should correctly compare two instances using Equatable', () {
      const authEntity1 = AuthEntity(
        userId: userId,
        image: image,
        username: username,
        email: email,
        password: password,
      );
      const authEntity2 = AuthEntity(
        userId: userId,
        image: image,
        username: username,
        email: email,
        password: password,
      );
      const authEntity3 = AuthEntity(
        userId: '67890',
        image: 'another_image_url',
        username: 'priya',
        email: 'priya@example.com',
        password: 'password123',
      );

      expect(authEntity1, authEntity2); // Should be equal
      expect(authEntity1, isNot(authEntity3)); // Should not be equal
    });
  });
}
