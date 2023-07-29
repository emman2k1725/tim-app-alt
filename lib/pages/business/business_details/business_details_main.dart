import 'package:flutter/material.dart';
import 'package:tim_app/pages/business/business_dashboard_main.dart';
import 'package:tim_app/pages/business/business_details/business_details_screen.dart';
import 'package:tim_app/pages/business/components/business_side_menu.dart';

class BusinessDashboard extends StatefulWidget {
  const BusinessDashboard({Key? key}) : super(key: key);

  @override
  _BusinessDashboardState createState() => _BusinessDashboardState();
}

class _BusinessDashboardState extends State<BusinessDashboard> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business Dashboard'),
      ),
      drawer: BusinessSideMenu(),
      body: Stack(
        children: [
          // Main content area
          Navigator(
            key: _navigatorKey,
            onGenerateRoute: (settings) {
              // Define your routes here
              switch (settings.name) {
                case '/':
                  return MaterialPageRoute(
                      builder: (context) => BusinessScreen());

                case '/business-details':
                  return MaterialPageRoute(
                      builder: (context) => BusinessDetailsScreen());
                // Add more routes for other pages
                default:
                  return MaterialPageRoute(
                      builder: (context) => BusinessScreen());
              }
            },
          ),
        ],
      ),
    );
  }
}

// Rest of the code remains the same...
