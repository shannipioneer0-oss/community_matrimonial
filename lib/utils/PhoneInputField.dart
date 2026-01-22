import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:libphonenumber_plugin/libphonenumber_plugin.dart';

class PhoneInputField extends StatefulWidget {
  final Function(String countryCode, String mobileNumber)? onChanged;

  final Function()? onChanged2;

  // External controller to update values
  final PhoneInputController controller;

  const PhoneInputField({
    Key? key,
    required this.controller,
    this.onChanged, this.onChanged2,
  }) : super(key: key);

  @override
  _PhoneInputFieldState createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  late Country selectedCountry;
  late TextEditingController phoneController;


  Future<bool?> isValidPhone({
    required String number,
    required String isoCode,
  }) async {

    try {

      final parsed = await PhoneNumberUtil.isValidPhoneNumber(
          number , isoCode
      );

      print(parsed);

      return parsed;

    } catch (e) {

      print(e);
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    selectedCountry = Country.parse('IN'); // default country
    phoneController = TextEditingController();

    // Listen to controller updates
    widget.controller._setValueCallback = (country, number) {
      setState(() {
        selectedCountry = country;
        phoneController.text = number;
      });
    };
  }

  bool isInvalid = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            showCountryPicker(
              context: context,
              showPhoneCode: true,
              onSelect: (Country country) {
                setState(() {
                  selectedCountry = country;
                  widget.onChanged?.call(selectedCountry.countryCode, phoneController.text);
                });
              },
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Text(selectedCountry.flagEmoji),
                SizedBox(width: 8),
                Text('+${selectedCountry.phoneCode}'),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter text',
              errorText: isInvalid ? 'Invalid mobile number' : null,
              hintText: 'Type something...',
              suffixIcon: GestureDetector(
                onTap: (){

                  widget.onChanged2!();

                }, // click action
                child: Icon(Icons.paste), // the clickable icon
              ),
            ),
            onChanged: (value) async {


              bool? valid = await isValidPhone(
                number: "+"+selectedCountry.phoneCode+value,
                isoCode: selectedCountry.countryCode,
              );



              setState(() {
                isInvalid = !valid! && value.isNotEmpty;
              });

              widget.onChanged?.call(selectedCountry.countryCode, value);

            },

          ),
        ),
      ],
    );
  }
}

/// Controller to set values from outside
class PhoneInputController {
  void Function(Country country, String number)? _setValueCallback;

  void setValue(Country country, String number) {
    _setValueCallback?.call(country, number);
  }
}
