class Constant {
 static const String baseUrl = 'https://locust-eminent-urchin.ngrok-free.app/';

 /// GET
 static const String apiHealth='/api/health/';
 static const String userInfoEndPoint = '/api/me/';
 static const String allProductsEndPoint = '/api/product/allProducts/';
 static const String bestSellersEndPoint = '/api/products/best-sellers/';
 static const String seeOurProductsEndPoint = '/api/products/see-our-products/';
 static const String productDetailsEndPoint='/api/product/';
 static const String allCategoriesEndPoint = '/api/categories/';
 static const String allProductsOfCategoriesEndPoint = '/api/productsByGroup_id/';
 static const String searchEndPoint = '/api/products/search/';
 ///Customer
 static const String customerOrdersEndPoint = '/api/customer/orders/';
 ///Admin
 static const String adminOrdersEndPoint = '/api/admin/orders/';
 static const String adminChangeOrderStatusEndPoint = '/api/admin/orders/status/';
 static const String adminDashboardEndPoint = '/api/admin/dashboard/';
 static const String adminUsersEndPoint = '/api/admin/users/';
 static const String adminUserDetailEndPoint = '/api/admin/users/';
 ///POST
 static const String register = '/api/register/';
 static const String login = '/api/login/';
 static const String createOrder = '/api/create-order/';
 static const String fcmToken = '/api/device/fcm-token/';
}

