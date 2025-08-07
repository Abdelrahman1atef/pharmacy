import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/common_widgets/pharmacy_app_bar.dart';
import 'package:pharmacy/features/admin/dashboard/logic/dashboard_cubit.dart';
import 'package:pharmacy/generated/l10n.dart';

import '../widgets/quick_stats_widget.dart';
import '../widgets/sales_overview_widget.dart';
import '../widgets/order_status_widget.dart';
import '../widgets/user_statistics_widget.dart';
import '../widgets/product_performance_widget.dart';
import '../widgets/recent_activity_widget.dart';
import '../widgets/revenue_trends_widget.dart';
import '../widgets/payment_delivery_widget.dart';

import '../../logic/dashboard_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardCubit>().fetchDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const PharmacyAppBar(
        isGeneralLayout: false,
        heightFactor: 1.1,
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return state.when(
            initial: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.dashboard, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    S.of(context).dashboardInitial,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ],
              ),
            ),
            loading: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(S.of(context).loadingDashboardData),
                ],
              ),
            ),
            loaded: (dashboard) => RefreshIndicator(
              onRefresh: () async {
                context.read<DashboardCubit>().fetchDashboard();
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quick Stats Cards
                    QuickStatsWidget(stats: dashboard.dashboardResult.quickStats),
                    const SizedBox(height: 24),
                    
                    // Sales Overview
                    SalesOverviewWidget(sales: dashboard.dashboardResult.salesOverview),
                    const SizedBox(height: 24),
                    
                    // Order Status Distribution
                    OrderStatusWidget(status: dashboard.dashboardResult.orderStatusDistribution),
                    const SizedBox(height: 24),
                    
                    // User Statistics
                    UserStatisticsWidget(users: dashboard.dashboardResult.userStatistics),
                    const SizedBox(height: 24),
                    
                    // Product Performance
                    ProductPerformanceWidget(products: dashboard.dashboardResult.productPerformance),
                    const SizedBox(height: 24),
                    
                    // Recent Activity
                    RecentActivityWidget(activity: dashboard.dashboardResult.recentActivity),
                    const SizedBox(height: 24),
                    
                    // Revenue Trends
                    RevenueTrendsWidget(trends: dashboard.dashboardResult.revenueTrends),
                    const SizedBox(height: 24),
                    
                    // Payment & Delivery Methods
                    PaymentDeliveryWidget(
                      payment: dashboard.dashboardResult.paymentMethodDistribution,
                      delivery: dashboard.dashboardResult.deliveryMethodDistribution,
                    ),
                  ],
                ),
              ),
            ),
            error: (msg) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
                  const SizedBox(height: 16),
                  Text(
                    S.of(context).dashboardError(msg),
                    style: TextStyle(color: Colors.red[600], fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<DashboardCubit>().fetchDashboard();
                    },
                    child: Text(S.of(context).retry),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 