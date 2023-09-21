import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/backend/firebase/UserDataProvider.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/pages/travellers/apply_business/applyBusiness.dart';
import 'package:tim_app/pages/travellers/apply_business/apply_components/apply_main_screen.dart';
import 'package:tim_app/pages/travellers/apply_business/manage_components/manage_main_screen.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/appbar.dart';

class ApplyBusinessMain extends StatelessWidget {
  const ApplyBusinessMain({super.key});

  @override
  Widget build(BuildContext context) {
    UserDataProvider userDataProvider = Provider.of<UserDataProvider>(context);
    UserModel? user = userDataProvider.userData;
    if (user == null) {
      userDataProvider.loadDataFromSharedPref();
      user = userDataProvider.userData;
    }

    bool isBusiness = true;

    return Scaffold(
      appBar: CustomAppBar(title: 'Admin Dashboard'),
      body: SingleChildScrollView(
        primary: false,
        child: Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 1.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(mainBg),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                user!.hasBusiness == false
                    ? ApplyMainScreen()
                    : ManageApplyScreen()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
