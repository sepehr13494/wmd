import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:wmd/core/data/network/error_handler_middleware.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/data/data_sources/plaid_data_source.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/data/repository/plaid_repository_impl.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/domain/repository/plaid_repository.dart';
import 'package:wmd/features/add_assets/add_bank_auto/plaid_integration/domain/usecase/plaid_usecase.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/data/data_sources/bank_list_data_source.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/data/repository/bank_list_repository_impl.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/domain/usecase/get_bank_list.dart';
import 'package:wmd/features/add_assets/add_bank_auto/view_bank_list/presentation/manager/bank_list_cubit.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/data/data_sources/bank_details_save_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/data/repositories/bank_repository_impl.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/repositories/bank_repository.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/domain/use_cases/post_bank_details_usecase.dart';
import 'package:wmd/features/add_assets/add_basic_cash_asset/presentation/manager/bank_cubit.dart';
import 'package:wmd/features/add_assets/add_listed_security/data/data_sources/listed_security_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_listed_security/data/repositories/listed_security_repository_impl.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/repositories/listed_security_repository.dart';
import 'package:wmd/features/add_assets/add_listed_security/domain/use_cases/add_listed_security_usecase.dart';
import 'package:wmd/features/add_assets/add_listed_security/presentation/manager/listed_security_cubit.dart';
import 'package:wmd/features/add_assets/add_loan_liability/data/data_sources/loan_liability_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_loan_liability/data/repositories/loan_liability_repository_impl.dart';
import 'package:wmd/features/add_assets/add_loan_liability/domain/repositories/loan_liability_repository.dart';
import 'package:wmd/features/add_assets/add_loan_liability/domain/use_cases/add_loan_liability_usecase.dart';
import 'package:wmd/features/add_assets/add_loan_liability/presentation/manager/loan_liability_cubit.dart';
import 'package:wmd/features/add_assets/add_other_asset/data/data_sources/other_asset_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_other_asset/data/repositories/other_asset_repository_impl.dart';
import 'package:wmd/features/add_assets/add_other_asset/domain/repositories/other_asset_repository.dart';
import 'package:wmd/features/add_assets/add_other_asset/domain/use_cases/add_other_asset_usecase.dart';
import 'package:wmd/features/add_assets/add_other_asset/presentation/manager/other_asset_cubit.dart';
import 'package:wmd/features/add_assets/add_private_debt/data/data_sources/private_debt_save_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_private_debt/data/repositories/private_debt_repository_impl.dart';
import 'package:wmd/features/add_assets/add_private_debt/domain/repositories/private_debt_repository.dart';
import 'package:wmd/features/add_assets/add_private_debt/domain/use_cases/add_private_debt_usecase.dart';
import 'package:wmd/features/add_assets/add_private_debt/presentation/manager/private_debt_cubit.dart';
import 'package:wmd/features/add_assets/add_private_equity/data/data_sources/private_equity_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_private_equity/data/repositories/private_equity_repository_impl.dart';
import 'package:wmd/features/add_assets/add_private_equity/domain/repositories/private_equity_repository.dart';
import 'package:wmd/features/add_assets/add_private_equity/domain/use_cases/add_private_equity_usecase.dart';
import 'package:wmd/features/add_assets/add_private_equity/presentation/manager/private_equity_cubit.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/data_sources/custodian_bank_auth_remote_datasource.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/data/repositories/custodian_bank_auth_repository_impl.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/repositories/custodian_bank_auth_repository.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/use_cases/get_custodian_bank_list_usecase.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_bank_auth_cubit.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_status_list_cubit.dart';
import 'package:wmd/features/asset_detail/core/data/data_sources/asset_detail_remote_datasource.dart';
import 'package:wmd/features/asset_detail/core/data/repositories/asset_detail_repository_impl.dart';
import 'package:wmd/features/asset_detail/core/domain/repositories/asset_detail_repository.dart';
import 'package:wmd/features/asset_detail/core/domain/use_cases/get_detail_usecase.dart';
import 'package:wmd/features/asset_detail/core/presentation/manager/asset_detail_cubit.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/data_sources/asset_overview_remote_datasource.dart';
import 'package:wmd/features/assets_overview/assets_overview/data/repositories/assets_overview_repository_impl.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/repositories/assets_overview_repository.dart';
import 'package:wmd/features/assets_overview/assets_overview/domain/use_cases/get_assets_overview_usecase.dart';
import 'package:wmd/features/assets_overview/assets_overview/presentation/manager/assets_overview_cubit.dart';
import 'package:wmd/features/add_assets/add_real_estate/data/data_sources/real_estate_remote_data_source.dart';
import 'package:wmd/features/add_assets/add_real_estate/data/repositories/real_estate_repository_impl.dart';
import 'package:wmd/features/add_assets/add_real_estate/domain/repositories/real_estate_repository.dart';
import 'package:wmd/features/add_assets/add_real_estate/domain/use_cases/add_real_estate_usecase.dart';
import 'package:wmd/features/add_assets/add_real_estate/presentation/manager/real_estate_cubit.dart';
import 'package:wmd/features/assets_overview/charts/data/data_sources/charts_remote_datasource.dart';
import 'package:wmd/features/assets_overview/charts/data/repositories/charts_repository_impl.dart';
import 'package:wmd/features/assets_overview/charts/domain/repositories/charts_repository.dart';
import 'package:wmd/features/assets_overview/charts/domain/use_cases/get_chart_usecase.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/charts_cubit.dart';
import 'package:wmd/features/authentication/forget_password/data/data_sources/forget_password_server_datasource.dart';
import 'package:wmd/features/authentication/forget_password/data/repositories/forget_password_repository_impl.dart';
import 'package:wmd/features/authentication/forget_password/domain/repositories/forget_password_repository.dart';
import 'package:wmd/features/authentication/forget_password/domain/use_cases/forget_password_usecase.dart';
import 'package:wmd/features/authentication/forget_password/domain/use_cases/reset_password_usecase.dart';
import 'package:wmd/features/authentication/forget_password/presentation/manager/forget_password_cubit.dart';
import 'package:wmd/features/authentication/login_signup/data/data_sources/login_sign_up_remote_data_source.dart';
import 'package:wmd/features/authentication/login_signup/data/repositories/login_sign_up_repository_impl.dart';
import 'package:wmd/features/authentication/login_signup/domain/repositories/login_sign_up_repository.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_register_usecase.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/resend_email_usecase.dart';
import 'package:wmd/features/authentication/login_signup/presentation/manager/login_sign_up_cubit.dart';
import 'package:wmd/features/authentication/login_signup/domain/use_cases/post_login_usecase.dart';
import 'package:wmd/features/authentication/verify_email/data/data_sources/verify_email_server_datasource.dart';
import 'package:wmd/features/authentication/verify_email/data/repositories/verify_email_repository_impl.dart';
import 'package:wmd/features/authentication/verify_email/domain/repositories/verify_email_repository.dart';
import 'package:wmd/features/authentication/verify_email/domain/use_cases/verify_email_usecase.dart';
import 'package:wmd/features/authentication/verify_email/presentation/manager/verify_email_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/data_sources/dashboard_charts_remote_datasource.dart';
import 'package:wmd/features/dashboard/dashboard_charts/data/repositories/dashboard_charts_repository_impl.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/repositories/dashboard_charts_repository.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/use_cases/get_allocation_usecase.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/use_cases/get_geographic_usecase.dart';
import 'package:wmd/features/dashboard/dashboard_charts/domain/use_cases/get_pie_usecase.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_charts_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/data_sources/main_dashboard_remote_data_source.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/repositories/main_dashboard_respository_impl.dart';
import 'package:wmd/features/dashboard/main_dashbaord/domain/repositories/main_dashboard_repository.dart';
import 'package:wmd/features/dashboard/main_dashbaord/domain/use_cases/user_net_worth_usecase.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/dashboard/user_status/data/data_sources/user_status_remote_data_source.dart';
import 'package:wmd/features/dashboard/user_status/data/repositories/user_status_respository_impl.dart';
import 'package:wmd/features/dashboard/user_status/domain/repositories/user_status_repository.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/get_user_status_usecase.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/put_user_status_usecase.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/features/help/faq/data/data_sources/faq_remote_data_source.dart';
import 'package:wmd/features/help/faq/data/repositories/faq_respository_impl.dart';
import 'package:wmd/features/help/faq/domain/repositories/faq_repository.dart';
import 'package:wmd/features/help/faq/domain/use_cases/get_faq_usecase.dart';
import 'package:wmd/features/help/faq/presentation/manager/faq_cubit.dart';
import 'package:wmd/features/main_page/presentation/manager/main_page_cubit.dart';
import 'package:wmd/features/profile/personal_information/data/data_sources/personal_information_remote_datasource.dart';
import 'package:wmd/features/profile/personal_information/data/repositories/personal_information_repository_impl.dart';
import 'package:wmd/features/profile/personal_information/domain/repositories/personal_information_repository.dart';
import 'package:wmd/features/profile/personal_information/domain/use_cases/get_name_usecase.dart';
import 'package:wmd/features/profile/personal_information/domain/use_cases/set_name_usecase.dart';
import 'package:wmd/features/profile/personal_information/domain/use_cases/set_number_usecase.dart';
import 'package:wmd/features/profile/personal_information/presentation/manager/personal_information_cubit.dart';
import 'core/data/network/network_helper.dart';
import 'core/data/network/server_request_manager.dart';
import 'core/util/app_localization.dart';
import 'core/util/app_theme.dart';
import 'core/util/device_info.dart';
import 'core/util/local_storage.dart';
import 'features/add_assets/add_bank_auto/plaid_integration/presentation/manager/plaid_cubit.dart';
import 'features/add_assets/add_bank_auto/view_bank_list/domain/repository/bank_list_repository.dart';
import 'features/add_assets/add_bank_auto/view_bank_list/domain/usecase/get_popular_bank_list.dart';
import 'features/add_assets/custodian_bank_auth/domain/use_cases/get_custodian_bank_status_usecase.dart';
import 'features/add_assets/custodian_bank_auth/domain/use_cases/get_custodian_status_list_usecase.dart';
import 'features/add_assets/custodian_bank_auth/domain/use_cases/post_custodian_bank_status_usecase.dart';
import 'features/add_assets/custodian_bank_auth/presentation/manager/custodian_bank_list_cubit.dart';
import 'features/asset_detail/valuation/data/data_sources/valuation_remote_datasource.dart';
import 'features/asset_detail/valuation/data/repositories/valuation_repository_impl.dart';
import 'features/asset_detail/valuation/domain/repositories/valuation_repository.dart';
import 'features/asset_detail/valuation/domain/use_cases/get_all_valuation_usecase.dart';
import 'features/asset_detail/valuation/domain/use_cases/get_valuation_performance_usecase.dart';
import 'features/asset_detail/valuation/domain/use_cases/post_valuation_usecase.dart';
import 'features/asset_detail/valuation/presentation/manager/valuation_cubit.dart';
import 'features/splash/data/repositories/splash_repository_impl.dart';
import 'features/splash/domain/repositories/splash_repository.dart';
import 'features/splash/domain/use_cases/check_login_usecase.dart';
import 'features/splash/presentation/manager/splash_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //repository_and_cubits
  // Splash dependency
  sl.registerFactory(() => SplashCubit(sl()));
  sl.registerLazySingleton(() => CheckLoginUseCase(sl()));
  sl.registerLazySingleton<SplashRepository>(() => SplashRepositoryImpl(sl()));

  //Authentication dependency
  // login and sign up
  sl.registerFactory(() => LoginSignUpCubit(sl(), sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => PostLoginUseCase(sl()));
  sl.registerLazySingleton(() => PostRegisterUseCase(sl()));
  sl.registerLazySingleton(() => ResendEmailUseCase(sl()));

  sl.registerLazySingleton<LoginSignUpRepository>(
      () => LoginSignUpRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<LoginSignUpRemoteDataSource>(
      () => LoginSignUpRemoteDataSourceImpl(sl()));

  // verifyEmail
  sl.registerFactory(() => VerifyEmailCubit(sl()));
  sl.registerLazySingleton(() => VerifyEmailUseCase(sl()));
  sl.registerLazySingleton<VerifyEmailRepository>(
      () => VerifyEmailRepositoryImpl(sl()));
  sl.registerLazySingleton<VerifyEmailServerDataSource>(
      () => VerifyEmailServerDataSourceImpl(sl()));

  // verifyEmail
  sl.registerFactory(() => ForgetPasswordCubit(sl(), sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton<ForgetPasswordRepository>(
      () => ForgetPasswordRepositoryImpl(sl()));
  sl.registerLazySingleton<ForgetPasswordServerDataSource>(
      () => ForgetPasswordServerDataSourceImpl(sl()));

  //PersonalInformation
  sl.registerFactory(() => PersonalInformationCubit(sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetNameUseCase(sl()));
  sl.registerLazySingleton(() => SetNameUseCase(sl()));
  sl.registerLazySingleton(() => SetNumberUseCase(sl()));

  sl.registerLazySingleton<PersonalInformationRepository>(
      () => PersonalInformationRepositoryImpl(sl()));
  sl.registerLazySingleton<PersonalInformationRemoteDataSource>(
      () => PersonalInformationRemoteDataSourceImpl(sl()));

  //main_page
  sl.registerFactory(() => MainPageCubit());

  //MainDashboard
  sl.registerFactory(() => MainDashboardCubit(sl()));
  sl.registerLazySingleton(() => UserNetWorthUseCase(sl()));
  sl.registerLazySingleton<MainDashboardRepository>(
      () => MainDashboardRepositoryImpl(sl()));
  sl.registerLazySingleton<MainDashboardRemoteDataSource>(
      () => MainDashboardRemoteDataSourceImpl(sl()));

  //DashboardCharts
  sl.registerFactory(() => DashboardChartsCubit(sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetAllocationUseCase(sl(), sl()));
  sl.registerLazySingleton(() => GetGeographicUseCase(sl(), sl()));
  sl.registerLazySingleton(() => GetPieUseCase(sl(), sl()));

  sl.registerLazySingleton<DashboardChartsRepository>(
      () => DashboardChartsRepositoryImpl(sl()));
  sl.registerLazySingleton<DashboardChartsRemoteDataSource>(
      () => DashboardChartsRemoteDataSourceImpl(sl()));

  //AssetOverview
  sl.registerFactory(() => AssetsOverviewCubit(sl()));
  sl.registerLazySingleton(() => GetAssetsOverviewUseCase(sl()));
  sl.registerLazySingleton<AssetsOverviewRepository>(
      () => AssetsOverviewRepositoryImpl(sl()));
  sl.registerLazySingleton<AssetsOverviewRemoteDataSource>(
      () => AssetsOverviewRemoteDataSourceImpl(sl()));

  //Charts
  sl.registerFactory(() => ChartsCubit(sl()));
  sl.registerLazySingleton(() => GetChartUseCase(sl(),sl()));

  sl.registerLazySingleton<ChartsRepository>(
          () => ChartsRepositoryImpl(sl()));
  sl.registerLazySingleton<ChartsRemoteDataSource>(
          () => ChartsRemoteDataSourceImpl(sl()));

  // Dashboard - user status dependencies
  sl.registerFactory(() => UserStatusCubit(sl(), sl()));
  sl.registerLazySingleton(() => GetUserStatusUseCase(sl()));
  sl.registerLazySingleton(() => PutUserStatusUseCase(sl()));
  sl.registerLazySingleton<UserStatusRepository>(
      () => UserStatusRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<UserStatusRemoteDataSource>(
      () => UserStatusRemoteDataSourceImpl(sl()));
  //local_storage
  sl.registerLazySingleton<LocalStorage>(() => LocalStorage(sl()));
  sl.registerLazySingleton<ServerRequestManager>(
      () => ServerRequestManager(sl()));
  sl.registerLazySingleton<ErrorHandlerMiddleware>(
      () => ErrorHandlerMiddleware(sl()));
  //device_info
  sl.registerLazySingleton<AppDeviceInfo>(() => AppDeviceInfo(sl()));
  //theme_manager
  sl.registerFactory(() => ThemeManager(sl()));
  //localization_manager
  sl.registerFactory(() => LocalizationManager(sl()));

  // Add base cash asset
  sl.registerFactory(() => BankCubit(sl()));
  sl.registerLazySingleton(() => PostBankDetailsUseCase(sl(), sl()));
  sl.registerLazySingleton<BankRepository>(() => BankRepositoryImpl(sl()));
  sl.registerLazySingleton<BankSaveRemoteDataSource>(
      () => BankSaveRemoteDataSourceImpl(sl()));

  // Bank List
  sl.registerFactory(() => BankListCubit(sl(), sl()));
  sl.registerLazySingleton(() => GetBankListsUseCase(sl()));
  sl.registerLazySingleton(() => GetPopularBankListUseCase(sl()));
  sl.registerLazySingleton<BankListRepository>(
      () => BankListRepositoryImpl(sl()));
  sl.registerLazySingleton<BankListRemoteDataSource>(
      () => BankListRemoteDataSourceImpl(sl()));

  // Plaid integration
  sl.registerFactory(() => PlaidCubit(sl()));
  sl.registerLazySingleton(() => PlaidUseCase(sl()));
  sl.registerLazySingleton<PlaidRepository>(() => PlaidRepositoryImpl(sl()));
  sl.registerLazySingleton<PlaidRemoteDataSource>(
      () => PlaidRemoteDataSourceImpl(sl()));

  // Add base private debt
  sl.registerFactory(() => PrivateDebtCubit(sl()));
  sl.registerLazySingleton(() => AddPrivateDebtUseCase(sl(), sl()));
  sl.registerLazySingleton<PrivateDebtRepository>(
      () => PrivateDebtRepositoryImpl(sl()));
  sl.registerLazySingleton<PrivateDebtSaveRemoteDataSource>(
      () => PrivateDebtSaveRemoteDataSourceImpl(sl()));

  // Add private equity
  sl.registerFactory(() => PrivateEquityCubit(sl()));
  sl.registerLazySingleton(() => AddPrivateEquityUseCase(sl(), sl()));
  sl.registerLazySingleton<PrivateEquityRepository>(
      () => PrivateEquityRepositoryImpl(sl()));
  sl.registerLazySingleton<PrivateEquityRemoteDataSource>(
      () => PrivateEquityRemoteDataSourceImpl(sl()));

  // Add real estate
  sl.registerFactory(() => RealEstateCubit(sl()));
  sl.registerLazySingleton(() => AddRealEstateUseCase(sl()));
  sl.registerLazySingleton<RealEstateRepository>(
      () => RealEstateRepositoryImpl(sl()));
  sl.registerLazySingleton<RealEstateRemoteDataSource>(
      () => RealEstateRemoteDataSourceImpl(sl()));

  // Add other asset
  sl.registerFactory(() => OtherAssetCubit(sl()));
  sl.registerLazySingleton(() => AddOtherAssetUseCase(sl()));
  sl.registerLazySingleton<OtherAssetRepository>(
      () => OtherAssetRepositoryImpl(sl()));
  sl.registerLazySingleton<OtherAssetRemoteDataSource>(
      () => OtherAssetRemoteDataSourceImpl(sl()));

  // Add listed security
  sl.registerFactory(() => ListedSecurityCubit(sl()));
  sl.registerLazySingleton(() => AddListedSecurityUseCase(sl()));
  sl.registerLazySingleton<ListedSecurityRepository>(
      () => ListedSecurityRepositoryImpl(sl()));
  sl.registerLazySingleton<ListedSecurityRemoteDataSource>(
      () => ListedSecurityRemoteDataSourceImpl(sl()));

  // Add loan liability
  sl.registerFactory(() => LoanLiabilityCubit(sl()));
  sl.registerLazySingleton(() => AddLoanLiabilityUseCase(sl()));
  sl.registerLazySingleton<LoanLiabilityRepository>(
      () => LoanLiabilityRepositoryImpl(sl()));
  sl.registerLazySingleton<LoanLiabilityRemoteDataSource>(
      () => LoanLiabilityRemoteDataSourceImpl(sl()));

  //AssetDetail
  sl.registerFactory(() => AssetDetailCubit(sl()));
  sl.registerLazySingleton(() => GetDetailUseCase(sl()));
  sl.registerLazySingleton<AssetDetailRepository>(
      () => AssetDetailRepositoryImpl(sl()));
  sl.registerLazySingleton<AssetDetailRemoteDataSource>(
      () => AssetDetailRemoteDataSourceImpl(sl()));

//CustodianBankAuth
  sl.registerFactory(() => CustodianStatusListCubit(sl()));
  sl.registerFactory(() => CustodianBankListCubit(sl()));
  sl.registerFactory(() => CustodianBankAuthCubit(sl(), sl()));
  sl.registerLazySingleton(() => GetCustodianStatusListUseCase(sl()));
  sl.registerLazySingleton(() => GetCustodianBankListUseCase(sl()));
  sl.registerLazySingleton(() => PostCustodianBankStatusUseCase(sl()));
  sl.registerLazySingleton(() => GetCustodianBankStatusUseCase(sl()));
  sl.registerLazySingleton<CustodianBankAuthRepository>(
      () => CustodianBankAuthRepositoryImpl(sl()));
  sl.registerLazySingleton<CustodianBankAuthRemoteDataSource>(
      () => CustodianBankAuthRemoteDataSourceImpl(sl()));

  //help FAQ
  sl.registerFactory(() => FaqCubit(sl()));
  sl.registerLazySingleton(() => GetFaqUseCase(sl()));
  sl.registerLazySingleton<FaqRepository>(() => FaqRepositoryImpl(sl()));
  sl.registerLazySingleton<FaqRemoteDataSource>(
      () => FaqRemoteDataSourceImpl(sl()));

  //Valuation
  sl.registerFactory(() => ValuationCubit(sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetAllValuationUseCase(sl()));
  sl.registerLazySingleton(() => PostValuationUseCase(sl()));
  sl.registerLazySingleton(() => GetValuationPerformanceUseCase(sl()));
  sl.registerLazySingleton<ValuationRepository>(
      () => ValuationRepositoryImpl(sl()));
  sl.registerLazySingleton<ValuationRemoteDataSource>(
      () => ValuationRemoteDataSourceImpl(sl()));

  await initExternal();
}

Future<void> initExternal() async {
  sl.registerFactory<Dio>(() => NetworkHelper(sl()).getDio());

  sl.registerLazySingleton<DeviceInfoPlugin>(() => DeviceInfoPlugin());

  final Box authBox = await Hive.openBox("auth");
  sl.registerLazySingleton<Box>(() => authBox);
}
