


import 'dart:async';
import 'dart:io';


import 'package:community_matrimonial/app_utils/Cropper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:path_provider/path_provider.dart';

class  MultiSelectDialogWithBottomSheet{





  Future<MultiSelectBottomSheetField> showBottomSheet(BuildContext context ,List<MultiSelectItem> items) async {

    Completer<List<dynamic>> completer = Completer();

    return MultiSelectBottomSheetField(
      items: items.map((e) => MultiSelectItem(e, e.label)).toList(),
      listType: MultiSelectListType.CHIP,

      onConfirm: (values) {

        completer.complete(values);

      },
    );


  }




  void showMultiSelect(BuildContext context ,List<MultiSelectItem> items , TextEditingController controller, String title , {required  Function(String newData) callback}) async {

    List<MultiSelectItem> item_selected = [];
    List<dynamic> list_dynamic = [];
    String selectedValues = "";
    List<dynamic> initialValues = [];





    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      useRootNavigator: true,
      builder: (ctx) {


        items.forEach((element) {



          if(controller.text.toString().contains(element.label)){
            if(element.label.toLowerCase() != "any") {

              initialValues.add(element.value);

              print(element.value.toString()+"-=-=");
            }
          }

        },);


        return  SafeArea(child: Container(child:MultiSelectBottomSheet(
          title: Container( padding:EdgeInsets.all(10) , alignment: Alignment.topLeft ,child:Text(title , style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold ,color: Colors.purple),),),
          items: items,
          onConfirm: (values_result) {

           item_selected =  items.where((element) =>  values_result.contains(element.value)).toList();

           String label = item_selected.map((e) => e.label).join(",");
           String value = item_selected.map((e) => e.value).join(",");

           print(value+"====");

           controller.text = label;
           callback(value);

           selectedValues = value;


          },
          maxChildSize: 1,
          initialChildSize: 0.85,
          initialValue: initialValues,
          searchable: true,
        )));
      },
    );
  }



  void fetchData(void Function(String) onDataFetched) {
    // Simulating fetching data from somewhere
    String data = "Hello from non-widget class!";

    // Calling the callback with the fetched data
    onDataFetched(data);
  }






}




