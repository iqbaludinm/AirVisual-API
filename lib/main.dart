import 'package:flutter/material.dart';
import 'package:request_api/screen/home.dart';
import 'package:request_api/util/location_service.dart';

Color primaryColorLight = Color(0xFFFBE0E6);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REST API',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class AppKum extends StatefulWidget {
  @override
  _AppKumState createState() => _AppKumState();
}

class _AppKumState extends State<AppKum> {
  LocationService locationService = LocationService();
  double latitude = 0;
  double longitude = 0;

  @override
  void initState() {
    super.initState();
    locationService.locationStream.listen((userLocation) {
      setState(() {
        latitude = userLocation.latitude;
        longitude = userLocation.longitude;
        // current = currentLoc(userLocation.longitude, userLocation.latitude);
      });
    });
  }

  @override
  void dispose() {
    locationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Latitude'),
            Text('$latitude'),
            Text('Longitude'),
            Text('$longitude')
          ],
        ),
      ),
    );
  }
}

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Request API',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.amber,
//       ),
//       home: Home(),
//     );
//   }
// }

/*
class _MyAppState extends State<MyApp> {
  String output = "No Data";
  Specified spesifik = null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Request API'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(output),
              // Text(
              //   (spesifik != null)
              //       ? "City : " +
              //           spesifik.city +
              //           "\n" +
              //           "Country :" +
              //           spesifik.country +
              //           "\n" +
              //           " State : " +
              //           spesifik.state
              //       : "Tidak ada data",
              //   style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              // ),
              SizedBox(
                height: 80.0,
              ),
              RaisedButton(
                onPressed: () {
                  // Specified.getSpecified("California", "USA").then((specified) {
                  //   output = "";
                  //   for (int i = 0; i < specified.length; i++)
                  //     output = output + " [ " + specified[i].city + " ] ";
                  //   setState(() {});
                  // });
                  Specified.connectToAPI("California", "USA").then((value) {
                    spesifik = value;
                    setState(() {});
                  });
                },
                child: Text("GET"),
              )
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   tooltip: 'Increment',
        //   child: Icon(Icons.add),
        // ),
      ),
    );
  }
}

*/
