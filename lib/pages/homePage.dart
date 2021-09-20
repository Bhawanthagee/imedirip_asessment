import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:imedirip_asessment/card/carCard.dart';
import 'detailsPage.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String imgUrl(String img_url){
    if (img_url==null){
      img_url = 'assets/images/car.png';
      return img_url;
    }else{
      return img_url;
    }

  }

  Future<List<Car>> fetchCar() async {
    carList = [];
    final response = await http.get(Uri.parse(
        'https://private-anon-b242a842d4-carsapi1.apiary-mock.com/manufacturers'));
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);

      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            carList.add(Car.fromJson(map));
          }
        }
        setState(() {
          carList;
        });
      }

      return carList;
    }else {
      throw Exception('Failed to load cars');
    }


  }
  @override
  void initState() {
    fetchCar();
    Timer.periodic(Duration(seconds: 10), (timer) => fetchCar());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: carList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>DetailsPAge(
                  name: carList[index].name,
                  img_url: carList[index].img_url,
                  avg_price: carList[index].avg_price,
                  num_models:carList[index].num_models,
                  max_car_id: carList[index].max_car_id,
                  avg_horsepower: carList[index].avg_horsepower,


                )),);
              },
              child: CarCard(
                name: carList[index].name,
                img_url: carList[index].img_url,

              ),
            );
          },
        ));

  }
}

class Car {
  Car({
    required this.name,
    required this.id,
    required this.img_url,
    required this.max_car_id,
    required this.num_models,
    required this.avg_price,
    required this.avg_horsepower


  });

  String name;
  int id;
  String img_url;
  int max_car_id;
  int num_models;
  double avg_horsepower;
  double avg_price;





  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
        name: json['name'],
        id: json['id'],
        img_url: json['img_url'],
        max_car_id: json['max_car_id'],
        num_models:json['num_models'],
        avg_price: json['avg_price'],
        avg_horsepower: json['avg_horsepower']


    );
  }
}

List<Car> carList = [];
