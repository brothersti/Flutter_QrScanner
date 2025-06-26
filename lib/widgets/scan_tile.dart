import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/services/scans_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanTile extends StatelessWidget {
  final String tipo;

  const ScanTile({Key? key, required this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScansProvider>(context, listen: true);
    final scans = scanProvider.scans;

    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, i) {
          final item = scans[i];
          return Dismissible(
            key: Key(item.id.toString()),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (DismissDirection direction) {
              Provider.of<ScansProvider>(context, listen: false)
                  .borrarScansPorId(scans[i].id!);
            },
            child: ListTile(
              leading: Icon(
                this.tipo == 'http' ? Icons.map_outlined : Icons.home_outlined,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(scans[i].valor!),
              subtitle: Text(scans[i].id.toString()),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: () => launchURL(context, scans[i]),
            ),
          );
        });
  }
}
