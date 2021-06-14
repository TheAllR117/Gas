import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class InputMoney extends StatelessWidget {
  final String? labelText;
  final Stream? stringP;
  final Function? funcion;
  const InputMoney({Key? key, this.stringP, this.funcion, this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: stringP,
        builder: (context, snapshot) {
          return TextField(
            maxLength: 10,
            keyboardType: TextInputType.number,
            inputFormatters: [ThousandsFormatter()],
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(8.0),
              ),
              isDense: true,
              contentPadding:
                  EdgeInsets.only(left: 10, top: 15, bottom: 15, right: 10),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0)),
              ),
              hoverColor: Color.fromRGBO(255, 255, 255, 0.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: labelText,
              errorText:
                  (snapshot.error != null) ? snapshot.error.toString() : null,
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                  fontSize: size.height * 0.02),
            ),
            onChanged: (value) =>
                funcion!(int.parse(value.replaceAll(',', ''))),
          );
        });
  }
}
/*
Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(17),
                        focusedBorder: OutlineInputBorder(
                          //borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                        hoverColor: Color.fromRGBO(255, 255, 255, 0.9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        hintText: 'Cantidad',
                        hintStyle: TextStyle(
                            color: Colors.grey, fontStyle: FontStyle.italic),
                        /*suffixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),*/
                      ),
                    ),
                  ),
*/