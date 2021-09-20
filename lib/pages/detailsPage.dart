import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homePage.dart';

class DetailsPAge extends StatefulWidget {
  String name;
   String img_url;
   int max_car_id;
   int num_models;
   double avg_horsepower;
   double avg_price;

   DetailsPAge({ required this.name, required this.max_car_id, required this.num_models,
  required this.avg_horsepower, required this.avg_price, required this.img_url}) ;



  @override
  _DetailsPAgeState createState() => _DetailsPAgeState();
}

class _DetailsPAgeState extends State<DetailsPAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More Details"),
      ),
      body: Container(
        child: Column(
          children: [
            Text(widget.name.toUpperCase(),style: GoogleFonts.ptSerif(fontSize: 30),),
           Padding(
             padding: const EdgeInsets.only(left:18.0,right: 18,top: 10),
             child: Container(
               height: 250,width: double.infinity,
               decoration: buildBoxDecoration(),
               child: Image(image:  NetworkImage(widget.img_url,),),

             ),

           ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:18.0,right: 18,top: 20),
                  child: Container(
                    //color: Colors.lightBlueAccent,
                    height: 80,width: 160,
                    decoration: buildBoxDecoration(),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child:Image(image: AssetImage('assets/icons/horse.jpg'),) ,
                          ),
                        ),
                        Expanded(child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child:  RichText(
                              text:TextSpan(
                                  //style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'AVG HP:', style: GoogleFonts.rubik(fontSize: 18,color: Colors.red)),
                                    TextSpan(text: ' ${widget.avg_horsepower.toStringAsFixed(2)}',style: GoogleFonts.rubik(color: Colors.black,fontSize: 15))
                                  ]
                              )
                          ),

                          //Text("HP: ${widget.avg_horsepower.toStringAsFixed(3)}"),
                        ))
                      ],
                    )
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.only(left:18.0,right: 18,top: 20),
                  child: Container(
                    //color: Colors.lightBlueAccent,
                      height: 80,width: 160,
                      decoration: buildBoxDecoration(),
                      child: Row(
                        children: [
                          Expanded(
                            flex:1,
                            child: Container(
                              child:Image(image: AssetImage('assets/icons/carIcon.png'),) ,
                            ),
                          ),
                          Expanded(
                              flex:3,
                              child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: RichText(
                                text:TextSpan(
                                  //style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(text: 'No:Of Models: ', style: GoogleFonts.rubik(fontSize: 18,color: Colors.red)),
                                      TextSpan(text: ' ${widget.num_models.toString()}',style: GoogleFonts.rubik(color: Colors.black,fontSize: 15))
                                    ]
                                )
                            ),

                                //Text("No:Of Models: ${widget.num_models.toString()}"),
                          ))
                        ],
                      )
                  ),

                )
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left:80.0,right: 80,top: 20),
              child: Container(
                height: 80,width: double.infinity,
                decoration:buildBoxDecoration() ,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Image(image: AssetImage("assets/icons/dollar.png"),),
                      ),
                    ),
                    Expanded(
                        child: Container(
                          child: RichText(
                              text:TextSpan(
                                //style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(text: 'AVG Price : ', style: GoogleFonts.rubik(fontSize: 18,color: Colors.red)),
                                    TextSpan(text: ' \n\$ ${widget.avg_price.toStringAsFixed(2)}',style: GoogleFonts.rubik(color: Colors.black,fontSize: 15))
                                  ]
                              )
                          ),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
               borderRadius: BorderRadius.circular(10),
               color: Color(0xFFf2f2f2),
               boxShadow: [
                 BoxShadow(
                   color: Colors.grey,
                   offset: Offset(4, 4),
                   blurRadius: 10,
                   spreadRadius: 1,
                 ),
                 BoxShadow(
                   color: Colors.white,
                   offset: Offset(-4, -4),
                   blurRadius: 10,
                   spreadRadius: 1,
                 ),
               ],
             );
  }
}

