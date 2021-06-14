part of 'widgets.dart';

class BtnFollowLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return BlocBuilder<MapBloc, MapState>(builder: (context, state) {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          maxRadius: 25,
          child: IconButton(
            color: Colors.transparent,
            onPressed: () {
              mapBloc.add(OnfollowLocation());
            },
            icon: Icon(
              mapBloc.state.followLocation!
                  ? Icons.directions_run
                  : Icons.accessibility_new,
              color: Colors.amber,
            ),
          ),
        ),
      );
    });
  }
}
