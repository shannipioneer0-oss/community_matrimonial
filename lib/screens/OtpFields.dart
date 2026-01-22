
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpFields extends StatefulWidget {


  final Function(String) callback;
  final String otp;

  OtpFields({required this.callback, required this.otp});

  @override
  _OtpFieldsState createState() => _OtpFieldsState();

}

class _OtpFieldsState extends State<OtpFields> {
  static List<TextEditingController> _controllers = [];
   List<FocusNode> _focusNodes = [];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(6, (index) => TextEditingController());
    _focusNodes = List.generate(6, (index) => FocusNode());


    WidgetsBinding.instance.addPostFrameCallback((_) =>
    setState(() {


      print(widget.otp.length.toString());
      if(widget.otp != "") {


        _controllers[0].text = widget.otp[0].toString();
        _controllers[1].text = widget.otp[1].toString();
        _controllers[2].text = widget.otp[2].toString();
        _controllers[3].text = widget.otp[3].toString();
        _controllers[4].text = widget.otp[4].toString();
        _controllers[5].text = widget.otp[5].toString();

      }
    })
    );


  }

  @override
  void dispose() {
    for (int i = 0; i < 6; i++) {
      _controllers[i].dispose();
      _focusNodes[i].dispose();
    }
    super.dispose();
  }

  int indexremove = 5;

  @override
  Widget build(BuildContext context) {

    return
     RawKeyboardListener(
    focusNode: FocusNode(),
    autofocus: true,// Focus node for the listener
    onKey: (RawKeyEvent event) {
    // Check if the key event is a backspace press
    if (event is RawKeyDownEvent &&
    event.logicalKey == LogicalKeyboardKey.backspace) {

      setState(() {

        _controllers[indexremove].clear();
        _focusNodes[indexremove].unfocus();
        _focusNodes[indexremove-1].requestFocus();

        indexremove--;

        if(indexremove == 0){
          indexremove = 5;
        }

      });


    }
    },child:Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        6,
            (index) => OtpField(
          controller: _controllers[index],
          focusNode: _focusNodes[index], onValueChanged: (value ) {

              String otpValue = _controllers.map((controller) => controller.text).join();
              widget.callback(otpValue);
            
            }, indexlengthfromlast: indexremove, indexincre: index,
        ),
      ),
    ), );
  }
}

class OtpField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback? onBackPress;
  final Function(String)? onValueChanged;
  final int indexlengthfromlast;
  final int indexincre;

  OtpField({required this.controller, required this.focusNode , this.onBackPress , required this.onValueChanged, required this.indexlengthfromlast, required this.indexincre});

  @override
  _OtpFieldState createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width*0.13,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/otp_code_box.png'), // Replace with your image asset path
          fit: BoxFit.contain,
        ),
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: (value) {
          if (value.length == 1 && widget.indexincre < 5) {
            widget.focusNode.nextFocus();
          }

          if (widget.onValueChanged != null) {
            widget.onValueChanged!(value);
          }

        },
        onSubmitted: (value) {

        },
        onEditingComplete: () {
          if (widget.onBackPress != null) {
            widget.onBackPress!();
          }
        },
        decoration: InputDecoration(
          counterText: "", // Hide the character counter
          border: InputBorder.none
        ),
      ),

    );
  }
}