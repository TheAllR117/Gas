import 'package:flutter/material.dart';
import 'package:gasfast/src/models/map/search_response.dart';
import 'package:gasfast/src/models/map/search_result.dart';
import 'package:gasfast/src/services/traffic_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
//import 'package:flutter/services.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  /*@override
  ThemeData appBarTheme(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Theme.of(context).copyWith(

        //scaffoldBackgroundColor: Colors.grey[900],
        );
  }*/
  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximity;

  SearchDestination(this.proximity)
      : this.searchFieldLabel = 'Nombre de la estación',
        this._trafficService = new TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.delete), onPressed: () => this.query = '')
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => this.close(context, SearchResult(cancel: true)));
  }

  @override
  Widget buildResults(BuildContext context) {
    return this._buildResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.length == 0) {
      return ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Colocar estación manualmente'),
            onTap: () {
              this.close(context, SearchResult(cancel: false, manual: true));
            },
          )
        ],
      );
    }
    return this._buildResults();
  }

  Widget _buildResults() {
    if (this.query.length == 0) {
      return Container();
    }

    this._trafficService.getSugerenciasPorQuery(this.query.trim(), proximity);

    return StreamBuilder(
      stream: this._trafficService.sugerenciasStreamController,
      builder:
          (BuildContext context, AsyncSnapshot<SearchMapResponse> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final places = snapshot.data!.features;

        if (places!.length == 0) {
          return ListTile(
            title: Text('No hay resultados con $query'),
          );
        }

        return ListView.separated(
            separatorBuilder: (_, i) => Divider(),
            itemCount: places.length,
            itemBuilder: (_, i) {
              final place = places[i];
              return ListTile(
                leading: Icon(Icons.place),
                title: Text(place.textEs!),
                subtitle: Text(place.placeNameEs!),
                onTap: () {
                  this.close(
                      context,
                      SearchResult(
                          cancel: false,
                          manual: false,
                          position: LatLng(place.center![1], place.center![0]),
                          nameDestination: place.textEs,
                          description: place.placeNameEs));
                },
              );
            });
      },
    );
  }
}
