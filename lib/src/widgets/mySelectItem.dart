import 'package:flutter/material.dart';

class MySelectionItem extends StatelessWidget {
  final String? title;
  final bool? isForList;

  const MySelectionItem({Key? key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList!
          ? Padding(
              child: _buildItem(context, Colors.black),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context, Colors.white),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildItem(BuildContext context, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: FittedBox(child: Text(title!, style: TextStyle(color: color))),
    );
  }
}
