# ESC POS Printer for Flutter

Flutter plugin to connect and print on ESC POS Printers.


## Installation

Use this package as a library
1. Depend on it
Add this to your package's pubspec.yaml file:

```` dart
dependencies:
  escposprinter:
    git:
        url: https://github.com/marcusfelix/esc-pos-printer-flutter.git
        ref: master
````

2. Install it
You can install packages from the command line:

with Flutter:
````
$ flutter packages get
````

Alternatively, your editor might support flutter packages get. Check the docs for your editor to learn more.

3. Import it
Now in your Dart code, you can use:

```` dart
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
````


## Example

```` dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:escposprinter/escposprinter.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List devices = [];
  bool connected = false;

  @override
  initState() {
    super.initState();
    _list();
  }

  _list() async {
    List returned;
    try {
      returned = await Escposprinter.getUSBDeviceList;
    } on PlatformException {
      //response = 'Failed to get platform version.';
    }
    setState((){
      devices = returned;
    });
  }

  _connect(int vendor, int product) async {
    bool returned;
    try {
      returned = await Escposprinter.connectPrinter(vendor, product);
    } on PlatformException {
      //response = 'Failed to get platform version.';
    }
    if(returned){
      setState((){
        connected = true;
      });
    }
  }

  _print() async {
    try {
      await Escposprinter.printText("Testing ESC POS printer...");
    } on PlatformException {
      //response = 'Failed to get platform version.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('ESC POS'),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.refresh), 
              onPressed: () {
                _list();
              }
            ),
            connected == true ? new IconButton(
              icon: new Icon(Icons.print), 
              onPressed: () {
                _print();
              }
            ) : new Container(),
          ],
        ),
        body: devices.length > 0 ? new ListView(
          scrollDirection: Axis.vertical,
          children: _buildList(devices),
        ) : null,
      ),
    );
  }

  List<Widget> _buildList(List devices){
    return devices.map((device) => new ListTile(
      onTap: () {
        _connect(int.parse(device['vendorid']), int.parse(device['productid']));
      },
      leading: new Icon(Icons.usb),
      title: new Text(device['manufacturer'] + " " + device['product']),
      subtitle: new Text(device['vendorid'] + " " + device['productid']),
    )).toList();
  }
}

````
