import 'package:flutter/material.dart';
import 'package:mid_bus_project/Model/dbhelper.dart';
import 'package:mid_bus_project/Screens/CustomWidgets.dart';
import 'package:mid_bus_project/Screens/bookingScreen.dart';
import 'package:intl/intl.dart';
import 'package:mid_bus_project/Screens/driverScreen.dart';
import 'package:mid_bus_project/Screens/reportScreen.dart';
import 'package:mid_bus_project/Screens/vehicleScreen.dart';

import '../Model/booking.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  TextEditingController bvehicle=TextEditingController();
  TextEditingController bdriver=TextEditingController();
  TextEditingController bamount=TextEditingController();
  DateTime bbdate=DateTime.now();
  
  
  List<String> sdlist=["Select Driver"];
  String selectedDriver="Select Driver";

  List<String> svlist=["Select Vehicle"];
  String selectedVehicel="Select Vehicle";

  List<String> sdeplist=["Departure","RAWALPINDI","LAHORE","SAILKOT","KARACHI","MULTAN","ISLAMABAD","PESHAWAR","QUEETA","KASHMIR"];
  String selectedDeparture="Departure";

  List<String> sarlist=["Arrival","RAWALPINDI","LAHORE","SAILKOT","KARACHI","MULTAN","ISLAMABAD","PESHAWAR","QUEETA","KASHMIR"];
  String selectedArrival="Arrival";







  Future<void> loadDetailsHome()async
  {
    List<String> divName=await DBHandler.instance.getDriverName();
    List<String> vehName=await DBHandler.instance.getVehicleName();
    sdlist.addAll(divName);
    svlist.addAll(vehName);
    print("List dn ${sdlist.length}");
    print("List vn ${svlist.length}");
    setState(() {
    
    });
  }

  @override
  void initState()
  {
    super.initState();
      loadDetailsHome();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("MENU"),backgroundColor: Colors.black87,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            customMenuButton(onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder:(context){
                            return DriverScreen();
                          }));
            }, txt: "Drivers"),
            SizedBox(height: 20,),
            customMenuButton(onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder:(context){
                            return VehicleScreen();
                          }));
            }, txt: "Vehicles"),
            SizedBox(height: 20,),
            customMenuButton(onTap: (){
          // setState(() {
          //   loadDetails();
          // });
                
              
                          showDialog(
              context: context, 
              builder: (context){
                return AlertDialog(
                  title: Text('Add New Booking'),
                  content: StatefulBuilder(
                    builder: (context,setstate){
                      return Container(height: 370,width: 350,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(children: [                        
                               InkWell(
                                onTap: () {
                                showDatePicker(context: context, 
                                initialDate: DateTime.now(), 
                                firstDate: DateTime(1900), 
                                lastDate: DateTime(2100)).then((value){
                                  setstate(() { 
                                    bbdate=value!;
                                    print(bbdate.toString());
                                    
                                    
                                    });});                 
                            },
                            child:Ink(
                                     decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(13),
                                     color: Colors.black87,
                                     ),
                                     child: Container(height: 35,width: 100,
                                         alignment: Alignment.center,
                                      child: Text("Select Date",style: TextStyle(color: Colors.white),),
                                      ),),
                            ),SizedBox(width: 5,),
                            Icon(Icons.calendar_month_outlined),
                            Text(" "+ DateFormat('yyyy-MM-dd').format(bbdate)),
                            ],),
                            SizedBox(height: 10,),
                            DropdownButton(
                              value: selectedDriver,
                              items:sdlist.map((e) =>
                              DropdownMenuItem(
                                value: e,
                                child: Text(e))
                                ).toList(), onChanged:(value)async{
                                  setstate((){selectedDriver=value!;});
                                  
                                  print(sdlist);
                                  
                                 }
                                 ),
                            SizedBox(height: 10,),
                            DropdownButton(
                              value: selectedVehicel,
                              items:svlist.map((e) =>
                              DropdownMenuItem(
                                value: e,
                                child: Text(e))
                                ).toList(), onChanged: (value)async{
                                  setstate((){selectedVehicel=value!;});
                                  
                      
                                 }
                                 ),
                            SizedBox(height: 10,),
                            DropdownButton(
                              value: selectedDeparture,
                              items:sdeplist.map((e) =>
                              DropdownMenuItem(
                                value: e,
                                child: Text(e))
                                ).toList(), onChanged: (value)async{
                                  setstate((){selectedDeparture=value!;});
                                 }
                                 ),
                            SizedBox(height: 10,),
                             DropdownButton(
                              value: selectedArrival,
                              items:sarlist.map((e) =>
                              DropdownMenuItem(
                                value: e,
                                child: Text(e))
                                ).toList(), onChanged: (value)async{
                                  setstate((){selectedArrival=value!;});
                                 }
                                 ),
                            SizedBox(height: 10,),
                            TextFormField(controller: bamount, 
                            keyboardType: TextInputType.number,                        
                               decoration: InputDecoration(
                                 hintText: "Ticket Amount",
                                 labelText: "Ticket Amount",
                                 border: OutlineInputBorder(),
                             ),
                            ),
                          ],
                        ),
                      ),
                    );

                    },

                     
                  ),
                  actions: [
                    TextButton(
                      onPressed: ()async {
            Booking b=Booking(
              date: DateFormat('yyyy-MM-dd').format(bbdate), 
              driver: selectedDriver,
              vehicle: selectedVehicel,
              departure:selectedDeparture,
              arrival: selectedArrival,
              amount: int.parse(bamount.text));
            int rowid=await  DBHandler.instance.insertBooking(b);
            print('rowid $rowid');
            
            Navigator.of(context).pop();
              if(rowid>0){
                showDialog(context: context, 
                builder: (context){
                  return AlertDialog(
                    title: Text('Booking Added'),
                    icon: Icon(Icons.done),
                  );
                });

              }
              else{
                 showDialog(context: context, 
                builder: (context){
                  return AlertDialog(
                    title: Text('Failed'),
                    icon: Icon(Icons.cancel),
                  );
                });
              }
                      },
                      child: Text('Add',style: TextStyle(color: Colors.black87),),
                    ),
                  ],
                );
            });
                 



            }, txt: "Booking"),
            SizedBox(height: 20,),
            customMenuButton(onTap: (){
                 Navigator.of(context).push(MaterialPageRoute(builder:(context){
                            return BookingScreen();
                          }));
            }, txt: "Booking Expense"),
            SizedBox(height: 20,),
            customMenuButton(onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder:(context){
                            return ReportExpense();
                          }));
            }, txt: "Report"),
          ],
        ),
      ),

    );
  }
}