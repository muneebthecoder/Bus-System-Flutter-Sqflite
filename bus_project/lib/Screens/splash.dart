import 'package:flutter/material.dart';
import 'package:mid_bus_project/Screens/barScreen.dart';

void main(){
 runApp(MaterialApp(
  debugShowCheckedModeBanner:false,
  home: Splash(),
  theme: ThemeData(primarySwatch: Colors.blueGrey,),

  ));
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("WELCOME")),backgroundColor: Colors.black87),
      body:SingleChildScrollView(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Text("BUS SYSTEM",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,)),
            SizedBox(height: 50,),
            Center(
              child: InkWell(onTap: (){        
                   Navigator.of(context).push(MaterialPageRoute(builder:(context){
                            return BarScreen();
                          }));
                          },
                     child:CircleAvatar(backgroundImage: AssetImage('assets/images/bus.jpg'),radius: 200),            
                     )
            ),
          ],
        ),
      ),
    );
  
  }
}