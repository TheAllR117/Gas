import 'package:flutter/material.dart';

class CustomInputV1 extends StatelessWidget {
  final String? labelText;
  final TextInputType? type;
  final bool? isPassword;
  final Stream? stringP;
  final Function? funcion;

  const CustomInputV1(
      {Key? key,
      this.labelText,
      this.type,
      this.isPassword,
      this.stringP,
      this.funcion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: StreamBuilder(
          stream: stringP,
          builder: (context, snapshot) {
            return TextFormField(
              obscureText: isPassword!,
              obscuringCharacter: '*',
              keyboardType: type,
              decoration: InputDecoration(
                  isDense: true, // Added this
                  contentPadding: EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
                  ),
                  hoverColor: Color.fromRGBO(0, 0, 0, 0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  labelStyle: TextStyle(fontSize: 12),
                  labelText: labelText,
                  //counterText: snapshot.data,
                  errorText: (snapshot.error != null)
                      ? snapshot.error.toString()
                      : null,
                  errorMaxLines: 4),
              onChanged: (value) => funcion!(value),
            );
          }),
    );
  }
}
