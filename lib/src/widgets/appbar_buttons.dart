part of 'widgets.dart';

class AppbarButtons extends StatelessWidget {
  const AppbarButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              //color: Color.fromRGBO(245, 223, 77, 1.0),
              color: Colors.transparent,
            ),
            onPressed: () {}),
        IconButton(
            icon: Icon(Icons.menu, color: Color.fromRGBO(245, 223, 77, 1.0)),
            onPressed: () {})
      ],
    );
  }
}
