import 'package:about_me/pages/estudiante.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Estudiante> estudiantes = [];

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<String> readJsonFromFireBase() async {
    String url =
        "https://primer-rest-api-729c7-default-rtdb.firebaseio.com/.json";
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  Future loadData() async {
    final String jsonString = await readJsonFromFireBase();
    final dynamic jsonResponse = json.decode(jsonString);
    for (Map<String, dynamic> i in jsonResponse) {
      estudiantes.add(Estudiante.fromJson(i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Estudiantes'),
          backgroundColor: const Color.fromARGB(255, 29, 58, 105),
        ),
        body: FutureBuilder(
            future: readJsonFromFireBase(),
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                return ListView.builder(
                    itemCount: estudiantes == null ? 0 : estudiantes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => StudentInfo(
                                  numControl:
                                      estudiantes[index].numControl.toString(),
                                  nombre:
                                      estudiantes[index].nombre.toString(),
                                  carrera:
                                      estudiantes[index].carrera.toString(),
                                  semestre:
                                      estudiantes[index].semestre.toString(),
                                  telefono:
                                      estudiantes[index].telefono.toString(),
                                  correo:
                                      estudiantes[index].correo.toString())));
                        },
                        title: Text(estudiantes[index].nombre.toString()),
                        subtitle: Text(estudiantes[index].carrera.toString()),
                        leading: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 29, 58, 105),
                            child: Text(estudiantes[index]
                                .nombre
                                .toString()
                                .substring(0, 1))),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      );
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
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

  factory Estudiante.fromJson(Map<String, dynamic> parsedJson) {
    return Estudiante(
        parsedJson['numControl'],
        parsedJson['nombre'],
        parsedJson['carrera'],
        parsedJson['semestre'],
        parsedJson['telefono'],
        parsedJson['correo']);
  }
}
