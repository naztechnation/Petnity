import 'package:flutter/material.dart';
import 'package:petnity/res/app_colors.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_screens/all_services.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_screens/awaiting_sessions.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_screens/ongoing_purchase.dart';
import 'package:petnity/ui/landing_page/track_purchase/track_purchase_screens/ongoing_services.dart';

class TrackPurchase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        backgroundColor: AppColors.lightBackground,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Purchases 56'),
                  Text('Ongoing Purchases 16')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TabBar(
                unselectedLabelColor: Colors.black,
                isScrollable: true,
                indicator: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                tabs: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('All'),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Ongoing Services'),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Ongoing Purchases'),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Pending Products'),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // Customize the color as desired
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Awaiting Sessions'),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // Customize the color as desired
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AllServices(),
                  OngoinServices(),
                  OngoingPurchases(),
                  Center(child: Text('Tab 5 View')),
                  AwaitingSession(),
                  // Repeat the same pattern for other tab views
                  // Tab 3 View, Tab 4 View, Tab 5 View
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
