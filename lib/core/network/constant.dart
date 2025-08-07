class Constant {
 static const String baseUrl = 'https://locust-eminent-urchin.ngrok-free.app/';
 // static const String baseUrl = 'localhost:3000';

 /// GET
 static const String allProductsEndPoint = '/api/products/';
 static const String productDetailsEndPoint='api/products/';
 static const String searchEndPoint = '/api/products/search/';
 static const String allCategoriesEndPoint = '/api/categories/';
 static const String allProductsOfCategoriesEndPoint = '/api/products/group/';
 static const String allProductsOfCompanyEndPoint = '/api/products/company/';
 static const String bestSellersEndPoint = '/api/products/best-sellers/';
 static const String seeOurProductsEndPoint = '/api/products/see-our-products/';
 ///Customer
 static const String apiHealth='/api/health/';
 static const String userInfoEndPoint = '/api/customer/me/';
 static const String customerOrdersEndPoint = '/api/customer/orders/';
 static const String customerCreateOrdersEndPoint = '/api/customer/orders/';
 static const String fcmToken = '/api/customer/device-token/';
 ///Admin
 static const String adminOrdersEndPoint = '/api/admin/orders/';
 static const String adminChangeOrderStatusEndPoint = '/api/admin/orders/{id}/status/';
 static const String adminDashboardEndPoint = '/api/admin/dashboard/';
 static const String adminUsersEndPoint = '/api/admin/users/';
 static const String adminUsersSearchEndPoint = '/api/admin/users/search/';
 static const String adminUserDetailEndPoint = '/api/admin/users/';
 static const String branchesEndPoint = '/api/branches/';
 ///Auth
 static const String register = '/api/auth/register/';
 static const String login = '/api/auth/login/';
 static const String verifyOtp = '/api/auth/verify-otp/';
 static const String resendOtp = '/api/auth/resend-otp/';
 static const String requestPasswordReset = '/api/auth/request-password-reset/';
 static const String passwordReset = '/api/auth/reset-password/';



}

