part of 'widgets.dart';

class CardPricesDestination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(builder: (context, state) {
      if (state.manualselection!) {
        return _BuildCardPricesDestination(
          nameStation: state.nameStation!,
          address: state.address!,
          id: state.id!,
          destination: state.coors!,
        );
      } else {
        return Container();
      }
    });
  }
}

class _BuildCardPricesDestination extends StatelessWidget {
  final String? nameStation;
  final String? address;
  final String? id;
  final LatLng? destination;

  _BuildCardPricesDestination(
      {Key? key, this.nameStation, this.address, this.id, this.destination})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trafficService = new TrafficService();

    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: BounceInLeft(
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color.fromRGBO(245, 223, 77, 1.0),
              ),
              onPressed: () {
                BlocProvider.of<MapBloc>(context).add(OnDisableCard());
              },
            ),
          ),
        ),
        Positioned(
            bottom: size.height * 0.08,
            left: size.width * 0.085,
            right: size.width * 0.085,
            child: Stack(children: [
              BounceInUp(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  color: Colors.black,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.025,
                      horizontal: size.height * 0.03,
                    ),
                    width: size.width * 0.915,
                    height: size.height * 0.26,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$nameStation',
                          style: TextStyle(
                              color: Color.fromRGBO(245, 223, 77, 1.0),
                              fontWeight: FontWeight.w500,
                              fontSize: size.height * 0.02),
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
                        Text(
                          '$address',
                          maxLines: 3,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: size.height * 0.016),
                        ),
                        SizedBox(
                          height: size.height * 0.007,
                        ),
                        FutureBuilder(
                          future: trafficService.getStationsPrices(id!),
                          builder: (context,
                              AsyncSnapshot<GasolinePricesResponse> snapshot) {
                            if (snapshot.hasData) {
                              final GasolinePricesResponse prices =
                                  snapshot.data!;
                              return Center(
                                child: Row(
                                  mainAxisAlignment:
                                      (prices.prices!.regular! > 0 &&
                                              prices.prices!.diesel! > 0 &&
                                              prices.prices!.premium! > 0)
                                          ? MainAxisAlignment.spaceBetween
                                          : MainAxisAlignment.spaceAround,
                                  children: [
                                    (prices.prices!.regular! > 0)
                                        ? columPrice(context, 'Regular',
                                            '${prices.prices!.regular}')
                                        : Container(),
                                    (prices.prices!.premium! > 0)
                                        ? columPrice(context, 'Premium',
                                            '${prices.prices!.premium}')
                                        : Container(),
                                    (prices.prices!.diesel! > 0)
                                        ? columPrice(context, 'Diésel',
                                            '${prices.prices!.diesel}')
                                        : Container(),
                                  ].whereType<Column>().toList(),
                                ),
                              );
                            } else {
                              return Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8.0),
                                      child: Skeleton(
                                          width: double.infinity,
                                          textColor:
                                              Color.fromRGBO(245, 223, 77, 1.0),
                                          height: 9,
                                          style: SkeletonStyle.text),
                                    ),
                                    Skeleton(
                                        width: double.infinity,
                                        textColor: Colors.white,
                                        height: 9,
                                        style: SkeletonStyle.text),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.007,
                        ),
                        Center(
                          child: MaterialButton(
                            height: size.height * 0.042,
                            minWidth: size.width,
                            color: Color.fromRGBO(245, 223, 77, 1.0),
                            shape: StadiumBorder(),
                            elevation: 0.0,
                            splashColor: Colors.transparent,
                            child: Text(
                              'INDICACIONES',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              this.calculateDestination(context, destination!);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ])),
        Positioned(
          bottom: size.height * 0.322,
          right: size.width * 0.16,
          child: FadeIn(
            delay: Duration(milliseconds: 700),
            child: Container(
              padding: EdgeInsets.all(0),
              //color: Colors.red,
              width: 35,
              height: 35,
              child: Image.asset('assets/png/Indicaciones.png',
                  width: size.width * 0.2),
            ),
          ),
        )
      ],
    );
  }

  void calculateDestination(BuildContext context, LatLng coors) async {
    calculatingDistance(context);

    final trafficService = TrafficService();
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final start = BlocProvider.of<MyLocationBloc>(context).state.location;
    final destination = coors;

    // obtner información del destino
    final reverseQueryResponse =
        await trafficService.getCoordsInfo(destination);

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
    BlocProvider.of<MapBloc>(context).add(OnDisableCard());
  }

  Widget columPrice(BuildContext context, String product, String price) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          product,
          style: TextStyle(
              color: Color.fromRGBO(245, 223, 77, 1.0),
              fontWeight: FontWeight.w500,
              fontSize: size.height * 0.017),
        ),
        Text(
          '\$$price',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: size.height * 0.017),
        ),
      ],
    );
  }
}
