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
      child: Consumer<ContactProvider>(builder: (context, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: app_routs,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode:value.islight?ThemeMode.dark:ThemeMode.light,
        ),
      ),
    )
  );
}
