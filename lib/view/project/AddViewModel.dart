import 'package:flutter/cupertino.dart';

import '../widget/CustomCheckboxTile.dart';

class AddViewModel extends ChangeNotifier {
  List<Item> testList = [
    Item(title: "전문분야1", isChecked: false),
    Item(title: "전문분야2", isChecked: true),
    Item(title: "전문분야3", isChecked: false),
    Item(title: "전문분야4", isChecked: false),
    Item(title: "전문분야5", isChecked: false),
    Item(title: "전문분야6", isChecked: false),
    Item(title: "전문분야7", isChecked: false),
    Item(title: "전문분야8", isChecked: false),
    Item(title: "전문분야9", isChecked: false),
    Item(title: "전문분야10", isChecked: false),
  ];

  void toggleCheckbox(int index) {
    testList[index].isChecked = !testList[index].isChecked;
    print(testList[index].isChecked);
    notifyListeners();
  }
}
