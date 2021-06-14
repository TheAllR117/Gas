import 'package:flutter/material.dart';

class InputDateMovements extends StatelessWidget {
  const InputDateMovements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(0),
      width: 150,
      height: 60,
      //color: Colors.red,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
            fontSize: size.height * 0.02, height: size.height * 0.0015),
        //style: TextStyle(fontSize: 10.0, color: Colors.black),
        decoration: InputDecoration(
          isDense: true, // Added this
          contentPadding: EdgeInsets.only(
              left: size.height * 0.02, right: size.height * 0.01),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
          ),
          hoverColor: Color.fromRGBO(0, 0, 0, 0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          hintText: '0000/00/00',
          //labelText: 'Email',
          suffixIcon: Icon(
            Icons.calendar_today_sharp,
            color: Colors.black,
            size: size.height * 0.025,
          ),
          //counterText: snapshot.data,
        ),
      ),
    );
  }
}
