


String loginUrl = "/api/user/login";

String setuSignUp = "/api/user/register";



String haddakayamPost = "/api/user/counting-land/create/counting-land";

String landAcquisitionPost = "/api/user/bhusampadan/create";

String courtCommissionCase = "/api/user/court-land/create";


String courtAllocation = "/api/user/court-vatap/create";

String governmentCensus = "/api/user/shaskiya-mojni/create";


String userProfileDetails(int id) => "/api/user/$id";


String getMyApplication(int id) => "/api/user/$id/forms/summary";

String lifeCycleCountingLand(int id) => "/api/user/payment/$id/landCounting";

String lifeCycleCountingLandChalanSubmission(int id) => "/api/user/payment/$id/measurement-chalan";
String lifeCycleCountingLandConvenienceSubmission(int id) => "/api/user/payment/$id/convenience-chalan";



String getPreviewData(int userId, String formType) {return "/api/user/$userId/forms/type?type=$formType";}

String stateGet = "api/location/states";

