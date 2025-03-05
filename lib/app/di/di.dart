import 'package:dio/dio.dart';
import 'package:gear_rental/core/network/api_service.dart';
import 'package:gear_rental/core/network/hive_service.dart';
import 'package:gear_rental/features/auth/data/data_source/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:gear_rental/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:gear_rental/features/auth/data/repository/auth_local_repository.dart';
import 'package:gear_rental/features/auth/data/repository/auth_remote_repository.dart';
import 'package:gear_rental/features/auth/domain/repository/auth_repository.dart';
import 'package:gear_rental/features/auth/domain/use_case/login_usecase.dart';
import 'package:gear_rental/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:gear_rental/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:gear_rental/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:gear_rental/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:gear_rental/features/home/view_model/home_cubit.dart';
import 'package:gear_rental/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();

  await _initSplashScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  // Remote Data Source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initRegisterDependencies() {
  // Initialize local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // Initialize local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // ✅ Register Remote Data Source (Fixing the issue)
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  // ✅ Now Register Remote Repository correctly
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  // Register RegisterUseCase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>() as IAuthRepository,
    ),
  );

  // Register RegisterBloc with the dependencies it needs
  getIt.registerLazySingleton<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt<RegisterUseCase>(),
      uploadImageUsecase: getIt<UploadImageUsecase>(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}
