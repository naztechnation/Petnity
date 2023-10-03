

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../blocs/location/location_cubit.dart';
import '../../../handlers/location_handler.dart';
import '../../../model/view_models/account_view_model.dart';

class MapViews extends StatefulWidget {
final double zoom;
  
  const MapViews({Key? key,   this.zoom  =  19.151926040649414}) : super(key: key);

  @override
  State<MapViews> createState() => _MapViewsState();
}

class _MapViewsState extends State<MapViews> {
  final Completer<GoogleMapController> _mapController = Completer();

  late CameraPosition _userPosition;

  late LocationCubit _locationCubit;

  late AccountViewModel _userViewModel;

  

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  @override
  void initState() {
    _locationCubit = context.read<LocationCubit>();
    _userViewModel = Provider.of<AccountViewModel>(context, listen: false);
    _initPosition();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  void _initPosition() {
    final longitude = _userViewModel.longitude;
    final latitude = _userViewModel.latitude;

    _userPosition =
        CameraPosition(target: LatLng(latitude, longitude), zoom: widget.zoom);
    _locationCubit.addressFromLocation(latitude, longitude);
  }

  _afterLayout(_) async {
    final currentPosition = await LocationHandler.determinePosition();
    _resetPosition(currentPosition.latitude, currentPosition.longitude);
  }

  void _resetPosition(double latitude, double longitude,
      {bool notify = true}) async {
    final GoogleMapController controller = await _mapController.future;
    _userPosition =
        CameraPosition(target: LatLng(latitude, longitude), zoom: widget.zoom);
    controller.animateCamera(CameraUpdate.newCameraPosition(_userPosition));
    if (notify) _locationCubit.addressFromLocation(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    
        return GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _userPosition,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false);
      
  }
}