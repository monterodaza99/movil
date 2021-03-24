import 'package:flutter/material.dart';
import 'third_page.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

// para la fecha
class BasicDateField extends StatelessWidget {
  BasicDateField(this.fecha);
  DateTime fecha;
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(
          filled: true,
          labelText: 'Fecha',
        ),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.username}) : super(key: key);

  final String username;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Cliente> _clientes = [
    Cliente(
        nombre: 'Jesus',
        apellido: 'Montero',
        profesion: 'Ing Sistemas',
        fecha: DateTime(2020, 5, 1),
        foto:'https://thumbs.dreamstime.com/z/historieta-del-perfil-hombre-135443492.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
        actions: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(widget.username)])
        ],
      ),
      body: ListView.builder(
          itemCount: _clientes.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                actualizarCliente(context, _clientes[index], index);
              },
              onLongPress: () {
                setState(() {
                  _eliminarcliente(context, _clientes[index]);
                });
              },
              title: Text(
                  _clientes[index].nombre + ' ' + _clientes[index].apellido),
              subtitle: Text(_clientes[index].profesion),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  _clientes[index].foto,
                ),
              ),

              trailing: SizedBox(
              child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    _clientes[index].mostrarFecha(_clientes[index].fecha),
                  ),
                  Text(
                    _clientes[index].calcularEdad(),
                  ),
                ]),
              ),
            ),
            );
          }),

      //Paso # 1
      //Este es el Boton Adicionar
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TextoEjercicio(
                  "adicionar", Cliente()), //Llamar la Vista TextoEjercicio
            ),
          ).then((resultado) //Espera por un Resultado
              {
            _clientes.add(
                resultado); //Adiciona a la lista lo que recupera de la vista TextoEjercicio
            setState(() {});
          });
        },
        tooltip: 'Adicionar Cliente',
        child: Icon(Icons.add),
      ),

      //
    );
  }

  actualizarCliente(context, Cliente clienteAntiguo, int index) async {
    final clienteNuevo = await Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => TextoEjercicio('Actualizar', clienteAntiguo)),
    ) as Cliente;
    setState(() {
      this._clientes.elementAt(index).nombre = clienteNuevo.nombre;
      this._clientes.elementAt(index).apellido = clienteNuevo.apellido;
      this._clientes.elementAt(index).profesion = clienteNuevo.profesion;
      this._clientes.elementAt(index).foto = clienteNuevo.foto;
    });
  }

  _eliminarcliente(context, Cliente climsg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Eliminar Cliente'),
        content: Text('Esta Seguro de Eliminar a' + climsg.nombre + '?'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                this._clientes.remove(climsg);
                Navigator.pop(context);
              });
            },
            child: Text(
              'Eliminar',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

class Cliente {
  var nombre;
  var apellido;
  var profesion;
  DateTime fecha;
  var foto;

  Cliente({this.nombre, this.apellido, this.profesion, this.fecha, this.foto});

  String mostrarFecha(DateTime fecha) {
    return fecha.day.toString() +
        '/' +
        fecha.month.toString() +
        '/' +
        fecha.year.toString() +
        '\n';
  }

  String calcularEdad() {
    double edad = DateTime.now().difference(this.fecha).inDays / 365;
    return edad.toInt().toString();
  }
}
