import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_project/api/api_response.dart';
import 'package:car_project/car/entity/car.dart';
import 'package:car_project/car/manager/car_bloc.dart';
import 'package:car_project/car/widgets/car_video.dart';
import 'package:car_project/favorite/favorite_service.dart';
import 'package:car_project/util/alert.dart';
import 'package:car_project/util/nav.dart';
import 'package:flutter/material.dart';

import 'car_form_page.dart';

class CarDetails extends StatefulWidget {
  Car _car;

  CarDetails(this._car);

  @override
  _CarDetailsState createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  bool _favorite = false;

  Car get car => widget._car;

  @override
  void initState() {
    super.initState();

    FavoriteService.isFavorite(car).then((result) {
      setState(() => _favorite = result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(car.nome),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.place),
          ),
          IconButton(
            onPressed: () => _onClickVideo(context, car),
            icon: Icon(Icons.videocam),
          ),
          PopupMenuButton<String>(
            onSelected: (item) => _onItemSelected(item),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "edit",
                  child: Text("Edit"),
                ),
                PopupMenuItem(
                  value: "delete",
                  child: Text("Delete"),
                ),
                PopupMenuItem(
                  value: "share",
                  child: Text("Share"),
                )
              ];
            },
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
          _getImage(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.nome,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    car.tipo,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite, color: _favorite ? Colors.red : null, size: 40),
                    onPressed: () => _onFavoriteClick(car),
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
              Text(car.descricao, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

  Widget _getImage() {
    if (car.urlFoto == null || car.urlFoto.isEmpty) {
      return Text("Photo is not available");
    }
    return CachedNetworkImage(imageUrl: car.urlFoto, height: 200);
  }

  void _onFavoriteClick(Car car) {
    FavoriteService.setFavorite(car);
    setState(() => _favorite = !_favorite);
  }

  _onItemSelected(String item) {
    switch (item) {
      case "edit":
        push(context, CarFormPage(car: car));
        break;
      case "delete":
        _deleteCar();
        break;
      case "share":
        break;
      default:
        break;
    }
  }

  void _deleteCar() async {
    ApiResponse<bool> response = await CarBloc().delete(car);
    if (response.success && response.result != null) {
      alert(context, "Car deleted with success", callback: () => Navigator.pop(context));
    } else {
      alert(context, response.error);
    }
  }

  _onClickVideo(BuildContext context, Car car) {
    //launch(car.urlVideo);
    push(context, CarVideo(car));
  }
}
