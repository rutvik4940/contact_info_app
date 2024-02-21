
import 'package:flutter/cupertino.dart';

import '../../modal/model.dart';

class ContactProvider with ChangeNotifier
{
List <DataModel> contactList=[];
  int stepindex = 0;
  String? path = "";
  bool islight=false;
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
    if(stepindex<3)
    {
      stepindex--;
      notifyListeners();
    }
  }
  void addpath(String p1)
  {
    path=p1;
    notifyListeners();
  }
  void addContact(DataModel d1)
  {
    contactList.add(d1);
    notifyListeners();
  }
  void changeThem()
  {
    islight=!islight;
    notifyListeners();
  }
}