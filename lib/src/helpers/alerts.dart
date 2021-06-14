part of 'helpers.dart';

showLoading(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
            title: Text('Espere por favor...'),
            content: Container(
              width: 100,
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            ),
          ));
}

showAlert(BuildContext context, String titulo, String mensaje) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(titulo),
            content: Text(mensaje),
            actions: [
              MaterialButton(
                  child: Text('Aceptar'),
                  onPressed: () => Navigator.of(context).pop())
            ],
          ));
}

showConfirmePayment(
    BuildContext context,
    String gasoline,
    String payment,
    String liters,
    String sale,
    // ignore: non_constant_identifier_names
    String dispatcher_id,
    // ignore: non_constant_identifier_names
    String no_bomb,
    // ignore: non_constant_identifier_names
    String no_island) {
  showDialog(
      context: context,
      builder: (_) => Dialog(
          backgroundColor: Colors.white,
          elevation: 0.0,
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          insetPadding: EdgeInsets.symmetric(horizontal: 40),
          child: body(context, gasoline, payment, liters, sale, dispatcher_id,
              no_bomb, no_island)));
}

Widget body(
    context,
    String gasoline,
    String payment,
    String liters,
    // ignore: non_constant_identifier_names
    String sale,
    // ignore: non_constant_identifier_names
    String dispatcher_id,
    // ignore: non_constant_identifier_names
    String no_bomb,
    // ignore: non_constant_identifier_names
    String no_island) {
  final contactService = new ContactService();
  final authService = new AuthService();
  //var percent = NumberFormat.percentPattern("ar");
  var formatter = NumberFormat.currency(locale: "es_MX", symbol: "\$");
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
    child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Center(
            child: Text(
              "Confirmar pago",
              style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(245, 223, 76, 1.0),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Center(
          child: Text(
            "${formatter.format(double.parse(payment))}",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    Icons.local_gas_station,
                    size: 40,
                    color: Color.fromRGBO(245, 223, 76, 1.0),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Producto',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        gasoline,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_city,
                    size: 40,
                    color: Color.fromRGBO(245, 223, 76, 1.0),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Estación',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        'La poblanita',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ]),
        SizedBox(
          height: 10,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    Icons.invert_colors,
                    size: 40,
                    color: Color.fromRGBO(245, 223, 76, 1.0),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Litros',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        liters,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_city,
                    size: 40,
                    color: Colors.transparent,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Estación',
                          style: TextStyle(
                              fontSize: 10, color: Colors.transparent)),
                      Text(
                        'La poblanita',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.transparent),
                      )
                    ],
                  )
                ],
              ),
            ]),
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                print('gasolina $no_island');
                ErrorResponse resp = await contactService.payment(
                    'accept',
                    gasoline,
                    payment,
                    liters,
                    sale,
                    dispatcher_id,
                    no_bomb,
                    no_island);
                if (resp.ok!) {
                  Navigator.pop(context);
                  await authService.isLoggedIn();
                  showAlert(context, 'Éxito', resp.message!);
                } else {
                  showAlert(context, 'Error', resp.message!);
                }
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  primary: Colors.grey[850],
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                  textStyle: TextStyle(
                    color: Color.fromRGBO(232, 188, 2, 1.0),
                  ),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(13.0),
                  )),
              child: Text(
                'Enviar',
                style: TextStyle(
                    fontSize: 18.0,
                    //fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(232, 188, 2, 1.0)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  primary: Colors.grey[850],
                  onPrimary: Colors.white,
                  onSurface: Colors.grey,
                  textStyle: TextStyle(
                    color: Color.fromRGBO(232, 188, 2, 1.0),
                  ),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(13.0),
                  )),
              child: Text(
                'Cancelar',
                style: TextStyle(
                    fontSize: 18.0,
                    //fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(232, 188, 2, 1.0)),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}

showAlertList(BuildContext context, String titulo, List mensaje) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(titulo),
            content: setupAlertDialoadContainer(context, mensaje),
            actions: [
              MaterialButton(
                  child: Text('Aceptar'),
                  onPressed: () => Navigator.of(context).pop())
            ],
          ));
}

Widget setupAlertDialoadContainer(BuildContext context, List mensaje) {
  //final size = MediaQuery.of(context).size;
  return Container(
    //height: size.height * 0.1, // Change as per your requirement
    width: 300.0, // Change as per your requirement
    child: ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 0),
      shrinkWrap: true,
      itemCount: mensaje.length,
      itemBuilder: (BuildContext context, int index) {
        if (mensaje[index] != '') {
          return ListTile(
            leading: Text(
              '${index + 1}.- ${mensaje[index]}',
              style: TextStyle(fontSize: 16),
            ),
          );
        } else {
          return Container();
        }
      },
    ),
  );
}

void calculatingDistance(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text('Espere por favor'),
              content: Text('Calculando ruta'),
            ));
  } else {
    showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
              title: Text('Espere por favor'),
              content: Text('Calculando ruta'),
            ));
  }
}

void loading(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              //title: Text('Espere por favor'),
              content: Lottie.asset('assets/lottie/loading.json',
                  width: 100, height: 100, reverse: false),
            ));
  } else {
    showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
              title: Text('Espere por favor'),
              content: CircularProgressIndicator(),
            ));
  }
}
