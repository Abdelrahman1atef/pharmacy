class Constant {
 static const String baseUrl = 'https://locust-eminent-urchin.ngrok-free.app/';

 /// GET
 static const String apiHealth='/api/health/';
 static const String userInfoEndPoint = '/api/me/';
 static const String allProductsEndPoint = '/api/product/allProducts/';
 static const String productDetailsEndPoint='/api/product/';
 static const String allCategoriesEndPoint = '/api/categories/';
 static const String allProductsOfCategoriesEndPoint = '/api/productsByGroup_id/';
 static const String searchEndPoint = '/api/products/search/';
 ///Customer
 static const String customerOrdersEndPoint = '/api/customer/orders/';
 ///Admin
 static const String adminOrdersEndPoint = '/api/admin/orders/';
 static const String adminChangeOrderStatusEndPoint = '/api/admin/orders/status/';
 static const String adminUserEndPoint = '/api/admin/orders/';
 ///POST
 static const String register = '/api/register/';
 static const String login = '/api/login/';
 static const String createOrder = '/api/create-order/';
}

