part of 'widgets.dart';

class ManualMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchMapBloc, SearchState>(builder: (context, state) {
      if (state.manualselection) {
        return _BuildMarker();
      } else {
        return Container();
      }
    });
  }
}

class _BuildMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          top: 50,
          left: 20,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color.fromRGBO(245, 223, 77, 1.0),
            ),
            onPressed: () {
              BlocProvider.of<SearchMapBloc>(context)
                  .add(OnDisableManualDialer());
            },
          ),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0, -14),
            child: BounceInDown(
              delay: Duration(seconds: 1),
              from: 200,
              child: Icon(
                Icons.location_on,
                color: Color.fromRGBO(245, 223, 77, 1.0),
                size: 50,
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 70,
            left: 40,
            child: MaterialButton(
              minWidth: size.width - 120,
              color: Color.fromRGBO(245, 223, 77, 1.0),
              shape: StadiumBorder(),
              elevation: 0.0,
              splashColor: Colors.transparent,
              child: Text(
                'Confirmar destino',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                this.calculateDestination(context);
              },
            ))
      ],
    );
  }

  void calculateDestination(BuildContext context) async {
    calculatingDistance(context);

    final trafficService = TrafficService();
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final start = BlocProvider.of<MyLocationBloc>(context).state.location;
    final destination = mapBloc.state.centralLocation;

    // obtner información del destino
    final reverseQueryResponse =
        await trafficService.getCoordsInfo(destination!);

    final trafficResponse =
        await trafficService.getStartAndEndCoordinates(start!, destination);
    final geometry = trafficResponse.routes![0].geometry;
    final duration = trafficResponse.routes![0].duration;
    final distance = trafficResponse.routes![0].distance;
    final nameDestination = reverseQueryResponse.features![0].textEs;

    final points = Poly.decodePolyline(geometry.toString());

    final List<LatLng> coordsList = points
        .map((point) => LatLng(point[0].toDouble(), point[1].toDouble()))
        .toList();

    /*final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6)
        .decodedCoords;

    final List<LatLng> coordsList =
        points.map((point) => LatLng(point[0], point[1])).toList();*/

    mapBloc.add(OnCreateDestinationStartPath(
        coordsList, distance!, duration!, nameDestination!));
    Navigator.of(context).pop();
    BlocProvider.of<SearchMapBloc>(context).add(OnDisableManualDialer());
  }
}
