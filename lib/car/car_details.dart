import 'package:car_project/car/car.dart';
import 'package:car_project/util/prefs.dart';
import 'package:flutter/material.dart';

import 'car_details_options_menu.dart';

class CarDetails extends StatefulWidget {
  Car _car;

  CarDetails(this._car);

  @override
  _CarDetailsState createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  bool _favorite = false;

  @override
  void initState() {
    super.initState();

    Prefs.getBool("favorite_car_${widget._car.id}").then((result) {
      setState(() => _favorite = result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._car.nome),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.place),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.videocam),
          ),
          PopupMenuButton<MyPopupMenuItem>(
            onSelected: (item) => item.performClick(),
            itemBuilder: (context) => MyPopupMenuItem.getPopupOptions(),
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          Image.network(widget._car.urlFoto),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget._car.nome,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget._car.tipo,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite, color: _favorite ? Colors.red : null, size: 40),
                    onPressed: () => _onFavoriteClick(),
                  ),
                  IconButton(
                    icon: Icon(Icons.share, color: Colors.blueGrey, size: 40),
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(widget._car.descricao, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                  "Lorem ipsum condimentum elementum quisque etiam orci himenaeos ligula ut torquent proin ultrices, dapibus inceptos vel ut diam quisque elit nam neque mauris id elementum tellus, ut fermentum ultricies rhoncus curabitur etiam sapien auctor rhoncus quis senectus. aenean augue porta ad ante hac mauris, vitae a curabitur eros sodales curabitur, urna vel massa mauris semper. id varius quis massa eros eget euismod commodo, per duis eget auctor egestas porttitor, nisi duis elit ad fringilla cras. placerat dapibus hac nec fusce dui phasellus eu congue tortor, sit massa lacinia fames lobortis egestas duis hac orci, vivamus erat vitae eleifend non duis risus pellentesque."
                  "Tempor taciti ultricies erat class vulputate augue, quisque duis id lacinia diam ut sit, facilisis conubia nulla nisl lacinia. sociosqu litora torquent porta elit volutpat, quis a elit praesent porttitor inceptos, aenean ut donec mauris. malesuada dolor tellus aliquam hendrerit etiam metus egestas etiam odio vehicula, etiam sem mollis metus urna bibendum nec leo justo diam proin, potenti ligula sit fames adipiscing massa viverra himenaeos ante. eros imperdiet sed sem phasellus tempus non id vitae, urna feugiat quis ante mollis mattis sapien sodales congue, fusce euismod purus orci at euismod et."
                  "Nisl sociosqu nostra torquent pretium leo integer habitant nibh quisque, nam vestibulum nisi faucibus phasellus purus donec ornare auctor, leo auctor ultrices placerat felis maecenas nullam tincidunt. sem quisque neque velit posuere sociosqu quam aenean orci aliquet sed, conubia tellus potenti commodo aenean lobortis eros tellus conubia. nisl facilisis vivamus blandit commodo curae mauris consequat sapien platea duis, purus sodales purus torquent congue hac massa luctus enim tortor, metus cursus rhoncus arcu turpis platea netus tincidunt a. cursus nec neque vehicula lobortis vel congue dolor, non quisque mi ante fermentum accumsan."
                  "Morbi dictum orci nullam fames quisque at tempor proin pretium, tincidunt vulputate potenti ad luctus enim dictumst enim quam, praesent ullamcorper metus orci morbi eget lacinia a. primis lacus venenatis condimentum inceptos habitasse dolor gravida fermentum adipiscing nisi convallis himenaeos porta blandit, id donec platea eget feugiat aliquet donec blandit aenean mauris magna quam maecenas. dictumst amet congue est tempus morbi etiam sollicitudin pellentesque, ut ultricies leo pellentesque et dolor nulla eros dapibus, donec commodo eros per hendrerit quisque egestas. donec magna ullamcorper placerat integer quisque aptent etiam nostra habitant, eget nisl a vestibulum placerat rutrum amet leo, curabitur euismod massa gravida mattis sem est quisque")
            ],
          )
        ],
      ),
    );
  }

  void _onFavoriteClick() {
    Prefs.setBool("favorite_car_${widget._car.id}", !_favorite);
    setState(() => _favorite = !_favorite);
  }
}
