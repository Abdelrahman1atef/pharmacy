// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardResponse _$DashboardResponseFromJson(Map<String, dynamic> json) =>
    DashboardResponse(
      dashboardResult: DashboardResult.fromJson(
          json['dashboard_result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardResponseToJson(DashboardResponse instance) =>
    <String, dynamic>{
      'dashboard_result': instance.dashboardResult,
    };

DashboardResult _$DashboardResultFromJson(Map<String, dynamic> json) =>
    DashboardResult(
      salesOverview: SalesOverview.fromJson(
          json['sales_overview'] as Map<String, dynamic>),
      orderStatusDistribution: OrderStatusDistribution.fromJson(
          json['order_status_distribution'] as Map<String, dynamic>),
      userStatistics: UserStatistics.fromJson(
          json['user_statistics'] as Map<String, dynamic>),
      productPerformance: ProductPerformance.fromJson(
          json['product_performance'] as Map<String, dynamic>),
      recentActivity: RecentActivity.fromJson(
          json['recent_activity'] as Map<String, dynamic>),
      revenueTrends: RevenueTrends.fromJson(
          json['revenue_trends'] as Map<String, dynamic>),
      paymentMethodDistribution: PaymentMethodDistribution.fromJson(
          json['payment_method_distribution'] as Map<String, dynamic>),
      deliveryMethodDistribution: DeliveryMethodDistribution.fromJson(
          json['delivery_method_distribution'] as Map<String, dynamic>),
      quickStats:
          QuickStats.fromJson(json['quick_stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardResultToJson(DashboardResult instance) =>
    <String, dynamic>{
      'sales_overview': instance.salesOverview,
      'order_status_distribution': instance.orderStatusDistribution,
      'user_statistics': instance.userStatistics,
      'product_performance': instance.productPerformance,
      'recent_activity': instance.recentActivity,
      'revenue_trends': instance.revenueTrends,
      'payment_method_distribution': instance.paymentMethodDistribution,
      'delivery_method_distribution': instance.deliveryMethodDistribution,
      'quick_stats': instance.quickStats,
    };

SalesOverview _$SalesOverviewFromJson(Map<String, dynamic> json) =>
    SalesOverview(
      totalOrders: (json['total_orders'] as num).toInt(),
      totalRevenue: (json['total_revenue'] as num).toDouble(),
      recentOrdersCount: (json['recent_orders_count'] as num).toInt(),
      recentRevenue: (json['recent_revenue'] as num).toDouble(),
      avgOrderValue: (json['avg_order_value'] as num).toDouble(),
    );

Map<String, dynamic> _$SalesOverviewToJson(SalesOverview instance) =>
    <String, dynamic>{
      'total_orders': instance.totalOrders,
      'total_revenue': instance.totalRevenue,
      'recent_orders_count': instance.recentOrdersCount,
      'recent_revenue': instance.recentRevenue,
      'avg_order_value': instance.avgOrderValue,
    };

OrderStatusDistribution _$OrderStatusDistributionFromJson(
        Map<String, dynamic> json) =>
    OrderStatusDistribution(
      pending: (json['pending'] as num).toInt(),
      preparing: (json['preparing'] as num).toInt(),
      shipped: (json['shipped'] as num).toInt(),
      delivered: (json['delivered'] as num).toInt(),
      cancelled: (json['cancelled'] as num).toInt(),
    );

Map<String, dynamic> _$OrderStatusDistributionToJson(
        OrderStatusDistribution instance) =>
    <String, dynamic>{
      'pending': instance.pending,
      'preparing': instance.preparing,
      'shipped': instance.shipped,
      'delivered': instance.delivered,
      'cancelled': instance.cancelled,
    };

UserStatistics _$UserStatisticsFromJson(Map<String, dynamic> json) =>
    UserStatistics(
      totalUsers: (json['total_users'] as num).toInt(),
      activeUsers: (json['active_users'] as num).toInt(),
      newUsersThisMonth: (json['new_users_this_month'] as num).toInt(),
      userGrowthRate: (json['user_growth_rate'] as num).toDouble(),
    );

Map<String, dynamic> _$UserStatisticsToJson(UserStatistics instance) =>
    <String, dynamic>{
      'total_users': instance.totalUsers,
      'active_users': instance.activeUsers,
      'new_users_this_month': instance.newUsersThisMonth,
      'user_growth_rate': instance.userGrowthRate,
    };

ProductPerformance _$ProductPerformanceFromJson(Map<String, dynamic> json) =>
    ProductPerformance(
      topSellingProducts: (json['top_selling_products'] as List<dynamic>)
          .map((e) => TopSellingProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      outOfStockProducts: (json['out_of_stock_products'] as List<dynamic>)
          .map((e) => OutOfStockProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      outOfStockCount: (json['out_of_stock_count'] as num).toInt(),
      outOfStockProductsShown:
          (json['out_of_stock_products_shown'] as num).toInt(),
    );

Map<String, dynamic> _$ProductPerformanceToJson(ProductPerformance instance) =>
    <String, dynamic>{
      'top_selling_products': instance.topSellingProducts,
      'out_of_stock_products': instance.outOfStockProducts,
      'out_of_stock_count': instance.outOfStockCount,
      'out_of_stock_products_shown': instance.outOfStockProductsShown,
    };

TopSellingProduct _$TopSellingProductFromJson(Map<String, dynamic> json) =>
    TopSellingProduct(
      productId: (json['product_id'] as num).toDouble(),
      productNameEn: json['product_name_en'] as String,
      totalSold: (json['total_sold'] as num).toInt(),
    );

Map<String, dynamic> _$TopSellingProductToJson(TopSellingProduct instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product_name_en': instance.productNameEn,
      'total_sold': instance.totalSold,
    };

OutOfStockProduct _$OutOfStockProductFromJson(Map<String, dynamic> json) =>
    OutOfStockProduct(
      productId: (json['product_id'] as num).toDouble(),
      productNameEn: json['product_name_en'] as String,
      productNameAr: json['product_name_ar'] as String,
      totalStock: (json['total_stock'] as num).toDouble(),
    );

Map<String, dynamic> _$OutOfStockProductToJson(OutOfStockProduct instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product_name_en': instance.productNameEn,
      'product_name_ar': instance.productNameAr,
      'total_stock': instance.totalStock,
    };

RecentActivity _$RecentActivityFromJson(Map<String, dynamic> json) =>
    RecentActivity(
      recentOrders: (json['recent_orders'] as List<dynamic>)
          .map((e) => RecentOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecentActivityToJson(RecentActivity instance) =>
    <String, dynamic>{
      'recent_orders': instance.recentOrders,
    };

RecentOrder _$RecentOrderFromJson(Map<String, dynamic> json) => RecentOrder(
      orderId: (json['order_id'] as num).toInt(),
      customerName: json['customer_name'] as String,
      customerEmail: json['customer_email'] as String,
      customerPhone: json['customer_phone'] as String,
      totalAmount: (json['total_amount'] as num).toDouble(),
      status: json['status'] as String,
      createdAt: json['created_at'] as String,
      paymentMethod: json['payment_method'] as String,
      deliveryMethod: json['delivery_method'] as String,
    );

Map<String, dynamic> _$RecentOrderToJson(RecentOrder instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'customer_name': instance.customerName,
      'customer_email': instance.customerEmail,
      'customer_phone': instance.customerPhone,
      'total_amount': instance.totalAmount,
      'status': instance.status,
      'created_at': instance.createdAt,
      'payment_method': instance.paymentMethod,
      'delivery_method': instance.deliveryMethod,
    };

RevenueTrends _$RevenueTrendsFromJson(Map<String, dynamic> json) =>
    RevenueTrends(
      dailyRevenue: (json['daily_revenue'] as List<dynamic>)
          .map((e) => DailyRevenue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RevenueTrendsToJson(RevenueTrends instance) =>
    <String, dynamic>{
      'daily_revenue': instance.dailyRevenue,
    };

DailyRevenue _$DailyRevenueFromJson(Map<String, dynamic> json) => DailyRevenue(
      date: json['date'] as String,
      revenue: (json['revenue'] as num).toDouble(),
      orders: (json['orders'] as num).toInt(),
    );

Map<String, dynamic> _$DailyRevenueToJson(DailyRevenue instance) =>
    <String, dynamic>{
      'date': instance.date,
      'revenue': instance.revenue,
      'orders': instance.orders,
    };

PaymentMethodDistribution _$PaymentMethodDistributionFromJson(
        Map<String, dynamic> json) =>
    PaymentMethodDistribution(
      cashOnDelivery: (json['cash_on_delivery'] as num).toInt(),
    );

Map<String, dynamic> _$PaymentMethodDistributionToJson(
        PaymentMethodDistribution instance) =>
    <String, dynamic>{
      'cash_on_delivery': instance.cashOnDelivery,
    };

DeliveryMethodDistribution _$DeliveryMethodDistributionFromJson(
        Map<String, dynamic> json) =>
    DeliveryMethodDistribution(
      homeDelivery: (json['home_delivery'] as num).toInt(),
    );

Map<String, dynamic> _$DeliveryMethodDistributionToJson(
        DeliveryMethodDistribution instance) =>
    <String, dynamic>{
      'home_delivery': instance.homeDelivery,
    };

QuickStats _$QuickStatsFromJson(Map<String, dynamic> json) => QuickStats(
      pendingOrders: (json['pending_orders'] as num).toInt(),
      deliveredOrders: (json['delivered_orders'] as num).toInt(),
      cancelledOrders: (json['cancelled_orders'] as num).toInt(),
      totalProducts: (json['total_products'] as num).toInt(),
      outOfStockProducts: (json['out_of_stock_products'] as num).toInt(),
    );

Map<String, dynamic> _$QuickStatsToJson(QuickStats instance) =>
    <String, dynamic>{
      'pending_orders': instance.pendingOrders,
      'delivered_orders': instance.deliveredOrders,
      'cancelled_orders': instance.cancelledOrders,
      'total_products': instance.totalProducts,
      'out_of_stock_products': instance.outOfStockProducts,
    };
