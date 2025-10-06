import 'package:get/get.dart';
import '../Auth/login_view.dart';
import '../Auth/sign_up.dart';
import '../Components/CourtAllocationCaseView/main_view.dart';
import '../Components/CourtCommissionCaseView/main_view.dart';
import '../Components/GovernmentCensusView/main_view.dart';
import '../Components/LandAcquisitionView/main_view.dart';
import '../Components/LandSurveyView/land_survey_view.dart';
import '../Components/join_as_site_lead.dart';
import '../View/Dashboard/GovLink/gov_link.dart';
import '../View/Dashboard/MyApplication/AllPagesLifecycle/bhusampadan_page.dart';
import '../View/Dashboard/MyApplication/AllPagesLifecycle/court_land_page.dart';
import '../View/Dashboard/MyApplication/AllPagesLifecycle/court_vatap_page.dart';
import '../View/Dashboard/MyApplication/AllPagesLifecycle/shaskiya_page.dart';
import '../View/Dashboard/MyApplication/Components/lifecycle_view.dart';
import '../View/Dashboard/MyApplication/my_all_application.dart';
import '../View/Dashboard/MyApplication/AllPagesLifecycle/counting_land.dart';
import '../View/bottum_nevigation_bar.dart';
import 'app_bindings.dart';

class AppRoutes {
  // Route names
  static const login = '/login';
  static const signUp = '/signUpView';

  static const siteLeadApplication = '/siteLeadApplication';
  static const mainDashboard = '/mainDashboard';
  static const newCalculationApplication = '/newCalculationApplication';
  static const landAcquisitionCalculationApplication = '/LandAcquisitionCalculationApplication';
  static const courtCommissionCase = '/CourtCommissionCase';
  static const courtAllocationCase = '/courtAllocationCase';
  static const governmentCensus = '/governmentCensus';


  static const governmentLink = '/mainDashboard/governmentLink';


  static const dashboardMyApplication = '/dashboardMyApplication';

  static const countingLand = '/dashboardMyApplication/countingLand';
  static const bhusampadanPage = '/dashboardMyApplication/bhusampadanPage';
  static const courtLandPage = '/dashboardMyApplication/courtLandPage';
  static const courtVatapPage = '/dashboardMyApplication/courtVatapPage';
  static const shaskiyaPage = '/dashboardMyApplication/shaskiyaPage';


  static const cleaner = '/cleaner/dashboard';
  static const inspector = '/inspector/dashboard';

  static final routes = <GetPage>[
    GetPage(
      name: login,
      page: () => const NewLoginView(),
      binding: AppBindings(),
    ),
    GetPage(
      name: signUp,
      page: () => const SignUpView(),
      binding: AppBindings(),
    ),
    GetPage(
      name: siteLeadApplication,
      page: () => SiteLeadApplication(),
      binding: AppBindings(),
    ),
    GetPage(
      name: mainDashboard,
      page: () => MainNavigationView(),
      binding: AppBindings(),
    ),
    GetPage(
      name: newCalculationApplication,
      page: () => SurveyView(),
      binding: AppBindings(),
    ),
    GetPage(
      name: landAcquisitionCalculationApplication,
      page: () => LandAcquisitionView(),
      binding: AppBindings(),
    ),
    GetPage(
      name: courtCommissionCase,
      page: () => CourtCommissionCaseView(),
      binding: AppBindings(),
    ),
    GetPage(
      name: courtAllocationCase,
      page: () => CourtAllocationCaseView(),
      binding: AppBindings(),
    ),
    GetPage(
      name: governmentCensus,
      page: () => GovernmentCensusView(),
      binding: AppBindings(),
    ),

    GetPage(
      name: dashboardMyApplication,
      page: () => MyAllApplication(),
      binding: AppBindings(),
    ),

    GetPage(
      name: governmentLink,
      page: () => GovLink(),
      binding: AppBindings(),
    ),
    GetPage(
      name: countingLand,
      page: () => CountingLand(),
      binding: AppBindings(),
    ),
    GetPage(
      name: bhusampadanPage,
      page: () => BhusampadanPage(),
      binding: AppBindings(),
    ),
    GetPage(
      name: courtLandPage,
      page: () => CourtLandPage(),
      binding: AppBindings(),
    ),
    GetPage(
      name: courtVatapPage,
      page: () => CourtVatapPage(),
      binding: AppBindings(),
    ),
    GetPage(
      name: shaskiyaPage,
      page: () => ShaskiyaPage(),
      binding: AppBindings(),
    ),
  ];
}
