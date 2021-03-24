import 'package:flutter/material.dart';
import 'package:form_login_app/widgets/button.dart';
import 'package:form_login_app/widgets/my_form_text_field.dart';
import 'second_page.dart';

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyFormState();

  }
}

class FormModel {
  String emailAddress;
  String password;
  FormModel({this.emailAddress, this.password});
}

class MyFormState extends State<MyForm> {
  // email RegExp
  /*final _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");*/

  // uniquely identifies a Form
  final _formKey = GlobalKey<FormState>();

  // holds the form data for access
  final model = FormModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(20.0),
        width: double.infinity,
        child: ListView(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 540,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  MyFormTextField(
                    isObscure: false,
                    decoration: InputDecoration(
                      labelText: "Usuario",
                      hintText: " ",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Por favor introduzca un usuario';
                      } 
                      
                      return null;
                    },
                    onSaved: (value) {
                      model.emailAddress = value;
                    },
                  ),
                  MyFormTextField(
                    isObscure: true,
                    decoration: InputDecoration(labelText: "Contraseña"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Por favor ingrese una contraseña';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      model.password = value;
                    },
                  ),
                  FormSubmitButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        print(model);

                        Scaffold.of(_formKey.currentContext).showSnackBar(
                            SnackBar(content: Text('')));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(username: model.emailAddress)),
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
