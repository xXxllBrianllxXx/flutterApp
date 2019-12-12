import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrPage extends StatefulWidget {
  QrPage({Key key}) : super(key: key);

  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {

  String _scan;
  String _value = '';

  Future _openScan() async {
    _scan = await FlutterBarcodeScanner.scanBarcode('#004297', 'Cancelar', true);

    setState(() {
      _value = _scan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Valor del Scan'),
            Text(_value, style: Theme.of(context).textTheme.display1)
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _openScan,
        tooltip: 'Abrir camara',
        child: Icon(Icons.camera),
      ),      
    );
  }
}