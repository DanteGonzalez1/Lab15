import 'package:about_me/pages/estudiante.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Estudiante>> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response) as List<dynamic>;

    return data.map((e) => Estudiante.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Estudiantes'),
          backgroundColor: const Color.fromARGB(255, 29, 58, 105),
        ),
        body: FutureBuilder(
            future: readJson(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                var items = data.data as List<Estudiante>;
                return ListView.builder(
                    itemCount: items == null ? 0 : items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => StudentInfo(
                                  numControl: items[index].numControl.toString(),
                                  nombre: items[index].nombre.toString(),
                                  carrera: items[index].carrera.toString(),
                                  semestre: items[index].semestre.toString(),
                                  telefono: items[index].telefono.toString(),
                                  correo: items[index].correo.toString())));
                        },
                        title: Text(items[index].nombre.toString()),
                        subtitle: Text(items[index].carrera.toString()),
                        leading: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 29, 58, 105),
                            child: Text(items[index]
                                .nombre
                                .toString()
                                .substring(0, 1))),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}

class Estudiante {
  String? numControl;
  String? nombre;
  String? carrera;
  String? semestre;
  String? telefono;
  String? correo;

  Estudiante(this.numControl, this.nombre, this.carrera, this.semestre,
      this.telefono, this.correo);

  Estudiante.fromJson(Map<String, dynamic> json) {
    numControl = json['numControl'];
    nombre = json['nombre'];
    carrera = json['carrera'];
    semestre = json['semestre'];
    telefono = json['telefono'];
    correo = json['correo'];
  }
}
