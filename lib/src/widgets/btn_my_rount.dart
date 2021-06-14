part of 'widgets.dart';

class BtnRount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        maxRadius: 25,
        child: IconButton(
          color: Colors.transparent,
          onPressed: () {
            mapBloc.add(OnMarkRoute());
          },
          icon: Icon(
            Icons.more_horiz,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
