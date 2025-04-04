
import 'package:steamhouse/config/Import.dart';

class TextboxController extends GetxController {
  List<TextEditingController> textlist = [];
  
  Multi (array){
    for (int i = 0; i < array.length; i++)
      textlist.add(TextEditingController());
  }
}
