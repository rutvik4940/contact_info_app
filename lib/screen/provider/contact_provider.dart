

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../../modal/model.dart';
import '../../utils/shared_helper.dart';

class ContactProvider with ChangeNotifier
{
List <DataModel> contactList=[];
List <DataModel> hidenContactList=[];

  int stepindex = 0;
  String? path = "";
  String? addImage;
  bool theme =false;
bool changeTheme = false;
ThemeMode mode = ThemeMode.light;
IconData themeMode = Icons.dark_mode;
LocalAuthentication auth = LocalAuthentication();
void setTheme() async {
  theme = !theme;
  saveTheme(changeTheme: theme);
  changeTheme = (await applyTheme())!;
  if (changeTheme == true) {
    mode = ThemeMode.dark;
    themeMode = Icons.light_mode;
  } else if (changeTheme == false) {
    mode = ThemeMode.light;
    themeMode = Icons.dark_mode;
  }
  notifyListeners();
}
void getTheme() async {
  if (await applyTheme() == null) {
    changeTheme = false;
  } else {
    changeTheme = (await applyTheme())!;
  }
  if (changeTheme == true) {
    mode = ThemeMode.dark;
    themeMode = Icons.light_mode;
  } else if (changeTheme == false) {
    mode = ThemeMode.light;
    themeMode = Icons.dark_mode;
  } else {
    mode = ThemeMode.light;
    themeMode = Icons.dark_mode;
  }
  notifyListeners();
}
  void onStepContinue()
  {
    if(stepindex<3)
      {
        stepindex++;
        notifyListeners();
      }
  }
  void onStepCancel()
  {
    if(stepindex>0)
    {
      stepindex--;
      notifyListeners();
    }
  }
  void addPath(String p1)
  {
    path=p1;
    notifyListeners();
  }
  void addContact(DataModel d1)
  {
    contactList.add(d1);
    notifyListeners();
  }

void updateContact({required int index,required DataModel c2})
{
  contactList[index]=c2;
  notifyListeners();
}
void edit(String i)
{
  addImage=i;
  notifyListeners();
}
void editI(String p1)
{
  addImage=p1;
  notifyListeners();
}
void deleteContact(int r)
{
  contactList.removeAt(r);
  notifyListeners();
}
Future<bool?> authlock()
async {
  bool check=true;
   bool data = await auth.canCheckBiometrics;
  if(data)
    {
      List<BiometricType> l1=await auth.getAvailableBiometrics();
      if(l1.isNotEmpty) {
         bool check = await auth.authenticate(
            localizedReason: 'Please authenticate to show account balance',
            options: const AuthenticationOptions(biometricOnly: true));
         return check;
      }
    }
  notifyListeners();
}
void hidelock(int index)
{
  DataModel d1=contactList[stepindex];
  hidenContactList.add(d1);
  contactList.removeAt(stepindex);
}
}