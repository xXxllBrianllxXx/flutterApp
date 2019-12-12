import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  FormPage({Key key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  String _nombre = '';
  String _email = '';
  String _date = '';
  String _selectedOption = 'Programación';

  List<String> _courses = ['Matematicas', 'Ingles', 'Español', 'Ciencias', 'Artistica', 'Filosofia', 'Programación'];

  TextEditingController _inputFieldDateControler = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          _createInput(),
          Divider(),
          _createEmail(),
          Divider(),
          _createPass(),
          Divider(),
          _createDate(context),
          Divider(),
          _createSelect(),
          Divider(),
          _writePerson(),
        ],
      ),
    );
  }

  Widget _createInput() {
    return TextField(
      autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        counter: Text('Caracteres ${_nombre.length}'),
        hintText: 'Nombre de la persona',
        labelText: 'Nombre',
        helperText: '* Obligatorio',
        suffixIcon: Icon(Icons.perm_identity),
        icon: Icon(Icons.account_circle)
      ),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
    );
  }


  Widget _createEmail() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        hintText: 'test@test.com',
        labelText: 'Email',
        suffixIcon: Icon(Icons.alternate_email),
        icon: Icon(Icons.email)
      ),
      onChanged: (valor) {
        setState(() {
          _email = valor;
        });
      },
    );
  }

  Widget _createPass() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        hintText: 'Contraseña',
        labelText: 'Contraseña',
        suffixIcon: Icon(Icons.lock_open),
        icon: Icon(Icons.lock)
      ),
    );
  }

  Widget _createDate(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateControler,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        hintText: 'Fecha de nacimiento',
        labelText: 'Fecha de nacimiento',
        suffixIcon: Icon(Icons.perm_contact_calendar),
        icon: Icon(Icons.calendar_today)
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );    
  }

  List<DropdownMenuItem<String>> getOptions() {
    List<DropdownMenuItem<String>> lista = new List();
    _courses.forEach((course){
      lista.add(DropdownMenuItem(
        child: Text(course),
        value: course
      ));
    });
    return lista;
  }

  Widget _createSelect() {

    return Row(
      children: <Widget>[
        Icon(Icons.swap_horizontal_circle),
        SizedBox(width: 30.0,),
        Expanded(
          child: DropdownButton(
            value: _selectedOption,
            items: getOptions(),
            onChanged: (opt) {
              setState(() {
                _selectedOption = opt;
              });
            },
          ),
        )
      ],
    );    
  }
  
  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2015),
      lastDate: new DateTime(2025),
      locale: Locale('es', 'ES')
    );

    if (picked != null) {
      setState(() {
        _date = picked.toString();
        _inputFieldDateControler.text = _date;
      });
    }
  }

  Widget _writePerson() {
    return ListTile(
      title: Text('Nombre = $_nombre'),
      subtitle: Text('$_email'),
      trailing: Text(_selectedOption),
    );
  }
}