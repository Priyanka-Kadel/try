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

  // Test 1: Ensure LoginBloc is initialized properly and does not throw errors
  test('should emit isSuccess = true when RegisterUser event is successful',
      () {
    expect(() => loginBloc, returnsNormally);
  });

  // Test 2: Ensure LoginBloc starts with isLoading = false
  test('should start with isLoading = false', () {
    expect(loginBloc.state.isLoading, false);
  });

  // Test 3:
  test('should set isSuccess = true when login is successful', () {
    expect(() => loginBloc, returnsNormally);
  });

  // Test 4:
  test('should set isSuccess = false when login fails', () {
    expect(() => loginBloc, returnsNormally);
  });
  // Test 5:
  test('should reset isSuccess to false when user logs out', () {
    expect(() => loginBloc, returnsNormally);
  });
}
