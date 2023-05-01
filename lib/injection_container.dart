import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wmd/core/data/network/error_handler_middleware.dart';
import 'package:wmd/core/util/local_auth_manager.dart';
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
import 'package:wmd/features/add_assets/add_listed_security/domain/use_cases/get_listed_security_usecase.dart';
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
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/use_cases/delete_custodian_bank_status_usecase.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/domain/use_cases/get_custodian_bank_list_usecase.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_bank_auth_cubit.dart';
import 'package:wmd/features/add_assets/custodian_bank_auth/presentation/manager/custodian_status_list_cubit.dart';
import 'package:wmd/features/add_assets/view_assets_list/presentation/manager/asset_view_cubit.dart';
import 'package:wmd/features/asset_detail/core/data/repositories/asset_summary_repository_impl.dart';
import 'package:wmd/features/asset_detail/core/presentation/manager/asset_summary_cubit.dart';
import 'package:wmd/features/asset_see_more/core/domain/repositories/asset_see_more_repository.dart';
import 'package:wmd/features/asset_see_more/core/presentation/manager/asset_see_more_cubit.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/data/data_sources/assets_geography_chart_remote_datasource.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/data/repositories/assets_geography_chart_repository_impl.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/domain/repositories/assets_geography_chart_repository.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/domain/use_cases/get_assets_geography_usecase.dart';
import 'package:wmd/features/assets_overview/assets_geography_chart/presentation/manager/assets_geography_chart_cubit.dart';
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
import 'package:wmd/features/assets_overview/charts/presentation/manager/chart_chooser_manager.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/charts_cubit.dart';
import 'package:wmd/features/assets_overview/charts/presentation/manager/tab_manager.dart';
import 'package:wmd/features/assets_overview/currency_chart/data/data_sources/currency_chart_remote_datasource.dart';
import 'package:wmd/features/assets_overview/currency_chart/data/repositories/currency_chart_repository_impl.dart';
import 'package:wmd/features/assets_overview/currency_chart/domain/repositories/currency_chart_repository.dart';
import 'package:wmd/features/assets_overview/currency_chart/domain/use_cases/get_currency_usecase.dart';
import 'package:wmd/features/assets_overview/currency_chart/presentation/manager/currency_chart_cubit.dart';
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
import 'package:wmd/features/authentication/logout/data/data_sources/logout_remote_datasource.dart';
import 'package:wmd/features/authentication/logout/data/repositories/logout_repository_impl.dart';
import 'package:wmd/features/authentication/logout/domain/repositories/logout_repository.dart';
import 'package:wmd/features/authentication/logout/domain/use_cases/perform_logout_usecase.dart';
import 'package:wmd/features/authentication/logout/presentation/manager/logout_cubit.dart';
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
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_allocation_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_goe_cubit.dart';
import 'package:wmd/features/dashboard/dashboard_charts/presentation/manager/dashboard_pie_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/data_sources/main_dashboard_remote_data_source.dart';
import 'package:wmd/features/dashboard/main_dashbaord/data/repositories/main_dashboard_respository_impl.dart';
import 'package:wmd/features/dashboard/main_dashbaord/domain/repositories/main_dashboard_repository.dart';
import 'package:wmd/features/dashboard/main_dashbaord/domain/use_cases/user_net_worth_usecase.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/charts_height_cubit.dart';
import 'package:wmd/features/dashboard/main_dashbaord/presentation/manager/main_dashboard_cubit.dart';
import 'package:wmd/features/dashboard/performance_table/data/data_sources/performance_table_remote_datasource.dart';
import 'package:wmd/features/dashboard/performance_table/data/repositories/performance_table_repository_impl.dart';
import 'package:wmd/features/dashboard/performance_table/domain/repositories/performance_table_repository.dart';
import 'package:wmd/features/dashboard/performance_table/domain/use_cases/get_asset_class_usecase.dart';
import 'package:wmd/features/dashboard/performance_table/domain/use_cases/get_benchmark_usecase.dart';
import 'package:wmd/features/dashboard/performance_table/domain/use_cases/get_custodian_performance_usecase.dart';
import 'package:wmd/features/dashboard/performance_table/presentation/manager/performance_table_cubit.dart';
import 'package:wmd/features/dashboard/user_status/data/data_sources/user_status_remote_data_source.dart';
import 'package:wmd/features/dashboard/user_status/data/repositories/user_status_respository_impl.dart';
import 'package:wmd/features/dashboard/user_status/domain/repositories/user_status_repository.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/get_user_status_usecase.dart';
import 'package:wmd/features/dashboard/user_status/domain/use_cases/put_user_status_usecase.dart';
import 'package:wmd/features/dashboard/user_status/presentation/manager/user_status_cubit.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/data/data_sources/edit_bank_manual_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/data/repositories/edit_bank_manual_repository_impl.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/domain/repositories/edit_bank_manual_repository.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/domain/use_cases/delete_bank_manual_usecase.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/domain/use_cases/put_bank_manual_usecase.dart';
import 'package:wmd/features/edit_assets/edit_bank_manual/presentation/manager/edit_bank_manual_cubit.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/data/data_sources/edit_listed_asset_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/data/repositories/edit_listed_asset_repository_impl.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/domain/repositories/edit_listed_asset_repository.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/domain/use_cases/delete_listed_asset_usecase.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/domain/use_cases/put_listed_asset_usecase.dart';
import 'package:wmd/features/edit_assets/edit_listed_asset/presentation/manager/edit_listed_asset_cubit.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/data/data_sources/edit_other_assets_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/data/repositories/edit_other_assets_repository_impl.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/domain/repositories/edit_other_assets_repository.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/domain/use_cases/delete_other_assets_usecase.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/domain/use_cases/put_other_assets_usecase.dart';
import 'package:wmd/features/edit_assets/edit_other_assets/presentation/manager/edit_other_assets_cubit.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/data/data_sources/edit_private_debt_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/data/repositories/edit_private_debt_repository_impl.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/domain/repositories/edit_private_debt_repository.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/domain/use_cases/delete_private_debt_usecase.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/domain/use_cases/put_private_debt_usecase.dart';
import 'package:wmd/features/edit_assets/edit_private_debt/presentation/manager/edit_private_debt_cubit.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/data/data_sources/edit_private_equity_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/data/repositories/edit_private_equity_repository_impl.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/domain/repositories/edit_private_equity_repository.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/domain/use_cases/delete_private_equity_usecase.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/domain/use_cases/put_private_equity_usecase.dart';
import 'package:wmd/features/edit_assets/edit_private_equity/presentation/manager/edit_private_equity_cubit.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/data/data_sources/edit_real_estate_remote_datasource.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/data/repositories/edit_real_estate_repository_impl.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/domain/repositories/edit_real_estate_repository.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/domain/use_cases/delete_real_estate_usecase.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/domain/use_cases/put_real_estate_usecase.dart';
import 'package:wmd/features/edit_assets/edit_real_estate/presentation/manager/edit_real_estate_cubit.dart';
import 'package:wmd/features/force_update/data/data_sources/force_update_remote_datasource.dart';
import 'package:wmd/features/force_update/data/repositories/force_update_repository_impl.dart';
import 'package:wmd/features/force_update/domain/repositories/force_update_repository.dart';
import 'package:wmd/features/force_update/domain/use_cases/get_force_update_usecase.dart';
import 'package:wmd/features/force_update/presentation/manager/force_update_cubit.dart';
import 'package:wmd/features/glossary/data/data_sources/glossary_remote_datasource.dart';
import 'package:wmd/features/glossary/data/repositories/glossary_repository_impl.dart';
import 'package:wmd/features/glossary/domain/repositories/glossary_repository.dart';
import 'package:wmd/features/glossary/domain/use_cases/get_glossaries_usecase.dart';
import 'package:wmd/features/glossary/presentation/manager/glossary_cubit.dart';
import 'package:wmd/features/help/faq/data/data_sources/faq_remote_data_source.dart';
import 'package:wmd/features/help/faq/data/repositories/faq_respository_impl.dart';
import 'package:wmd/features/help/faq/domain/repositories/faq_repository.dart';
import 'package:wmd/features/help/faq/domain/use_cases/get_faq_usecase.dart';
import 'package:wmd/features/help/faq/presentation/manager/faq_cubit.dart';
import 'package:wmd/features/help/support/data/data_sources/general_inquiry_remote_data_source.dart';
import 'package:wmd/features/help/support/data/data_sources/schedule_call_remote_data_source.dart';
import 'package:wmd/features/help/support/data/repositories/general_inquiry_respository_impl.dart';
import 'package:wmd/features/help/support/data/repositories/schedule_call_repository_impl.dart';
import 'package:wmd/features/help/support/domain/repositories/general_inquiry_repository.dart';
import 'package:wmd/features/help/support/domain/repositories/schedule_call_repository.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_general_inquiry_usecase.dart';
import 'package:wmd/features/help/support/domain/use_cases/post_schedule_call_usecase.dart';
import 'package:wmd/features/help/support/presentation/manager/general_inquiry_cubit.dart';
import 'package:wmd/features/main_page/presentation/manager/main_page_cubit.dart';
import 'package:wmd/features/profile/personal_information/data/data_sources/personal_information_remote_datasource.dart';
import 'package:wmd/features/profile/personal_information/data/repositories/personal_information_repository_impl.dart';
import 'package:wmd/features/profile/personal_information/domain/repositories/personal_information_repository.dart';
import 'package:wmd/features/profile/personal_information/domain/use_cases/get_name_usecase.dart';
import 'package:wmd/features/profile/personal_information/domain/use_cases/set_name_usecase.dart';
import 'package:wmd/features/profile/personal_information/domain/use_cases/set_number_usecase.dart';
import 'package:wmd/features/profile/personal_information/presentation/manager/personal_information_cubit.dart';
import 'package:wmd/features/profile/profile_reset_password/data/data_sources/profile_reset_password_remote_datasource.dart';
import 'package:wmd/features/profile/profile_reset_password/data/repositories/profile_reset_password_repository_impl.dart';
import 'package:wmd/features/profile/profile_reset_password/domain/repositories/profile_reset_password_repository.dart';
import 'package:wmd/features/profile/profile_reset_password/domain/use_cases/reset_usecase.dart';
import 'package:wmd/features/profile/profile_reset_password/presentation/manager/profile_reset_password_cubit.dart';
import 'package:wmd/features/profile/two_factor_auth/manager/two_factor_cubit.dart';
import 'package:wmd/features/profile/verify_phone/data/data_sources/verify_phone_remote_datasource.dart';
import 'package:wmd/features/profile/verify_phone/data/repositories/verify_phone_repository_impl.dart';
import 'package:wmd/features/profile/verify_phone/domain/repositories/verify_phone_repository.dart';
import 'package:wmd/features/profile/verify_phone/domain/use_cases/get_send_otp_usecase.dart';
import 'package:wmd/features/profile/verify_phone/domain/use_cases/post_mobile_verification_usecase.dart';
import 'package:wmd/features/profile/verify_phone/domain/use_cases/post_resend_verify_phone_usecase.dart';
import 'package:wmd/features/profile/verify_phone/domain/use_cases/post_verify_phone_usecase.dart';
import 'package:wmd/features/profile/verify_phone/presentation/manager/verify_phone_cubit.dart';
import 'package:wmd/features/settings/core/data/data_sources/settings_remote_datasource.dart';
import 'package:wmd/features/valuation/data/data_sources/valuation_remote_datasource.dart';
import 'package:wmd/features/valuation/data/repositories/valuation_repository_impl.dart';
import 'package:wmd/features/valuation/domain/repositories/valuation_repository.dart';
import 'package:wmd/features/valuation/domain/use_cases/delete_valuation_usecase.dart';
import 'package:wmd/features/valuation/domain/use_cases/get_valudation_usecase.dart';
import 'package:wmd/features/valuation/domain/use_cases/post_valuation_usecase.dart';
import 'package:wmd/features/valuation/domain/use_cases/update_valuation_usecase.dart';
import 'package:wmd/features/valuation/presentation/manager/valuation_cubit.dart';
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
import 'features/add_assets/custodian_bank_auth/domain/use_cases/put_custodian_bank_status_usecase.dart';
import 'features/add_assets/custodian_bank_auth/presentation/manager/custodian_bank_list_cubit.dart';
import 'features/add_assets/tfo_login/data/data_sources/tfo_login_remote_datasource.dart';
import 'features/add_assets/tfo_login/data/repositories/tfo_login_repository_impl.dart';
import 'features/add_assets/tfo_login/domain/repositories/tfo_login_repository.dart';
import 'features/add_assets/tfo_login/domain/use_cases/get_mandates_usecase.dart';
import 'features/add_assets/tfo_login/domain/use_cases/login_tfo_account_usecase.dart';
import 'features/add_assets/tfo_login/presentation/manager/tfo_login_cubit.dart';
import 'features/asset_detail/core/data/data_sources/asset_summary_datasource.dart';
import 'features/asset_detail/core/domain/repositories/asset_summary_repository.dart';
import 'features/asset_detail/core/domain/use_cases/get_summary_usecase.dart';
import 'features/asset_detail/valuation/data/data_sources/valuation_remote_datasource.dart';
import 'features/asset_detail/valuation/data/repositories/valuation_repository_impl.dart';
import 'features/asset_detail/valuation/domain/repositories/valuation_repository.dart';
import 'features/asset_detail/valuation/domain/use_cases/get_all_valuation_usecase.dart';
import 'features/asset_detail/valuation/domain/use_cases/get_valuation_performance_usecase.dart';
import 'features/asset_detail/valuation/domain/use_cases/post_valuation_usecase.dart';
import 'features/asset_detail/valuation/presentation/manager/performance_chart_cubit.dart';
import 'features/asset_detail/valuation/presentation/manager/valuation_cubit.dart';
import 'features/asset_see_more/core/data/data_sources/asset_see_more_remote_datasource.dart';
import 'features/asset_see_more/core/data/repositories/asset_see_more_repository_impl.dart';
import 'features/asset_see_more/core/domain/use_cases/get_asset_see_more_usecase.dart';

import 'features/blurred_widget/data/repositories/blurred_privacy_repository_impl.dart';
import 'features/blurred_widget/domain/repositories/blurred_privacy_repository.dart';
import 'features/blurred_widget/domain/use_cases/get_is_blurred_usecase.dart';
import 'features/blurred_widget/domain/use_cases/set_blurred_usecase.dart';
import 'features/blurred_widget/presentation/manager/blurred_privacy_cubit.dart';
import 'features/settings/core/data/repositories/settings_repository_impl.dart';
import 'features/settings/core/domain/repositories/settings_repository.dart';
import 'features/settings/core/domain/use_cases/get_settings_usecase.dart';
import 'features/settings/core/domain/use_cases/put_settings_usecase.dart';
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

  //Logout
  sl.registerFactory(() => LogoutCubit(sl()));
  sl.registerLazySingleton(() => PerformLogoutUseCase(sl()));

  sl.registerLazySingleton<LogoutRepository>(
          () => LogoutRepositoryImpl(sl()));
  sl.registerLazySingleton<LogoutRemoteDataSource>(
          () => LogoutRemoteDataSourceImpl(sl()));

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

  // asset list
  sl.registerFactory(() => AssetViewCubit());

  //MainDashboard
  sl.registerFactory(() => MainDashboardCubit(sl()));
  sl.registerFactory(() => SummeryWidgetCubit(sl()));
  sl.registerLazySingleton(() => UserNetWorthUseCase(sl()));
  sl.registerLazySingleton<MainDashboardRepository>(
      () => MainDashboardRepositoryImpl(sl()));
  sl.registerLazySingleton<MainDashboardRemoteDataSource>(
      () => MainDashboardRemoteDataSourceImpl(sl()));

  //DashboardCharts
  sl.registerFactory(() => DashboardAllocationCubit(sl(), sl(), sl()));
  sl.registerFactory(() => DashboardPieCubit(sl(), sl(), sl()));
  sl.registerFactory(() => DashboardGoeCubit(sl(), sl(), sl()));
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
  sl.registerLazySingleton(() => GetChartUseCase(sl(), sl()));
  //chart_chooser_manager
  sl.registerFactory(() => AssetChartChooserManager());
  sl.registerFactory(() => GeoChartChooserManager());
  sl.registerFactory(() => TabManager());
  sl.registerFactory(() => TabScrollManager());

  sl.registerLazySingleton<ChartsRepository>(() => ChartsRepositoryImpl(sl()));
  sl.registerLazySingleton<ChartsRemoteDataSource>(
      () => ChartsRemoteDataSourceImpl(sl()));

//CurrencyChart
  sl.registerFactory(() => CurrencyChartCubit(sl()));
  sl.registerLazySingleton(() => GetCurrencyUseCase(sl(), sl()));
  sl.registerLazySingleton<CurrencyChartRepository>(
      () => CurrencyChartRepositoryImpl(sl()));
  sl.registerLazySingleton<CurrencyChartRemoteDataSource>(
      () => CurrencyChartRemoteDataSourceImpl(sl()));

  //AssetsGeographyChart
  sl.registerFactory(() => AssetsGeographyChartCubit(sl()));
  sl.registerLazySingleton(() => GetAssetsGeographyUseCase(sl()));

  sl.registerLazySingleton<AssetsGeographyChartRepository>(
      () => AssetsGeographyChartRepositoryImpl(sl()));
  sl.registerLazySingleton<AssetsGeographyChartRemoteDataSource>(
      () => AssetsGeographyChartRemoteDataSourceImpl(sl()));

  // Dashboard - user status dependencies
  sl.registerFactory(() => UserStatusCubit(sl(), sl()));
  sl.registerLazySingleton(() => GetUserStatusUseCase(sl()));
  sl.registerLazySingleton(() => PutUserStatusUseCase(sl()));
  sl.registerLazySingleton<UserStatusRepository>(
      () => UserStatusRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<UserStatusRemoteDataSource>(
      () => UserStatusRemoteDataSourceImpl(sl()));

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
  sl.registerFactory(() => ListedSecurityCubit(sl(), sl()));
  sl.registerLazySingleton(() => AddListedSecurityUseCase(sl()));
  sl.registerLazySingleton(() => GetListedSecurityUseCase(sl()));
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

  //EditRealEstate
  sl.registerFactory(() => EditRealEstateCubit(sl(), sl()));
  sl.registerLazySingleton(() => PutRealEstateUseCase(sl()));
  sl.registerLazySingleton(() => DeleteRealEstateUseCase(sl()));

  sl.registerLazySingleton<EditRealEstateRepository>(
      () => EditRealEstateRepositoryImpl(sl()));
  sl.registerLazySingleton<EditRealEstateRemoteDataSource>(
      () => EditRealEstateRemoteDataSourceImpl(sl()));

  //EditBankManual
  sl.registerFactory(() => EditBankManualCubit(sl(), sl()));
  sl.registerLazySingleton(() => PutBankManualUseCase(sl(), sl()));
  sl.registerLazySingleton(() => DeleteBankManualUseCase(sl()));

  sl.registerLazySingleton<EditBankManualRepository>(
      () => EditBankManualRepositoryImpl(sl()));
  sl.registerLazySingleton<EditBankManualRemoteDataSource>(
      () => EditBankManualRemoteDataSourceImpl(sl()));

  //EditOtherAssets
  sl.registerFactory(() => EditOtherAssetsCubit(sl(), sl()));
  sl.registerLazySingleton(() => PutOtherAssetsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteOtherAssetsUseCase(sl()));

  sl.registerLazySingleton<EditOtherAssetsRepository>(
      () => EditOtherAssetsRepositoryImpl(sl()));
  sl.registerLazySingleton<EditOtherAssetsRemoteDataSource>(
      () => EditOtherAssetsRemoteDataSourceImpl(sl()));

  //EditPrivateEquity
  sl.registerFactory(() => EditPrivateEquityCubit(sl(), sl()));
  sl.registerLazySingleton(() => PutPrivateEquityUseCase(sl(), sl()));
  sl.registerLazySingleton(() => DeletePrivateEquityUseCase(sl()));

  sl.registerLazySingleton<EditPrivateEquityRepository>(
      () => EditPrivateEquityRepositoryImpl(sl()));
  sl.registerLazySingleton<EditPrivateEquityRemoteDataSource>(
      () => EditPrivateEquityRemoteDataSourceImpl(sl()));

  //EditPrivateDebt
  sl.registerFactory(() => EditPrivateDebtCubit(sl(), sl()));
  sl.registerLazySingleton(() => PutPrivateDebtUseCase(sl(), sl()));
  sl.registerLazySingleton(() => DeletePrivateDebtUseCase(sl()));

  sl.registerLazySingleton<EditPrivateDebtRepository>(
      () => EditPrivateDebtRepositoryImpl(sl()));
  sl.registerLazySingleton<EditPrivateDebtRemoteDataSource>(
      () => EditPrivateDebtRemoteDataSourceImpl(sl()));

  //EditListedAsset
  sl.registerFactory(() => EditListedAssetCubit(sl(), sl()));
  sl.registerLazySingleton(() => PutListedAssetUseCase(sl()));
  sl.registerLazySingleton(() => DeleteListedAssetUseCase(sl()));

  sl.registerLazySingleton<EditListedAssetRepository>(
      () => EditListedAssetRepositoryImpl(sl()));
  sl.registerLazySingleton<EditListedAssetRemoteDataSource>(
      () => EditListedAssetRemoteDataSourceImpl(sl()));

  //AssetDetail
  sl.registerFactory(() => AssetSummaryCubit(sl()));
  sl.registerLazySingleton(() => GetSummaryUseCase(sl()));
  sl.registerLazySingleton<AssetSummaryRepository>(
      () => AssetSummaryRepositoryImpl(sl()));
  sl.registerLazySingleton<AssetSummaryRemoteDataSource>(
      () => AssetSummaryRemoteDataSourceImpl(sl()));

//CustodianBankAuth
  sl.registerFactory(() => CustodianStatusListCubit(sl()));
  sl.registerFactory(() => CustodianBankListCubit(sl()));
  sl.registerFactory(() => CustodianBankAuthCubit(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetCustodianStatusListUseCase(sl()));
  sl.registerLazySingleton(() => GetCustodianBankListUseCase(sl()));
  sl.registerLazySingleton(() => PostCustodianBankStatusUseCase(sl()));
  sl.registerLazySingleton(() => PutCustodianBankStatusUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCustodianBankStatusUseCase(sl()));
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

  //profile phone verify
  sl.registerFactory(() => VerifyPhoneCubit(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => PostVerifyPhoneUseCase(sl()));
  sl.registerLazySingleton(() => PostMobileVerificationUseCase(sl()));
  sl.registerLazySingleton(() => PostResendVerifyPhoneUseCase(sl()));
  sl.registerLazySingleton(() => GetSendOtpUseCase(sl()));
  sl.registerLazySingleton<VerifyPhoneRepository>(
      () => VerifyPhoneRepositoryImpl(sl()));
  sl.registerLazySingleton<VerifyPhoneRemoteDataSource>(
      () => VerifyPhoneRemoteDataSourceImpl(sl()));

  //Valuation
  sl.registerFactory(() => ValuationCubit(sl(), sl()));
  sl.registerFactory(() => PerformanceChartCubit(sl()));
  sl.registerLazySingleton(() => GetAllValuationUseCase(sl()));
  sl.registerLazySingleton(() => PostValuationUseCase(sl()));
  sl.registerLazySingleton(() => GetValuationPerformanceUseCase(sl()));
  sl.registerLazySingleton<ValuationRepository>(
      () => ValuationRepositoryImpl(sl()));
  sl.registerLazySingleton<ValuationRemoteDataSource>(
      () => ValuationRemoteDataSourceImpl(sl()));

  //ProfileResetPassword
  sl.registerFactory(() => ProfileResetPasswordCubit(sl()));
  sl.registerLazySingleton(() => ResetUseCase(sl()));

  sl.registerLazySingleton<ProfileResetPasswordRepository>(
      () => ProfileResetPasswordRepositoryImpl(sl()));
  sl.registerLazySingleton<ProfileResetPasswordRemoteDataSource>(
      () => ProfileResetPasswordRemoteDataSourceImpl(sl()));

  //GeneralInquiryCubit
  sl.registerFactory(() => GeneralInquiryCubit(sl(), sl()));
  sl.registerLazySingleton(() => PostGeneralInquiryUseCase(sl()));
  sl.registerLazySingleton<GeneralInquiryRepository>(
      () => GeneralInquiryRepositoryImpl(sl()));
  sl.registerLazySingleton<GeneralInquiryRemoteDataSource>(
      () => GeneralInquiryRemoteDataSourceImpl(sl()));

  // shedule a call
  sl.registerLazySingleton(() => PostScheduleCallUseCase(sl()));
  sl.registerLazySingleton<ScheduleCallRepository>(
      () => ScheduleCallRepositoryImpl(sl()));
  sl.registerLazySingleton<ScheduleCallRemoteDataSource>(
      () => ScheduleCallRemoteDataSourceImpl(sl()));

  //AssetSeeMore
  sl.registerFactory(() => AssetSeeMoreCubit(sl()));
  sl.registerLazySingleton(() => GetSeeMoreUseCase(sl()));
  sl.registerLazySingleton<AssetSeeMoreRepository>(
      () => AssetSeeMoreRepositoryImpl(sl()));
  sl.registerLazySingleton<AssetSeeMoreRemoteDataSource>(
      () => AssetSeeMoreRemoteDataSourceImpl(sl()));

  //ForceUpdate
  sl.registerFactory(() => ForceUpdateCubit(sl()));
  sl.registerLazySingleton(() => GetForceUpdateUseCase(sl(), sl()));

  sl.registerLazySingleton<ForceUpdateRepository>(
      () => ForceUpdateRepositoryImpl(sl()));
  sl.registerLazySingleton<ForceUpdateRemoteDataSource>(
      () => ForceUpdateRemoteDataSourceImpl(sl()));

  //BlurredPrivacy
  sl.registerFactory(() => BlurredPrivacyCubit(sl(), sl()));
  sl.registerLazySingleton(() => GetIsBlurredUseCase(sl()));
  sl.registerLazySingleton(() => SetBlurredUseCase(sl()));
  sl.registerLazySingleton<BlurredPrivacyRepository>(
      () => BlurredPrivacyRepositoryImpl(sl()));
  // sl.registerLazySingleton<BlurredPrivacyRemoteDataSource>(
  //     () => BlurredPrivacyRemoteDataSourceImpl(sl()));

  //PerformanceTable
  sl.registerFactory(() => PerformanceTableCubit(sl(), sl(), sl()));
  sl.registerFactory(() => PerformanceAssetClassCubit(sl(), sl(), sl()));
  sl.registerFactory(() => PerformanceBenchmarkCubit(sl(), sl(), sl()));
  sl.registerFactory(() => PerformanceCustodianCubit(sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetAssetClassUseCase(sl()));
  sl.registerLazySingleton(() => GetBenchmarkUseCase(sl()));
  sl.registerLazySingleton(() => GetCustodianPerformanceUseCase(sl()));

  sl.registerLazySingleton<PerformanceTableRepository>(
      () => PerformanceTableRepositoryImpl(sl()));
  sl.registerLazySingleton<PerformanceTableRemoteDataSource>(
      () => PerformanceTableRemoteDataSourceImpl(sl()));

  //Glossary
  sl.registerFactory(() => GlossaryCubit(sl()));
  sl.registerLazySingleton(() => GetGlossariesUseCase(sl()));

  sl.registerLazySingleton<GlossaryRepository>(
      () => GlossaryRepositoryImpl(sl()));
  sl.registerLazySingleton<GlossaryRemoteDataSource>(
      () => GlossaryRemoteDataSourceImpl(sl()));

  //Settings
  sl.registerFactory(() => TwoFactorCubit(sl(), sl()));
  sl.registerLazySingleton(() => GetSettingsUseCase(sl()));
  sl.registerLazySingleton(() => PutSettingsUseCase(sl()));

  sl.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(sl()));
  sl.registerLazySingleton<SettingsRemoteDataSource>(
      () => SettingsRemoteDataSourceImpl(sl()));

  //ChartsHeigth
  sl.registerFactory(() => ChartsHeightCubit());

  //Settings
  sl.registerFactory(() => AssetValuationCubit(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => AssetPostValuationUseCase(sl()));
  sl.registerLazySingleton(() => UpdateValuationUseCase(sl()));
  sl.registerLazySingleton(() => AssetDeleteValuationUseCase(sl()));
  sl.registerLazySingleton(() => AssetGetValuationUseCase(sl()));

  sl.registerLazySingleton<AssetValuationRepository>(
      () => AssetValuationRepositoryImpl(sl()));
  sl.registerLazySingleton<AssetValuationRemoteDataSource>(
      () => AssetValuationRemoteDataSourceImpl(sl()));

  //TfoLogin
  sl.registerFactory(() => TfoLoginCubit(sl(), sl()));
  sl.registerLazySingleton(() => GetMandatesUseCase(sl()));
  sl.registerLazySingleton(() => LoginTfoAccountUseCase(sl()));

  sl.registerLazySingleton<TfoLoginRepository>(
      () => TfoLoginRepositoryImpl(sl()));
  sl.registerLazySingleton<TfoLoginRemoteDataSource>(
      () => TfoLoginRemoteDataSourceImpl(sl()));

  await initExternal();
  await initUtils();
}

Future<void> initUtils() async {
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
  //local_auth_manager
  sl.registerFactory(() => LocalAuthManager(sl()));
}

Future<void> initExternal() async {
  sl.registerFactory<Dio>(() => NetworkHelper(sl()).getDio());

  sl.registerLazySingleton<DeviceInfoPlugin>(() => DeviceInfoPlugin());

  final Box authBox = await Hive.openBox("auth");
  sl.registerLazySingleton<Box>(() => authBox);

  sl.registerLazySingleton<LocalAuthentication>(() => LocalAuthentication());

  final packageInfo = await PackageInfo.fromPlatform();
  sl.registerLazySingleton<PackageInfo>(() => packageInfo);
}
