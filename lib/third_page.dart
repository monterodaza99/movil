import 'package:flutter/material.dart';
import 'second_page.dart';

void main() {
  runApp(TextoEjercicio('', Cliente()));
}

// ignore: must_be_immutable
class TextoEjercicio extends StatefulWidget {
  String vista;
  Cliente cliente;

  TextoEjercicio(this.vista, this.cliente);

  @override
  _TextoEjercicioState createState() => _TextoEjercicioState();
}

class _TextoEjercicioState extends State<TextoEjercicio> {
  TextEditingController controladornombre;
  TextEditingController controladorapellido;
  TextEditingController controladorprofesion;
  TextEditingController controladorfoto;
  DateTime fecha;

  _datepresent() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          fecha = value;
          print(value);
        });
      }
    });
  }

  @override
  void initState() {
    controladornombre = (widget.vista == 'Actualizar')
        ? TextEditingController(text: widget.cliente.nombre)
        : TextEditingController();
    controladorapellido = (widget.vista == 'Actualizar')
        ? TextEditingController(text: widget.cliente.apellido)
        : TextEditingController();
    controladorprofesion = (widget.vista == 'Actualizar')
        ? TextEditingController(text: widget.cliente.profesion)
        : TextEditingController();
    controladorfoto = (widget.vista == 'Actualizar')
        ? TextEditingController(text: widget.cliente.foto)
        : TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      title: 'Parcial Movil',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Registro Del Cliente'),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: controladornombre,
                decoration: InputDecoration(
                    filled: true,
                    labelText: 'Nombres',
                    // suffix: Icon(Icons.access_alarm),
                    suffix: GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                        controladornombre.clear();
                      },
                    )
                    //probar suffix
                    ),
              ),
            ),

            //Apellidos
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: controladorapellido,
                decoration: InputDecoration(
                    filled: true,
                    labelText: 'Apellidos',
                    // suffix: Icon(Icons.access_alarm),
                    suffix: GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                        controladorapellido.clear();
                      },
                    )
                    //probar suffix
                    ),
              ),
            ),
            //profesion
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: controladorprofesion,
                //keyboardType: TextInputType.number, // Probar todos los teclados
                decoration: InputDecoration(
                    filled: true,
                    labelText: 'Profesion',
                    // suffix: Icon(Icons.access_alarm),
                    suffix: GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                        controladorprofesion.clear();
                      },
                    )
                    //probar suffix
                    ),
              ),
            ),

            //foto url
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                controller: controladorfoto,
                decoration: InputDecoration(
                    filled: true,
                    labelText: 'Url',
                    // suffix: Icon(Icons.access_alarm),
                    suffix: GestureDetector(
                      child: Icon(Icons.close),
                      onTap: () {
                        controladorfoto.clear();
                      },
                    )
                    //probar suffix
                    ),
              ),
            ),

            //fecha

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                onPressed: _datepresent,
                child: Text(
                  fecha == null
                      ? 'Seleccionar Fecha'
                      : 'Fecha: ' + widget.cliente.mostrarFecha(fecha),
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),

            // Boton
            ElevatedButton(
              onPressed: () {
                if (controladornombre.text.isNotEmpty &&
                    controladorapellido.text.isNotEmpty &&
                    controladorprofesion.text.isNotEmpty &&
                    controladorfoto.text.isNotEmpty) {
                  widget.cliente.apellido = controladorapellido.text;
                  widget.cliente.nombre = controladornombre.text;
                  widget.cliente.profesion = controladorprofesion.text;
                  widget.cliente.fecha = fecha;
                  widget.cliente.foto = controladorfoto.text;
                  Navigator.pop(context, widget.cliente);
                } else {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text('Error'),
                            content:
                                Text('Hay uno o mas campos vacíos, verificar'),
                          ));
                }
              },
              child: Text('Enviar Datos'),
            ),

            //
          ],
        ),
      ),
    );
  }
}
