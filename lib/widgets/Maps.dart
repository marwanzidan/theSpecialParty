import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:TheSpecialParty/constants.dart';
import 'package:TheSpecialParty/models/createordermodel.dart';
import 'package:TheSpecialParty/screens/orderinfo.dart';
import 'package:TheSpecialParty/widgets/map_style.dart';
import 'package:permission/permission.dart';

class MapsPikerPage extends StatefulWidget {
  String from;
  bool fromPositionBool;
  List<Products> tempproducts;
  double totalprice;
  String locationname;
  double longitutde;
  double lattitude;
  String reciverphone;
  String recivername;
  MapsPikerPage({this.from = '', this.fromPositionBool = false,
  this.lattitude,this.longitutde,this.locationname,this.tempproducts,this.totalprice,
  this.recivername,this.reciverphone
  });
  @override
  _MapsPikerPageState createState() {
    return _MapsPikerPageState();
  }
}

class _MapsPikerPageState extends State<MapsPikerPage> {
  Map<MarkerId, Marker> markers =
      <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: "AIzaSyD23Hw6XKGvxz0kULcS53UegpUi1_AetTM");
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String locationString = "";
  bool isGettingLocation = false;
  bool updateLocationApi = false;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  LatLng selectedPosition;
  void _addMarker(LatLng latLang) async {
    var markerIdVal = "50";
    setState(() {
      this.selectedPosition = latLang;
    });
    final MarkerId markerId = MarkerId(markerIdVal);
    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: latLang,
      // infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
    );
    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
    setState(() {
      this.isGettingLocation = true;
    });
    var address = await Geocoder.local.findAddressesFromCoordinates(
        new Coordinates(latLang.latitude, latLang.longitude));
    setState(() {
      this.locationString = address.first.addressLine;
      this.isGettingLocation = false;
    });
  }

  Future<void> _redirctCameraPosition(CameraPosition cameraPosition) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future<String> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;
      var address = await Geocoder.local.findAddressesFromQuery(p.description);
      _addMarker(new LatLng(lat, lng));
      _redirctCameraPosition(CameraPosition(
          bearing: 192.8334901395799,
          target: new LatLng(lat, lng),
          tilt: 0,
          zoom: 15));
    }
  }

  getCurrentPosition() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // print("my Location Long :${position.longitude}");
    // print("my Location lat :${position.latitude}");
    _addMarker(new LatLng(position.latitude, position.longitude));
    _redirctCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: new LatLng(position.latitude, position.longitude),
        tilt: 0,
        zoom: 15));
  }

  //User user ;
  getPermission() async {
    List<PermissionName> permissionNames = [PermissionName.Location];
    final status = await Permission.getPermissionsStatus(permissionNames);
    // print("permission Status : : $status");
    if (status[0].permissionStatus != PermissionStatus.allow) {
      // print("not allowed ");
      var permissions = await Permission.requestPermissions(permissionNames);
      setState(() {});
    } else {}
    // print("allowed");
  }

  @override
  void initState() {
    getPermission();
    super.initState();
    this.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: pinktheme,
          title: Text("حدد موقعك",
              style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: 'hayah',
                  fontWeight: FontWeight.w400,
                  color: Colors.white)),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 18,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        floatingActionButton: this.updateLocationApi
            ? FloatingActionButton(
                onPressed: () {},
                child: Container(
                  decoration: BoxDecoration(
                      color: pinktheme,
                      shape: BoxShape.circle),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      backgroundColor:pinktheme,
                    ),
                  ),
                ),
              )
            : Builder(
                builder: (context) {
                  return FloatingActionButton.extended(
                    onPressed: () {
                      // orderdetailsState.setState(() {
                      //   reciverlocation.text=locationString;
                      //   latitudefromdetails=selectedPosition.latitude;
                      //   longitiudefromdetails=selectedPosition.longitude;
                      // });
                      if (selectedPosition == null) {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please select or search  location"),
                          ),
                        );
                      } else {
                        setState(() {
                          locationmap.text=locationString;
                          lattitude=selectedPosition.latitude;
                          longitutde=selectedPosition.longitude;

                        });
                        Navigator.pop(context);
                    
                        if (widget.from == 'addItemsPage') {
                          // if (widget.fromPositionBool == true) {
                          //   addressFrom = locationString;
                          //   pointFrom = Position(
                          //       latitude: selectedPosition.latitude,
                          //       longitude: selectedPosition.longitude);
                          //   gotPointFrom = true;
                          // } else {
                          //   pointTo = Position(
                          //       latitude: selectedPosition.latitude,
                          //       longitude: selectedPosition.longitude);
                          //   addressTo = locationString;
                          //   gotPointTo = true;
                          // }

                        } else {
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (_) => HomePage()));
                        }
                      }
                    },
                    label: Text('اختيار هذا الموقع',
                        style: TextStyle(color: Colors.white,
                        fontFamily: 'hayah'
                        )),
                    icon: Icon(Icons.check, color: Colors.white),
                    backgroundColor:pinktheme
                  );
                },
              ),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                child: GoogleMap(
                  mapType: MapType.terrain,
                  zoomControlsEnabled: false,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    controller.setMapStyle(MapStyle.mapStyles);
                  },
                  onTap: (latLang) {
                    // print(latLang);
                    _addMarker(latLang);
                  },
                  markers: Set<Marker>.of(markers.values),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Positioned(
              top: 16,
              right: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  padding: EdgeInsets.all(5),
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.width / 10),
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: Color(0x44000000),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight:
                                  MediaQuery.of(context).size.width / 10),
                          width: MediaQuery.of(context).size.width / 2,
                          child: isGettingLocation
                              ? Center(
                                  child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue),
                                  backgroundColor:pinktheme,
                                ))
                              : Text(locationString),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  Prediction p = await PlacesAutocomplete.show(
                                    context: context,
                                    apiKey:
                                        "AIzaSyD23Hw6XKGvxz0kULcS53UegpUi1_AetTM",
                                    mode: Mode.overlay,
                                  );
                                  displayPrediction(p);
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: MediaQuery.of(context).size.height / 9,
                left: 16,
                child: InkWell(
                  onTap: () {
                    this.getCurrentPosition();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 10,
                    height: MediaQuery.of(context).size.width / 10,
                    decoration: BoxDecoration(
                        color: pinktheme, shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        Icons.location_searching,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
