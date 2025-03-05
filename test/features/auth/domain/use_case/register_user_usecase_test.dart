import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/features/auth/domain/entity/auth_entity.dart';
import 'package:gear_rental/features/auth/domain/repository/auth_repository.dart';
import 'package:gear_rental/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

// Mock repository class
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  // Register fallback values for AuthEntity and other types as needed
  registerFallbackValue(const AuthEntity(
    username: 'defaultUser',
    email: 'default@example.com',
    password: 'defaultPassword',
    image: null,
  ));

  late MockAuthRepository mockAuthRepository;
  late RegisterUseCase registerUseCase;

  // Test data
  const tUsername = 'testUser';
  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tParams = RegisterUserParams(
    username: tUsername,
    email: tEmail,
    password: tPassword,
  );

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    registerUseCase = RegisterUseCase(mockAuthRepository);
  });

  // Test 1: Should call repository to register a user
  test('should call repository to register a user', () async {
    // Arrange
    when(() => mockAuthRepository.registerUser(any()))
        .thenAnswer((_) async => const Right(null)); // Simulating success

    // Act
    await registerUseCase(tParams);

    // Assert
    verify(() => mockAuthRepository.registerUser(any()))
        .called(1); // Verify repository call
  });

  // Test 2: Should return successful result
  test('should return successful result', () async {
    // Arrange
    when(() => mockAuthRepository.registerUser(any()))
        .thenAnswer((_) async => const Right(null)); // Simulating success

    // Act
    final result = await registerUseCase(tParams);

    // Assert
    expect(result, const Right(null)); // Expecting success
  });

  // Test 3: Should return successful result when params are correct
  test('should return success with correct params', () async {
    // Arrange
    when(() => mockAuthRepository.registerUser(any()))
        .thenAnswer((_) async => const Right(null)); // Simulating success

    // Act
    final result = await registerUseCase(tParams);

    // Assert
    expect(result, const Right(null)); // Expecting success
  });

  // Test 4: Should return successful result when user is registered
  test('should return success when user is registered', () async {
    // Arrange
    when(() => mockAuthRepository.registerUser(any()))
        .thenAnswer((_) async => const Right(null)); // Simulating success

    // Act
    final result = await registerUseCase(tParams);

    // Assert
    expect(result, const Right(null)); // Expecting success
  });
}
