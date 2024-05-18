import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(home: MAIN(), debugShowCheckedModeBanner: false,));
  });
}


randomNumber() {
  random(min, max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }
  int Insideindicator = random(2, 7);
  return Insideindicator;
}
bool reactionTimer = false;
bool colorchange = false;
bool startbuttonpressed = false;
bool mainpressed = false;
var elapsedtime = stopstopwatch();
var besttime = 000;


String start = "Start"; String inaction = "Wait"; String ready = "Start";
Timer abc;
int indicator = 0;

var swatch = Stopwatch();
var buttoncolor = Colors.lightBlueAccent;

void colorChange(){
  if (colorchange = true){
    buttoncolor = Colors.black87;
  }
}

void startstopwatch(){
  swatch.start();
}

stopstopwatch(){
  swatch.stop();
  return swatch.elapsedMilliseconds;
}

void resetstopwatch(){
  swatch.reset();
}

class MAIN extends StatefulWidget {
  @override
  _MAINState createState() => _MAINState();
}

class _MAINState extends State<MAIN> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How Fast Are You?", style: TextStyle(color: Colors.black, fontFamily: 'Roboto', fontSize: 22),),
        centerTitle: true,
        backgroundColor: Colors.blue[600],
      ),

      body: Container(
        color: Colors.blue[900],
        padding: EdgeInsets.fromLTRB(10, 2, 10, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(child: Padding(
              padding: const EdgeInsets.only(top:0, bottom: 4.0),
              child: Text("Tap When The Color Changes", style: TextStyle(fontSize: 25, letterSpacing: 1.0, fontWeight: FontWeight.bold, color: Colors.greenAccent),),
            )),
            Text("Best Time: $besttime ms" , style: TextStyle(fontSize: 25, letterSpacing: 2.0, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
            Divider(height: 5, color: Colors.greenAccent,),
            Align(alignment: Alignment.center,
              child: SizedBox( width: (MediaQuery.of(context).size.width) , height: 375,
                child: FloatingActionButton(
                  child: Icon(Icons.timer, size: 150, color: Colors.black,),
                  backgroundColor: buttoncolor,
                  onPressed: (){
                    setState(() {
                      mainpressed = true;
                      startbuttonpressed = false;
                      ready = start;
                      abc.cancel();
                      if (buttoncolor == Colors.deepOrangeAccent){
                        elapsedtime = stopstopwatch()-50;
                        if (elapsedtime>0 && elapsedtime<besttime){
                          besttime = elapsedtime;
                        }

                        if( besttime == 0){
                          besttime = elapsedtime;
                        }
                      }
                    });
                    buttoncolor= Colors.lightBlueAccent;
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),

                  child: Align(alignment: Alignment.bottomLeft, child: SizedBox(height: 50, width: 150, child: Text("  $elapsedtime \n  milliseconds", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.greenAccent),))),
                ),

                SizedBox( width: 100, height:  60,
                  child: RaisedButton(
                    onPressed: (){
                      if (startbuttonpressed == true){
                        return;
                      }
                      resetstopwatch();
                      buttoncolor = Colors.lightBlueAccent;
                      setState(() {
                        indicator = randomNumber();
                        startbuttonpressed = true;
                      });
                      abc = Timer(Duration(seconds: indicator), () {
                        colorchange = true;
                        startstopwatch();
                        reactionTimer = true;
                        setState(() {
                          buttoncolor = Colors.deepOrangeAccent;
                        });

                      });
                      if (startbuttonpressed == true){
                        ready = inaction;
                        mainpressed = false;
                      }
                    },
                    child: Center(child: Text(ready, style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),)),
                    color: Colors.greenAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

