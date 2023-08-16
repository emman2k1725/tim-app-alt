// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:tim_app/backend/firebase/businessDataProvider.dart';
// import 'package:tim_app/backend/firebase/firebaseService.dart';
// import 'package:tim_app/pages/apply_business/tabbar.dart';
// import 'package:tim_app/pages/dashboard_menu_components/header.dart';
// import 'package:tim_app/pages/travellers/traveller_plan/travel_plan_kanban.dart';
// import 'package:tim_app/pages/travellers/traveller_plan/traveller_plan_search.dart';
// import 'package:tim_app/utils/constants.dart';
// import 'package:tim_app/widgets/appbar.dart';
// import 'package:tim_app/widgets/blurContainer.dart';
// import 'package:tim_app/widgets/customButtons.dart';

// import '../../backend/authservice/authentication.dart';
// import '../../backend/firebase/userDataProvider.dart';
// import '../../model/BusinessModel.dart';

// class TravellerScreen extends StatelessWidget {
//   const TravellerScreen({super.key});

//   @override
//   build(BuildContext context) {
//     UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
//     if (userProvider.userData?.hasBusiness == false) {
//       // back to traveller dashboard
//     }
//     BusinessDataProvider businessDataProvider =
//         Provider.of<BusinessDataProvider>(context);
//     bool isApprove = true;
//     return Scaffold(
//       appBar: CustomAppBar(title: 'Admin Dashboard'),
//       body: SingleChildScrollView(
//         primary: false,
//         child: Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: AssetImage(mainBg),
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: BlurContainer(
//                 height: 600,
//                 width: double.maxFinite,
//                 childColumn: Column(
//                   children: [
//                     TravelPlanSearch()
//                     // SizedBox(
//                     //   height: 20,
//                     // ),
//                     // Row(
//                     //   children: [
//                     //     TravelPlanKanban(),
//                     //   ],
//                     // ),
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.center,
//                     //   children: [
//                     //     CustomButton(
//                     //       text: 'SAVE',
//                     //       onPressed: () {},
//                     //     )
//                     //   ],
//                     // ),
//                   ],
//                 ),
//               ),
//             )),
//       ),
//     );
//   }
// }
