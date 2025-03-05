import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/app/constatns/hive_table_constants.dart';
import 'package:gear_rental/core/network/hive_service.dart';
import 'package:gear_rental/features/auth/data/model/auth_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';

void main() {
  late HiveService hiveService;
  late Box<AuthHiveModel> authBox;

  setUp(() async {
    await setUpTestHive(); // Sets up a test Hive environment
    hiveService = HiveService();
    Hive.registerAdapter(AuthHiveModelAdapter());
    authBox = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
  });

  tearDown(() async {
    await authBox.close();
    await tearDownTestHive(); // Cleans up the test Hive environment
  });

  test('should register and retrieve a user correctly', () async {
    final auth = AuthHiveModel(
      userId: '1',
      username: 'testUser',
      email: 'test@example.com',
      password: 'test123',
    );

    await hiveService.register(auth);
    final users = await hiveService.getAllAuth();

    expect(users.length, 1);
    expect(users.first.username, 'testUser');
  });

  test('should delete a user from Hive', () async {
    final auth = AuthHiveModel(
      userId: '1',
      username: 'testUser',
      email: 'test@example.com',
      password: 'test123',
    );

    await hiveService.register(auth);
    await hiveService.deleteAuth(auth.userId!);
    final users = await hiveService.getAllAuth();

    expect(users.isEmpty, true);
  });

  test('should return user when valid login credentials are provided',
      () async {
    final auth = AuthHiveModel(
      userId: '1',
      username: 'testUser',
      email: 'test@example.com',
      password: 'test123',
    );

    await hiveService.register(auth);
    final user = await hiveService.login('testUser', 'test123');

    expect(user, isNotNull);
    expect(user!.username, 'testUser');
  });

  test('should clear all data from Hive', () async {
    final auth = AuthHiveModel(
      userId: '1',
      username: 'testUser',
      email: 'test@example.com',
      password: 'test123',
    );

    await hiveService.register(auth);
    await hiveService.clearAll();
    final users = await hiveService.getAllAuth();

    expect(users.isEmpty, true);
  });
}
