import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy/core/enum/delivery_method.dart';
import 'package:pharmacy/core/enum/payment_method.dart';
import 'package:pharmacy/core/enum/order_status.dart';
import 'package:pharmacy/generated/l10n.dart';

part 'dashboard_response.g.dart';

@JsonSerializable()
class DashboardResponse {
  @JsonKey(name: "dashboard_result")
  final DashboardResult dashboardResult;

  DashboardResponse({
    required this.dashboardResult,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) => _$DashboardResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardResponseToJson(this);
}

@JsonSerializable()
class DashboardResult {
  @JsonKey(name: "sales_overview")
  final SalesOverview salesOverview;
  @JsonKey(name: "order_status_distribution")
  final OrderStatusDistribution orderStatusDistribution;
  @JsonKey(name: "user_statistics")
  final UserStatistics userStatistics;
  @JsonKey(name: "product_performance")
  final ProductPerformance productPerformance;
  @JsonKey(name: "recent_activity")
  final RecentActivity recentActivity;
  @JsonKey(name: "revenue_trends")
  final RevenueTrends revenueTrends;
  @JsonKey(name: "payment_method_distribution")
  final PaymentMethodDistribution paymentMethodDistribution;
  @JsonKey(name: "delivery_method_distribution")
  final DeliveryMethodDistribution deliveryMethodDistribution;
  @JsonKey(name: "quick_stats")
  final QuickStats quickStats;

  DashboardResult({
    required this.salesOverview,
    required this.orderStatusDistribution,
    required this.userStatistics,
    required this.productPerformance,
    required this.recentActivity,
    required this.revenueTrends,
    required this.paymentMethodDistribution,
    required this.deliveryMethodDistribution,
    required this.quickStats,
  });

  factory DashboardResult.fromJson(Map<String, dynamic> json) => _$DashboardResultFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardResultToJson(this);
}

@JsonSerializable()
class SalesOverview {
  @JsonKey(name: "total_orders")
  final int totalOrders;
  @JsonKey(name: "total_revenue")
  final double totalRevenue;
  @JsonKey(name: "recent_orders_count")
  final int recentOrdersCount;
  @JsonKey(name: "recent_revenue")
  final double recentRevenue;
  @JsonKey(name: "avg_order_value")
  final double avgOrderValue;

  SalesOverview({
    required this.totalOrders,
    required this.totalRevenue,
    required this.recentOrdersCount,
    required this.recentRevenue,
    required this.avgOrderValue,
  });

  factory SalesOverview.fromJson(Map<String, dynamic> json) => _$SalesOverviewFromJson(json);
  Map<String, dynamic> toJson() => _$SalesOverviewToJson(this);
}

@JsonSerializable()
class OrderStatusDistribution {
  final int pending;
  final int preparing;
  final int shipped;
  final int delivered;
  final int cancelled;

  OrderStatusDistribution({
    required this.pending,
    required this.preparing,
    required this.shipped,
    required this.delivered,
    required this.cancelled,
  });

  factory OrderStatusDistribution.fromJson(Map<String, dynamic> json) => _$OrderStatusDistributionFromJson(json);
  Map<String, dynamic> toJson() => _$OrderStatusDistributionToJson(this);
}

@JsonSerializable()
class UserStatistics {
  @JsonKey(name: "total_users")
  final int totalUsers;
  @JsonKey(name: "active_users")
  final int activeUsers;
  @JsonKey(name: "new_users_this_month")
  final int newUsersThisMonth;
  @JsonKey(name: "user_growth_rate")
  final double userGrowthRate;

  UserStatistics({
    required this.totalUsers,
    required this.activeUsers,
    required this.newUsersThisMonth,
    required this.userGrowthRate,
  });

  factory UserStatistics.fromJson(Map<String, dynamic> json) => _$UserStatisticsFromJson(json);
  Map<String, dynamic> toJson() => _$UserStatisticsToJson(this);
}

@JsonSerializable()
class ProductPerformance {
  @JsonKey(name: "top_selling_products")
  final List<TopSellingProduct> topSellingProducts;
  @JsonKey(name: "out_of_stock_products")
  final List<OutOfStockProduct> outOfStockProducts;
  @JsonKey(name: "out_of_stock_count")
  final int outOfStockCount;
  @JsonKey(name: "out_of_stock_products_shown")
  final int outOfStockProductsShown;

  ProductPerformance({
    required this.topSellingProducts,
    required this.outOfStockProducts,
    required this.outOfStockCount,
    required this.outOfStockProductsShown,
  });

  factory ProductPerformance.fromJson(Map<String, dynamic> json) => _$ProductPerformanceFromJson(json);
  Map<String, dynamic> toJson() => _$ProductPerformanceToJson(this);
}

@JsonSerializable()
class TopSellingProduct {
  @JsonKey(name: "product_id")
  final double productId;
  @JsonKey(name: "product_name_en")
  final String productNameEn;
  @JsonKey(name: "total_sold")
  final int totalSold;

  TopSellingProduct({
    required this.productId,
    required this.productNameEn,
    required this.totalSold,
  });

  factory TopSellingProduct.fromJson(Map<String, dynamic> json) => _$TopSellingProductFromJson(json);
  Map<String, dynamic> toJson() => _$TopSellingProductToJson(this);
}

@JsonSerializable()
class OutOfStockProduct {
  @JsonKey(name: "product_id")
  final double productId;
  @JsonKey(name: "product_name_en")
  final String productNameEn;
  @JsonKey(name: "product_name_ar")
  final String productNameAr;
  @JsonKey(name: "total_stock")
  final double totalStock;

  OutOfStockProduct({
    required this.productId,
    required this.productNameEn,
    required this.productNameAr,
    required this.totalStock,
  });

  factory OutOfStockProduct.fromJson(Map<String, dynamic> json) => _$OutOfStockProductFromJson(json);
  Map<String, dynamic> toJson() => _$OutOfStockProductToJson(this);
}

@JsonSerializable()
class RecentActivity {
  @JsonKey(name: "recent_orders")
  final List<RecentOrder> recentOrders;

  RecentActivity({
    required this.recentOrders,
  });

  factory RecentActivity.fromJson(Map<String, dynamic> json) => _$RecentActivityFromJson(json);
  Map<String, dynamic> toJson() => _$RecentActivityToJson(this);
}

@JsonSerializable()
class RecentOrder {
  @JsonKey(name: "order_id")
  final int orderId;
  @JsonKey(name: "customer_name")
  final String customerName;
  @JsonKey(name: "customer_email")
  final String customerEmail;
  @JsonKey(name: "customer_phone")
  final String customerPhone;
  @JsonKey(name: "total_amount")
  final double totalAmount;
  final OrderStatus status;
  @JsonKey(name: "created_at")
  final String createdAt;
  @JsonKey(name: "payment_method")
  final PaymentMethod paymentMethod;
  @JsonKey(name: "delivery_method")
  final DeliveryMethod deliveryMethod;

  RecentOrder({
    required this.orderId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.paymentMethod,
    required this.deliveryMethod,
  });

  factory RecentOrder.fromJson(Map<String, dynamic> json) => _$RecentOrderFromJson(json);
  Map<String, dynamic> toJson() => _$RecentOrderToJson(this);

  String getStatusText(BuildContext context) {
    return status.getLocalizedDisplayName(S.of(context));
  }

  Color getStatusColor() {
    switch (status) {
      case OrderStatus.pending:
        return OrderStatus.pending.getStatusColor();
      case OrderStatus.preparing:
        return OrderStatus.preparing.getStatusColor();
      case OrderStatus.shipped:
        return OrderStatus.shipped.getStatusColor();
      case OrderStatus.delivered:
        return OrderStatus.delivered.getStatusColor();
      case OrderStatus.cancelled:
        return OrderStatus.cancelled.getStatusColor();
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon() {
    switch (status) {
      case OrderStatus.pending:
        return OrderStatus.pending.getStatusIcon();
      case OrderStatus.preparing:
        return OrderStatus.preparing.getStatusIcon();
      case OrderStatus.shipped:
        return OrderStatus.shipped.getStatusIcon();
      case OrderStatus.delivered:
        return OrderStatus.delivered.getStatusIcon();
      case OrderStatus.cancelled:
        return OrderStatus.cancelled.getStatusIcon();
      default:
        return Icons.help;
    }
  }
}

@JsonSerializable()
class RevenueTrends {
  @JsonKey(name: "daily_revenue")
  final List<DailyRevenue> dailyRevenue;

  RevenueTrends({
    required this.dailyRevenue,
  });

  factory RevenueTrends.fromJson(Map<String, dynamic> json) => _$RevenueTrendsFromJson(json);
  Map<String, dynamic> toJson() => _$RevenueTrendsToJson(this);
}

@JsonSerializable()
class DailyRevenue {
  final String date;
  final double revenue;
  final int orders;

  DailyRevenue({
    required this.date,
    required this.revenue,
    required this.orders,
  });

  factory DailyRevenue.fromJson(Map<String, dynamic> json) => _$DailyRevenueFromJson(json);
  Map<String, dynamic> toJson() => _$DailyRevenueToJson(this);
}

@JsonSerializable()
class PaymentMethodDistribution {
  @JsonKey(name: "cash_on_delivery")
  final int cashOnDelivery;

  PaymentMethodDistribution({
    required this.cashOnDelivery,
  });

  factory PaymentMethodDistribution.fromJson(Map<String, dynamic> json) => _$PaymentMethodDistributionFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentMethodDistributionToJson(this);
}

@JsonSerializable()
class DeliveryMethodDistribution {
  @JsonKey(name: "home_delivery")
  final int homeDelivery;
  @JsonKey(name: "pharmacy_pickup")
  final int pharmacyPickup;

  DeliveryMethodDistribution({
    required this.homeDelivery,
    required this.pharmacyPickup,
  });

  factory DeliveryMethodDistribution.fromJson(Map<String, dynamic> json) => _$DeliveryMethodDistributionFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryMethodDistributionToJson(this);
}

@JsonSerializable()
class QuickStats {
  @JsonKey(name: "pending_orders")
  final int pendingOrders;
  @JsonKey(name: "delivered_orders")
  final int deliveredOrders;
  @JsonKey(name: "cancelled_orders")
  final int cancelledOrders;
  @JsonKey(name: "total_products")
  final int totalProducts;
  @JsonKey(name: "out_of_stock_products")
  final int outOfStockProducts;

  QuickStats({
    required this.pendingOrders,
    required this.deliveredOrders,
    required this.cancelledOrders,
    required this.totalProducts,
    required this.outOfStockProducts,
  });

  factory QuickStats.fromJson(Map<String, dynamic> json) => _$QuickStatsFromJson(json);
  Map<String, dynamic> toJson() => _$QuickStatsToJson(this);
} 