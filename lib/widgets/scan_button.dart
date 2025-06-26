import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/services/scans_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.center_focus_strong),
      onPressed: () async {
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //     '#3D8BEF', 'Cancel', false, ScanMode.QR);

        final barcodeScanRes = 'geo:19.828749,-98.980612';
        //final barcodeScanRes = 'https://youtube.com';

        if (barcodeScanRes == '-1') return;

        final scanProvider = Provider.of<ScansProvider>(context, listen: false);

        final nuevoScan = await scanProvider.nuevoScan(barcodeScanRes);

        launchURL(context, nuevoScan);
      },
    );
  }
}
