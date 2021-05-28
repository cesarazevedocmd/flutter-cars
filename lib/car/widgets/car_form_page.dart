import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_project/car/entity/car.dart';
import 'package:car_project/car/manager/car_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarFormPage extends StatefulWidget {
  final Car car;

  CarFormPage({this.car});

  @override
  State<StatefulWidget> createState() => _CarFormPageState();
}

class _CarFormPageState extends State<CarFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final tName = TextEditingController();
  final tDesc = TextEditingController();
  final tType = TextEditingController();

  int _radioIndex = 0;

  var _showProgress = false;

  Car get car => widget.car;

  String _validateName(String value) {
    if (value.isEmpty) {
      return 'Informe o nome do car.';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    if (car != null) {
      tName.text = car.nome;
      tDesc.text = car.descricao;
      _radioIndex = getIntType(car);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(car != null ? car.nome : "Novo Car")),
      body: Container(padding: EdgeInsets.all(16), child: _form()),
    );
  }

  _form() {
    return Form(
      key: this._formKey,
      child: ListView(
        children: <Widget>[
          _headerPhoto(),
          Text(
            "Clique na imagem para tirar uma foto",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Divider(),
          Text(
            "Type",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          _radioType(),
          Divider(),
          TextFormField(
            controller: tName,
            keyboardType: TextInputType.text,
            validator: _validateName,
            style: TextStyle(color: Colors.blue, fontSize: 20),
            decoration: new InputDecoration(
              hintText: '',
              labelText: 'Name',
            ),
          ),
          TextFormField(
            controller: tDesc,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
            decoration: new InputDecoration(
              hintText: '',
              labelText: 'Description',
            ),
          ),
          Container(
            height: 50,
            margin: new EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(),
              child: _showProgress
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      "Save",
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
              onPressed: _onClickSave,
            ),
          )
        ],
      ),
    );
  }

  _headerPhoto() {
    return car != null
        ? CachedNetworkImage(
            imageUrl: car.urlFoto,
          )
        : Image.asset(
            "assets/images/camera.png",
            height: 150,
          );
  }

  _radioType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio(
          value: 0,
          groupValue: _radioIndex,
          onChanged: _onClickType,
        ),
        Text(
          "Classic",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Radio(
          value: 1,
          groupValue: _radioIndex,
          onChanged: _onClickType,
        ),
        Text(
          "Sport",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
        Radio(
          value: 2,
          groupValue: _radioIndex,
          onChanged: _onClickType,
        ),
        Text(
          "Lux",
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
      ],
    );
  }

  void _onClickType(int value) {
    setState(() {
      _radioIndex = value;
    });
  }

  getIntType(Car car) {
    switch (car.tipo) {
      case "classicos":
        return 0;
      case "esportivos":
        return 1;
      default:
        return 2;
    }
  }

  String _getType() {
    switch (_radioIndex) {
      case 0:
        return "classicos";
      case 1:
        return "esportivos";
      default:
        return "luxo";
    }
  }

  _onClickSave() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    // Cria o car
    var carForEdition = car ?? Car();
    carForEdition.nome = tName.text;
    carForEdition.descricao = tDesc.text;
    carForEdition.tipo = _getType();

    print("Car: $carForEdition");

    setState(() {
      _showProgress = true;
    });

    print("Salvar o car $carForEdition");

    await Future.delayed(Duration(seconds: 3));
    //CarDAO().save(carForEdition);

    setState(() {
      _showProgress = false;
    });

    print("Fim.");
  }
}
