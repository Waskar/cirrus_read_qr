import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:cirrus_read_qr/cirrus_read_qr.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Recibir la pagina',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Decodificar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  CirrusReadQr _readqrandroidswift = new CirrusReadQr();
  //ImagePicker _imagePicker = new ImagePicker();


  String _qr = "nada";

  void captureImage(ImageSource captureMode) {
    debugPrint ("aqui sale QR $captureMode");
    CirrusReadQr.pickImage().then((result){
      print("Ya tengo el QR $result");
      setState(() {
        _qr = result.toString();
      });
    });
  }

  /*void captureImageIos(ImageSources captureMode) {
    debugPrint ("aqui sale QR $captureMode");
    _imagePicker.iosPick().then((result){
      print("Ya tengo el QR $result");
      setState(() {
        _qr = result.toString();
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
          children: [
            new Expanded(child: new Center(child: Text(_qr))),
            _buildButtons()
          ]
      ),
    );
  }

  Widget _buildButtons() {
    return new ConstrainedBox(
        constraints: BoxConstraints.expand(height: 80.0),
        child: new Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                key: Key('retake'),
                child: Text('GALERIA'),
                onPressed: (){
                  print("1");
                  captureImage(ImageSource.gallery);
                  //captureImageIos(ImageSources.photos);
                },
              ),
            ]
        ));
  }
}