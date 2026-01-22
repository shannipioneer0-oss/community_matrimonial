





import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {

  final ValueChanged<String> onItemSelected;
  final List<String> listItems;
  final String selectedItem;
  final String label;
  final String seq;
  DropDown({Key? key, required this.label  , required this.selectedItem  ,required this.listItems  ,required this.onItemSelected , required this.seq});

  @override
  MyDropDownState createState() => MyDropDownState();
}

class MyDropDownState extends State<DropDown> {

  String selectedItem = "";

  @override
  void initState() {
    super.initState();

    setState(() {
      selectedItem =  widget.selectedItem;
    });


  }

  @override
  Widget build(BuildContext context) {

    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        // Add Horizontal padding using menuItemStyleData.padding so it matches
        // the menu padding when button's width is not specified.
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      hint: Text(
        widget.label,
        style: TextStyle(fontSize: 14),
      ),
      value: widget.seq == "gender" ? widget.selectedItem : widget.seq == "from_age" ? widget.selectedItem : widget.seq == "to_age" ? widget.selectedItem
       : widget.seq == "from_height" ? widget.selectedItem :  widget.seq == "to_height" ? widget.selectedItem : "18",
      items:
          widget.listItems.map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select gender.';
        }
        return null;
      },
      onChanged: (value) {

        widget.onItemSelected(value!);

      },
      onSaved: (value) {
        selectedItem = value.toString();
        widget.onItemSelected(selectedItem);

      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}