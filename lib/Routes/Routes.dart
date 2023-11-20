import 'package:get/get.dart';
import 'package:steamhouse/Routes/RoutesString.dart';
import 'package:steamhouse/Screens/BottomNavigation/BottomnavigationBar.dart';
import 'package:steamhouse/Screens/Company/CompanyList.dart';
import 'package:steamhouse/Screens/Complain/AddComplain.dart';
import 'package:steamhouse/Screens/Complain/ComplainDetail.dart';
import 'package:steamhouse/Screens/Profile/EditProfile.dart';
import 'package:steamhouse/Screens/Track/TrackComplain.dart';
import 'package:steamhouse/Screens/Complain/UserComplainDetail.dart';
import 'package:steamhouse/Screens/Employee/EmployeeList.dart';
import 'package:steamhouse/Screens/Home/Home.dart';
import 'package:steamhouse/Screens/LiveData/LiveData.dart';
import 'package:steamhouse/Screens/Login/Login.dart';
import 'package:steamhouse/SplashScreen.dart';

Routes() => [
      GetPage(name: '/', page: () => SplashScreen(),),
      GetPage(name: loginRoute, page: () => Login()),
      GetPage(name: bottombarRoute, page: () => BottomnavigationBar()),
      GetPage(name: homeRoute, page: () => Home()),
      GetPage(name: addcomplainRoute, page: () => AddComplain()),
      GetPage(name: complaindetailRoute, page: () => ComplainDetail()),
      GetPage(name: usercomplaindetailRoute, page: () => UserComplainDetail()),
      GetPage(name: companylistRoute, page: () => CompanyList()),
      GetPage(name: employeelistRoute, page: () => EmployeeList()),
      GetPage(name: trackcomplainRoute, page: () => TrackComplain()),
      GetPage(name: livedataRoute, page: () => LiveData()),
      GetPage(name: editrouteRoute, page: () => EditProfile()),
    ];
