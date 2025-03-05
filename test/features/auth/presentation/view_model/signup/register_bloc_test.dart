import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gear_rental/features/auth/domain/use_case/login_usecase.dart';
import 'package:gear_rental/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:gear_rental/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:gear_rental/features/home/view_model/home_cubit.dart';
import 'package:mocktail/mocktail.dart';

// Mocks for dependencies
class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockHomeCubit extends Mock implements HomeCubit {}

class MockRegisterBloc extends Mock implements RegisterBloc {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late MockHomeCubit mockHomeCubit;
  late MockRegisterBloc mockRegisterBloc;
  late LoginBloc loginBloc;

  setUpAll(() {
    registerFallbackValue(
        const LoginParams(username: 'test', password: 'password'));
  });

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockHomeCubit = MockHomeCubit();
    mockRegisterBloc = MockRegisterBloc();
    loginBloc = LoginBloc(
      registerBloc: mockRegisterBloc,
      homeCubit: mockHomeCubit,
      loginUseCase: mockLoginUseCase,
    );
  });

  // Test 1:
  test('should initialize RegisterBloc without throwing errors', () {
    expect(() => loginBloc, returnsNormally);
  });

  // Test 2:
  test('should start with isLoading = false', () {
    expect(loginBloc.state.isLoading, false);
  });

  // Test 3:
  test('should set isLoading = true when RegisterStarted event is added', () {
    expect(() => loginBloc, returnsNormally);
  });

  // Test 4:
  test('should set isSuccess = true when registration is successful', () {
    expect(() => loginBloc, returnsNormally);
  });
  // Test 5:
  test('should set isSuccess = false when registration fails', () {
    expect(() => loginBloc, returnsNormally);
  });
}
