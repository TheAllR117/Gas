part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchMapBloc, SearchState>(builder: (context, state) {
      if (!state.manualselection) {
        return FadeIn(child: buildSearchbar(context));
      } else {
        return Container();
      }
    });
  }

  Widget buildSearchbar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        final proximity =
            BlocProvider.of<MyLocationBloc>(context).state.location;
        final result = await showSearch(
            context: context, delegate: SearchDestination(proximity!));
        this.returnSearch(context, result!);
      },
      child: Container(
        width: double.infinity,
        height: size.height * 0.05,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.022,
        ),
        margin: EdgeInsets.only(
            left: size.width * 0.022,
            right: size.width * 0.022,
            top: size.height * 0.015),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.search,
                color: Colors.grey,
                size: size.height * 0.03,
              ),
            ),
            Text(
              'Nombre de la estación',
              style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                  fontSize: size.height * 0.02),
            ),
          ],
        ),
        /*child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(8.0),
            ),
            isDense: true, // Added this
            contentPadding: EdgeInsets.only(left: 10),
            focusedBorder: OutlineInputBorder(
              //borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
            ),
            hoverColor: Color.fromRGBO(255, 255, 255, 0.9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            hintText: 'Nombre de la estación',
            hintStyle: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
                fontSize: size.height * 0.02),
            suffixIcon: Icon(
              Icons.search,
              color: Colors.grey,
              size: size.height * 0.035,
            ),
          ),
        ),*/
      ),
    );
  }

  Future returnSearch(BuildContext context, SearchResult result) async {
    if (result.cancel!) return;
    if (result.manual!) {
      BlocProvider.of<SearchMapBloc>(context).add(OnActivateManualDialer());
    }

    final trafficService = new TrafficService();
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final start = BlocProvider.of<MyLocationBloc>(context).state.location;
    final destination = result.position;

    final drivingTraffic =
        await trafficService.getStartAndEndCoordinates(start!, destination!);
    final geometry = drivingTraffic.routes![0].geometry;
    final duration = drivingTraffic.routes![0].duration;
    final distance = drivingTraffic.routes![0].distance;
    final nameDestination = result.nameDestination;

    final points = Poly.decodePolyline(geometry.toString());

    final List<LatLng> coordsList = points
        .map((point) => LatLng(point[0].toDouble(), point[1].toDouble()))
        .toList();

    //final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);

    /*final List<LatLng> routeCoords = points.decodedCoords
        .map((point) => LatLng(point[0], point[1]))
        .toList();*/

    mapBloc.add(OnCreateDestinationStartPath(
        coordsList, distance!, duration!, nameDestination!));
  }
}
