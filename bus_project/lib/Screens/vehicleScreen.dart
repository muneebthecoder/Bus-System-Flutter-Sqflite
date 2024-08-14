import 'package:flutter/material.dart';
import 'package:mid_bus_project/Model/vehicle.dart';
import 'package:mid_bus_project/Screens/CustomWidgets.dart';

import '../Model/dbhelper.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});


  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  TextEditingController vmodel=TextEditingController();
  TextEditingController vname=TextEditingController();


  List<Vehicle> vlist=[];
  Future<void> loadDetails()async
  {
    vlist=await DBHandler.instance.getAllVehicles();
    print("LoaD V $vlist");
        setState(() {
      
    });
  }

  

  @override
  void initState()
  {
    super.initState();
      loadDetails();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("VEHICLES"),backgroundColor: Colors.black87,),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black87,
          onPressed: (){
            showDialog(
              context: context, 
              builder: (context){
                return AlertDialog(
                  title: Text('Add New Vehicles'),
                  content: Container(height: 250,width: 300,
                    child: Column(
                      children: [
                        customTextForm(controller: vname, hintText: "Vehicle Name", labelText: 'Name'),
                        SizedBox(height: 10,),
                        customTextForm(controller: vmodel, hintText: "Model", labelText: 'Model'),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: ()async {



              Vehicle veh=Vehicle(
              name: vname.text, 
              model: vmodel.text, );
            int rowid=await  DBHandler.instance.insertVehicle(veh);
            print('rowid $rowid');
            print('ADd $vlist');
            
            Navigator.of(context).pop();
              if(rowid>0){
                showDialog(context: context, 
                builder: (context){
                  return AlertDialog(
                    title: Text('Vehicle Added'),
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
              
                                                         setState(() {
                    vmodel.text="";
                    vname.text="";
                    loadDetails();
      
    });     
                        
                      },
                      child: Text('Add',style: TextStyle(color: Colors.black87),),
                    ),
                  ],
                );
            });
      },child: Icon(Icons.add),),
      body: ListView.builder(
         itemCount: vlist.length,
         itemBuilder:(context,index){
          Vehicle v=vlist[index];
         return Card(
              child: Column(
                children: [
                  ListTile(
                          title: Text(v.name),
                          subtitle: Text(v.model),
                        trailing:IconButton(onPressed: ()async{
                            int r= await DBHandler.instance.deleteVehicle(v.id);
                            if(r>0){
                             vlist.removeAt(index);
                              setState(() {
                                
                              });
                            }
                          }, icon: Icon(Icons.delete)),
// leading: IconButton(onPressed: ()async{

//  showDialog(context: context, 
//                 builder: (context){
//                   return AlertDialog(
//                     title: Text('Edit Driver Info'),
//                     content:Container(height: 350,width: 300,
//                     child: SingleChildScrollView(
//                       child: Column(
//                           children: [
//                             customTextForm(controller: vname, hintText: "Name", labelText: 'Name'),
//                             SizedBox(height: 10,),
//                             customTextForm(controller: vmodel, hintText: "Model", labelText: 'Model'),
//                           ],
//                         ),
//                     ),
                    
//                   ),
//                    actions: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                              showDialog(context: context, 
//                 builder: (context){
//                   return AlertDialog(
//                     title: Text('Vehicle Info Updated'),
//                     icon: Icon(Icons.done),
//                   );
//                 });
//                       },
//                       child: Text('Update',style: TextStyle(color: Colors.black87),),
//                     ),
//                 ],
//                   );
//                 });
//                 v.name=vname.text;
//                 v.model=vmodel.text;


//                             int r= await DBHandler.instance.updateVehical(v);
//                               Navigator.of(context).pop();
//                                                  setState(() {
//                     vname.text="";
//                     vmodel.text="";
      
//     });
           
           



//                           }, icon: Icon(Icons.edit)),











                          onTap: (){
                             showDialog(
                context: context, 
                builder: (context){
                  return AlertDialog(
                    title: Text('Driver Detail'),
                    content: Container(height: 200,width: 200,
                      child: Column(
                        children: [
                          Text("Name "+v.name),
                          SizedBox(height: 10,),
                          Text("Model "+v.model),

                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel',style: TextStyle(color: Colors.black87),),
                      ),
                    ],
                  );
              });
                          },
                        ),
                ],
              ),
            );        }
        ),   
    );
  }
}