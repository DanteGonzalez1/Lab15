import 'package:flutter/material.dart';

class StudentInfo extends StatefulWidget {
  final String numControl;
  final String nombre;
  final String carrera;
  final String semestre;
  final String telefono;
  final String correo;
  const StudentInfo(
      {Key? key,
      required this.numControl,
      required this.nombre,
      required this.carrera,
      required this.semestre,
      required this.telefono,
      required this.correo})
      : super(key: key);

  @override
  _StudentInfoState createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.nombre),
          backgroundColor: const Color.fromARGB(255, 29, 58, 105),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                CircleAvatar(
                  maxRadius: 40,
                    backgroundColor: const Color.fromARGB(255, 29, 58, 105),
                    child: Text(
                        widget.nombre.substring(0, 1),style: const TextStyle(fontSize: 32))),
                const SizedBox(height: 25),
                Text(widget.nombre,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                Text(widget.numControl,style:const TextStyle(fontSize: 16)),
                const SizedBox(height: 40),
                Text("Carrera: "+ widget.carrera,style: const TextStyle( fontSize: 20)),
                Text("Semestre: "+widget.semestre,style: const TextStyle( fontSize: 20)),
                Text("Telefono: "+widget.telefono,style: const TextStyle( fontSize: 20)),
                Text("Correo: "+widget.correo,style: const TextStyle( fontSize: 20))
              ]),
        ));
  }
}
