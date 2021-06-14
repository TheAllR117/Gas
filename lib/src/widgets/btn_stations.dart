part of 'widgets.dart';

class BtnStation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        maxRadius: 25,
        child: IconButton(
          color: Colors.transparent,
          onPressed: () {
            /*for (int i = 0; i < nameDestination.length; i++) {
              mapBloc.add(
                  OnCreateStationMarks(rutaCoords[0], i, nameDestination[i], addr));
            }*/
          },
          icon: Icon(
            Icons.local_gas_station,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
