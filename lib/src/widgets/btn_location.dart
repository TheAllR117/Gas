part of 'widgets.dart';

class BtnLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final myLocation = BlocProvider.of<MyLocationBloc>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        maxRadius: 25,
        child: IconButton(
          color: Colors.transparent,
          onPressed: () {
            final destino = myLocation.state.location;
            mapBloc.moveCamera(destino!);
          },
          icon: Icon(
            Icons.my_location,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
