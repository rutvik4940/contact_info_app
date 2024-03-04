import 'package:contact_info/screen/provider/contact_provider.dart';
import 'package:contact_info/utils/routs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()
{
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ContactProvider()),
      ],
      child: Consumer<ContactProvider>(
        builder: (context, value, child) {
          value.getTheme();
          value.theme = value.changeTheme;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: value.mode,
            routes: app_routs,
          );
        },
      ),
    )
  );
}
