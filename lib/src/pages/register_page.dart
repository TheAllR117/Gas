import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gasfast/src/bloc/providerP.dart';
import 'package:gasfast/src/helpers/helpers.dart';
import 'package:gasfast/src/widgets/btn_complet_form.dart';
import 'package:gasfast/src/widgets/input_text_v1.dart';
import 'package:gasfast/src/widgets/mySelectItem.dart';

import 'package:lottie/lottie.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:direct_select/direct_select.dart';
// import 'package:flutter_picker/flutter_picker.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        _crearFondo(context),
        MyStatefulWidget(),
      ]),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                Color.fromRGBO(245, 223, 76, 1),
                Color.fromRGBO(232, 188, 2, 1),
              ])),
        ),
        Positioned(
          top: -size.height * 0.45,
          left: -size.height * 0.55,
          child: Container(
            height: size.height * 0.7,
            width: size.height * 0.7,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.1),
              borderRadius: BorderRadius.circular(size.height * 0.5),
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.85,
          left: size.height * 0.25,
          child: Container(
            height: size.height * 0.7,
            width: size.height * 0.7,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.1),
              borderRadius: BorderRadius.circular(size.height * 0.5),
            ),
          ),
        ),
      ],
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  //MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String fecha = 'YYYY-MM-DD';
  DateTime? fechaSel;

  final elements1 = [
    "Hombre",
    "Mujer",
  ];

  final gender = [
    "H",
    "M",
  ];
  int selectedIndex1 = 0;

  List<Widget> _buildItems1() {
    return elements1
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  TextEditingController _controller = TextEditingController();
  int _index = 0;
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = ProviderP.register(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SafeArea(
              child: Padding(
            padding: EdgeInsets.only(right: size.width * 0.1),
            child: Container(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                    ),
                    child: Text(
                      'INICIAR',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, 'login'),
                  ),
                  TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),
                      ),
                      child: Text('REGÍSTRATE',
                          style:
                              TextStyle(fontSize: 18.0, color: Colors.black)),
                      onPressed: () {})
                ],
              ),
            ),
          )),
          Container(
            child: Lottie.asset('assets/lottie/logo.json',
                width: size.width * 0.55, repeat: false),
          ),
          Container(
            //height: 300,
            width: size.width * 0.90,
            child: Theme(
              data: ThemeData(
                  colorScheme: ColorScheme.light(primary: Colors.black)),
              child: Stepper(
                physics: BouncingScrollPhysics(),
                currentStep: _index,
                onStepCancel: () {
                  if (_index <= 0) {
                    return;
                  }
                  setState(() {
                    _index--;
                  });
                },
                onStepContinue: () {
                  if (_index >= 2) {
                    showAlert(context, 'Error', 'Llena todos los campos');
                    return;
                  }
                  setState(() {
                    _index++;
                  });
                },
                onStepTapped: (index) {
                  setState(() {
                    _index = index;
                  });
                },
                controlsBuilder: (BuildContext context,
                    {VoidCallback? onStepContinue,
                    VoidCallback? onStepCancel}) {
                  return Row(
                    children: <Widget>[
                      (_index != 2)
                          ? TextButton(
                              onPressed: onStepContinue,
                              style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent),
                              ),
                              child: Text(
                                'CONTINUAR',
                                style: TextStyle(color: Colors.black),
                              ))
                          : TextButton(
                              onPressed: onStepCancel,
                              style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent),
                              ),
                              child: Text(
                                'ATRÁS',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                      (_index > 0 && _index < 2)
                          ? TextButton(
                              onPressed: onStepCancel,
                              style: ButtonStyle(
                                overlayColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.transparent),
                              ),
                              child: Text(
                                'ATRÁS',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : Container(),
                    ],
                  );
                },
                steps: [
                  Step(
                    title: Text('DATOS PERSONALES'),
                    isActive: (_index == 0) ? true : false,
                    state: StepState.indexed,
                    content: Column(
                      children: <Widget>[
                        CustomInputV1(
                          labelText: 'NOMBRE (S)',
                          type: TextInputType.name,
                          isPassword: false,
                          stringP: bloc.nameString,
                          funcion: bloc.changeName,
                        ),
                        CustomInputV1(
                          labelText: 'APELLIDO PATERNO',
                          type: TextInputType.name,
                          isPassword: false,
                          stringP: bloc.lastNameString,
                          funcion: bloc.changeLastName,
                        ),
                        CustomInputV1(
                          labelText: 'APELLIDO MATERNO',
                          type: TextInputType.name,
                          isPassword: false,
                          stringP: bloc.secondNameString,
                          funcion: bloc.changeSecondName,
                        ),
                        CustomInputV1(
                          labelText: 'EMAIL',
                          type: TextInputType.emailAddress,
                          isPassword: false,
                          stringP: bloc.emailString,
                          funcion: bloc.changeEmail,
                        ),
                        CustomInputV1(
                          labelText: 'CONTRASEÑA',
                          type: TextInputType.visiblePassword,
                          isPassword: true,
                          stringP: bloc.passwordString,
                          funcion: bloc.changePassword,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: StreamBuilder(
                              stream: bloc.verifyPasswordString,
                              builder: (context, snapshot) {
                                print(snapshot.error);
                                return TextFormField(
                                  obscureText: true,
                                  obscuringCharacter: '*',
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(10),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(0, 0, 0, 1)),
                                      ),
                                      hoverColor: Color.fromRGBO(0, 0, 0, 0.3),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      labelStyle: TextStyle(fontSize: 12),
                                      labelText: 'CONFIRMAR CONTRASEÑA',
                                      //counterText: snapshot.data,
                                      errorText: (snapshot.error != null)
                                          ? snapshot.error.toString()
                                          : null,
                                      errorMaxLines: 4),
                                  onChanged: (value) =>
                                      bloc.changeVerifyPassword(value),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  Step(
                    isActive: (_index == 1) ? true : false,
                    state: StepState.indexed,
                    title: Text('DATOS DE CONTACTO'),
                    content: Column(
                      children: <Widget>[
                        CustomInputV1(
                          labelText: 'TELÉFONO',
                          type: TextInputType.phone,
                          isPassword: false,
                          stringP: bloc.phoneString,
                          funcion: bloc.changePhone,
                        ),
                        CustomInputV1(
                          labelText: 'DIRECCIÓN',
                          type: TextInputType.streetAddress,
                          isPassword: false,
                          stringP: bloc.addressString,
                          funcion: bloc.changeAddress,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: StreamBuilder(
                              stream: bloc.birthdayString,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  _controller.value = _controller.value
                                      .copyWith(text: bloc.birthday);
                                }

                                return TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: _controller,
                                    readOnly: true,
                                    enableInteractiveSelection: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelStyle: TextStyle(fontSize: 12),
                                      contentPadding: EdgeInsets.all(10),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(0, 0, 0, 1)),
                                      ),
                                      hoverColor: Color.fromRGBO(0, 0, 0, 0.3),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      //hintText: 'Email',
                                      labelText: 'FECHA DE NACIMIENTO',
                                      //counterText: snapshot.data,
                                    ),
                                    onTap: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(1900, 1, 1),
                                          maxTime: DateTime.now(),
                                          onChanged: (date) {
                                        final newFecha =
                                            date.toString().split(' ');
                                        bloc.changebirthday(newFecha[0]);
                                        fecha = snapshot.data.toString();
                                      }, onConfirm: (date) {
                                        fecha = snapshot.data.toString();
                                        fechaSel = date;
                                      },
                                          currentTime: (fecha != 'YYYY-MM-DD')
                                              ? fechaSel
                                              : DateTime.now(),
                                          locale: LocaleType.es,
                                          theme: DatePickerTheme(
                                              cancelStyle: TextStyle(
                                                  color: Colors.white),
                                              itemStyle: TextStyle(
                                                color: Colors.white,
                                              ),
                                              doneStyle: TextStyle(
                                                  color: Colors.amber),
                                              backgroundColor:
                                                  Colors.grey[900]!));
                                    });
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            child: StreamBuilder(
                                stream: bloc.genderString,
                                builder: (context, snapshot) {
                                  return Container(
                                    height: 35,
                                    padding: EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border:
                                            Border.all(color: Colors.black45)),
                                    child: DirectSelect(
                                        itemExtent: 35.0,
                                        selectedIndex: selectedIndex1,
                                        //backgroundColor: Colors.grey[900],
                                        //selectionColor: Colors.white54,
                                        child: MySelectionItem(
                                          isForList: true,
                                          title: elements1[selectedIndex1],
                                        ),
                                        onSelectedItemChanged: (index) {
                                          setState(() {
                                            bloc.changeGender(gender[index!]);
                                            selectedIndex1 = index;
                                          });
                                        },
                                        mode: DirectSelectMode.tap,
                                        items: _buildItems1()),
                                  );
                                }),
                          ),
                          /*Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            readOnly: true,
                            enableInteractiveSelection: false,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              isDense: true,
                              labelStyle: TextStyle(fontSize: 12),
                              contentPadding: EdgeInsets.all(10),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
                              ),
                              hoverColor: Color.fromRGBO(0, 0, 0, 0.3),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              //hintText: 'Email',
                              labelText: 'GENERO',
                              //counterText: snapshot.data,
                            ),
                            onTap: () {},
                          ),
                        ),*/
                        )
                      ],
                    ),
                  ),
                  Step(
                    isActive: (_index == 2) ? true : false,
                    state: StepState.indexed,
                    title: Text('VEHÍCULO'),
                    content: Column(
                      children: <Widget>[
                        CustomInputV1(
                          labelText: 'TIPO DE VEHÍCULO',
                          type: TextInputType.text,
                          isPassword: false,
                          stringP: bloc.vehicleTypeString,
                          funcion: bloc.changeVehicleType,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BtnCompletForm(
            labelText: 'REGISTRARSE',
            stringP: bloc.formValidStream,
            function: bloc,
            nameFunction: 'register',
          )
        ],
      ),
    );
  }
}
