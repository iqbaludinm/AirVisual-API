import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:request_api/main.dart';
import 'package:request_api/models/cities_gps.dart';
import 'package:request_api/util/api.dart';
import 'package:request_api/util/location_service.dart';
import 'package:request_api/util/settings.dart';
import 'package:intl/intl.dart';

Color mainColor = Color(0xfff3ec19);
Color secondColor = Color(0xFFFF5B16);
Color thirdColor = Color(0xffF7971E);

class Search extends StatefulWidget {
  // to export DateFormat => use intl
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final f = new DateFormat('EEEE, dd MMM');
  bool first = true;
  bool _visible = true;
  bool submitted = false;
  double longitude = 0;
  double latitude = 0;
  Future<CitiesGps> current;
  final _formKey = GlobalKey<FormState>();
  LocationService locationService = LocationService();

  @override
  void dispose() {
    locationService.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    locationService.locationStream.listen((userLocation) {
      setState(() {
        latitude = userLocation.latitude;
        longitude = userLocation.longitude;
        print(longitude);
        print(latitude);

        current = currentLoc(longitude, latitude);
      });
    });
  }

  void setDialVisible(bool value) {
    setState(() {
      _visible = value;
    });
  }

  SpeedDial _speedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 24),
      onOpen: () => print('Button Open'),
      onClose: () => print('Button Close'),
      curve: Curves.easeInBack,
      visible: _visible,
      children: [
        SpeedDialChild(
          onTap: () => print('Ya disini ngab, mo kemane lagi'),
          backgroundColor: Colors.green,
          child: Icon(
            Icons.home,
            color: primaryColorLight,
          ),
          label: 'Search',
          labelStyle: TextStyle(color: Colors.white),
          labelBackgroundColor: Colors.green,
        ),
        SpeedDialChild(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Search()),
                (route) => false);
          },
          backgroundColor: Colors.red,
          child: Icon(
            Icons.account_balance_outlined,
            color: Colors.white,
          ),
          label: 'List Negara',
          labelStyle: TextStyle(color: Colors.white),
          labelBackgroundColor: Colors.red,
        ),
        SpeedDialChild(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Search()),
                (route) => false);
          },
          backgroundColor: Colors.blue[800],
          child: Icon(
            Icons.apartment_rounded,
            color: Colors.white,
          ),
          label: 'List Kota',
          labelStyle: TextStyle(color: Colors.white),
          labelBackgroundColor: Colors.blue[800],
        ),
        SpeedDialChild(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Search()),
                (route) => false);
          },
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
          label: 'Cari kotamu!',
          labelStyle: TextStyle(color: Colors.white),
          labelBackgroundColor: Colors.amber,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CitiesGps>(
      future: current,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SpinKitWave(
                  size: 35.0,
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index.isEven ? Colors.green : secondColor),
                    );
                  },
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(body: Text("${snapshot.error}"));
        } else {
          if (first) {
            snapshot.data.data.current.weather.ts =
                snapshot.data.data.current.weather.ts.add(Duration(hours: 10));
            first = false;
          }
          return Scaffold(
            floatingActionButton: _speedDial(),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.pexels.com/photos/2931915/pexels-photo-2931915.jpeg?cs=srgb&dl=pexels-darius-krause-2931915.jpg&fm=jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(28, 30, 28, 18),
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            // autovalidate: true,
                            child: Column(
                              children: [
                                TextField(
                                  style: TextStyle(color: Colors.white),
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (value) {
                                    print('Submitted');
                                    print(value);
                                    setState(() {
                                      // kota = value;
                                      // current = fetchWeather(
                                      //     city: kota,
                                      //     state: prov,
                                      //     country: negara,
                                      //     dataTemp: snapshot.data);
                                    });
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(36),
                                    ),
                                    hintText: "Cek udara kotamu! (Khusu)",
                                    hintStyle: TextStyle(color: Colors.white),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 18, 20, 18),
                                    prefixIcon: Padding(
                                      padding:
                                          EdgeInsetsDirectional.only(start: 10),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(36),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(36),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height / 6,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${snapshot.data.data.city}',
                            style: TextStyle(
                              fontFamily: 'Mulish',
                              color: Colors.white,
                              fontSize: 38.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          Text(
                            '${f.format(snapshot.data.data.current.weather.ts)}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 25),
                            child: Image.asset(
                              setImage(snapshot.data.data.current.weather.ic),
                              scale: 1.5,
                            ),
                          ),
                          Text(
                            '${snapshot.data.data.current.weather.tp}°C',
                            style: TextStyle(
                              fontFamily: 'Mulish',
                              color: Colors.white,
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            setWeather(snapshot.data.data.current.weather.ic),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'San Francisco'),
                          ),
                        ],
                      ),
                    ),
                    DraggableScrollableSheet(
                      initialChildSize: 0.25,
                      minChildSize: 0.12,
                      maxChildSize: 1,
                      expand: true,
                      builder: (BuildContext c, s) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(48.0),
                                topRight: Radius.circular(48.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(225, 85, 20, .3),
                                  blurRadius: 20,
                                  // spreadRadius: 10,
                                  offset: Offset(0, 5),
                                )
                              ]),
                          child: ListView(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            controller: s,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  height: 8,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: setColor(snapshot
                                      .data.data.current.pollution.mainus),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          color: setColorDark(snapshot.data.data
                                              .current.pollution.mainus),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        ),
                                        width: 80.0,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Index AQI',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              '${snapshot.data.data.current.pollution.aqius}',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Kualitas Udara'),
                                          Text(
                                            setAqi(snapshot.data.data.current
                                                .pollution.aqius),
                                            style: TextStyle(
                                                fontFamily: 'San Francisco',
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ListTile(
                                  title: Text('Kelembapan'),
                                  trailing: Text(
                                      '${snapshot.data.data.current.weather.hu} %')),
                              ListTile(
                                  title: Text('Angin'),
                                  trailing: Text(
                                      '${snapshot.data.data.current.weather.ws} m/s')),
                              ListTile(
                                  title: Text('Tekanan'),
                                  trailing: Text(
                                      '${snapshot.data.data.current.weather.pr} hPa')),
                              Container(
                                // color: Colors.grey,
                                width: 140,
                                height: 250,
                                child: Card(
                                  color: mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 39,
                                        ),
                                        Text('INI PAKE ENDPOINT CITY',
                                            style: TextStyle(fontSize: 20),
                                            textAlign: TextAlign.center),
                                        // Text(
                                        //     "Location lat : ${_position?.latitude ?? '-'}, \nlon : ${_position?.longitude ?? '-'}"),
                                        // Text(
                                        //     "Alamat dari titik : \n ${_address?.addressLine ?? '-'}"),
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              // image: DecorationImage(
                                              //   // image: AssetImage(
                                              //   //     'assets/images/icon-01.jpg'),
                                              //   fit: BoxFit.cover,
                                              // ),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
