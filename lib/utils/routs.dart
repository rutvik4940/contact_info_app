


import 'package:flutter/cupertino.dart';

import '../screen/addcontact/addcontact_screen.dart';
import '../screen/detail/detail_screen.dart';
import '../screen/hidden/hideen_screen.dart';
import '../screen/home/home_screen.dart';

Map<String,WidgetBuilder>app_routs={
   "/":(context) => HomeScreen(),
  "add_data":(context) => AddcontactScreen(),
  "detail":(context) => DetailScreen(),
  "auth":(context) => HiddenScreen(),


};