import 'package:calculadora_flutter/contants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  TextEditingController _totalController;
  TextEditingController _tipController;
  TextEditingController _peopleController;

  double _total;
  double _propina;
  double _propPerson;
  double _totalPerson;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _totalController = TextEditingController();
    _tipController = TextEditingController();
    _peopleController = TextEditingController();

    _total = 0;
    _propina = 0;
    _propPerson = 0;
    _totalPerson = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Text('Datos', style: kstyle1),
              _buildTextField(_totalController, 'Total'),
              _buildTextField(_tipController, 'Propina (%)'),
              _buildTextField(_peopleController, '# de personas'),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: _calculate,
                  child: Text('CALCULAR!'),
                ),
              ),
              Text('Resultado', style: kstyle1),
              _buildResults('Propina', '$_propina'),
              _buildResults('Total', '$_total'),
              _buildResults('Propina por persona', '$_propPerson'),
              _buildResults('Total por persona', '$_totalPerson'),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildResults(String title, String subTitle) {
    return Container(
      child: Column(
        children: [
          Text('$title:' ?? '', style: kstyle1),
          Text('\$$subTitle' ?? '', style: kstyle2),
          Divider(
            height: 20,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title ?? '', style: kstyle2),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextField(
            controller: controller,
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  _calculate() {
    if (_tipController.text.isEmpty ||
        _totalController.text.isEmpty ||
        _peopleController.text.isEmpty) return;

    double total = double.parse(_totalController.text);
    double percent = (0.01 * double.parse(_tipController.text));
    int people = int.parse(_peopleController.text);

    _propina = double.parse((total * percent).toStringAsFixed(2));
    _total = double.parse((total + _propina).toStringAsFixed(2));
    _propPerson = double.parse((_propina / people).toStringAsFixed(2));
    _totalPerson =
        double.parse(((total + _propina) / people).toStringAsFixed(2));

    setState(() {});
  }
}
