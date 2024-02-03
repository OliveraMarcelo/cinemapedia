import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Cargando peliculas',
      'Comprando palomitas de maiz',
      'Cargando populares',
      'Esta tardando mucho no ?',
      'Checkea tu wifi ',
      'El problema es del backend '
    ];
    return Stream.periodic(
      Duration(milliseconds: 1200),
      (computationCount) {
        return messages[computationCount];
      },
    ).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Espere por favor...'),
          SizedBox(
            height: 10,
          ),
          CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('Cargando...');
              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}
