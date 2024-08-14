import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mid_bus_project/Model/dbhelper.dart';
import 'package:mid_bus_project/Model/driver.dart';
import 'package:mid_bus_project/Screens/CustomWidgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});
  @override
  State<DriverScreen> createState() => _DriverScreenState();
}
class _DriverScreenState extends State<DriverScreen> {
  TextEditingController dname=TextEditingController();
  TextEditingController dage=TextEditingController();
  TextEditingController dcontactNumber=TextEditingController();
  TextEditingController dsalary=TextEditingController();
  XFile? img;


  List<Driver> dlist=[];
  Future<void> loaddDetails()async
  {
    dlist=await DBHandler.instance.getAllDrivers();
    print("load d ${dlist.length}");
    setState(() {
      
    });
  }
  Future<String> encodeImage(XFile? image) async {
    var bytes = await image!.readAsBytes();
    String imgStr = base64Encode(bytes);
    return imgStr;
  }

  @override
  void initState()
  {
    super.initState();
      loaddDetails();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Drivers"),backgroundColor: Colors.black87,),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black87,
          onPressed: (){
            showDialog(
              context: context, 
              builder: (context){
                return AlertDialog(
                  title: Text('Add New Driver'),
                  content:StatefulBuilder(
                       builder: (context,setstate){
                   return Container(height: 350,width: 300,
                    child: SingleChildScrollView(
                      child: Column(
                          children: [
                            customTextForm(controller: dname, hintText: "Name", labelText: 'Name'),
                            SizedBox(height: 10,),
                                TextFormField(controller: dage , 
                            keyboardType: TextInputType.number,                                                 
                               decoration: InputDecoration(
                                 hintText: "Age",
                                 labelText: "Age",
                                 border: OutlineInputBorder(),
                             ),
                            ),
                            SizedBox(height: 10,),
                          TextFormField(controller: dcontactNumber, 
                            keyboardType: TextInputType.number,                
                               decoration: InputDecoration(
                                 hintText: "Contact Number",
                                 labelText: "Contact Number",
                                 border: OutlineInputBorder(),
                             ),
                            ),
                            SizedBox(height: 10,),
                                TextFormField(controller: dsalary, 
                            keyboardType: TextInputType.number,                 
                               decoration: InputDecoration(
                                 hintText: "Salary",
                                 labelText: "Salary",
                                 border: OutlineInputBorder(),
                             ),
                            ),

                            SizedBox(width: 10,),
               ElevatedButton(onPressed: ()async{
                 img=await ImagePicker().pickImage(source: ImageSource.gallery);
               setstate(() {
                 
               });
              }, child: Text('Upload Image')),
              SizedBox(height: 10,),
          img==null?Text(''):Image.file(File(img!.path),height: 100,width: 100)

                          ],
                        ),
                    ),
                    
                  );},),
                  actions: [
                    TextButton(
                      onPressed: ()async {
                        String im=await encodeImage(img); 
                               
               Driver div=Driver(
               name: dname.text, 
               age:int.parse(dage.text), 
               contactNumber: dcontactNumber.text,
               image: im,
               salary: int.parse(dsalary.text));
              int rowid=await  DBHandler.instance.insertDriver(div);
             Navigator.of(context).pop();
              if(rowid>0){
                showDialog(context: context, 
                builder: (context){
                  return AlertDialog(
                    title: Text('Driver Added'),
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
                    dage.text="";
                    dcontactNumber.text="";
                    dsalary.text="";
                    dname.text="";
                    loaddDetails();    
    });
                      },
                      child: Text('Add',style: TextStyle(color: Colors.black87),),
                    ),
                  ],
                );
            });
      },child: Icon(Icons.add),),


      body:ListView.builder(
           itemCount: dlist.length,
           itemBuilder:(context,index){
            Driver d=dlist[index];
            return Card(
              child: Column(
                children: [
                  ListTile(
                          title: Text(d.name),
                          subtitle: Text(d.contactNumber),
                          trailing:IconButton(onPressed: ()async{
                            int r= await DBHandler.instance.deleteDriver(d.id);
                            if(r>0){
                             dlist.removeAt(index);
                              setState(() {
                                
                              });
                            }
                          }, icon: Icon(Icons.delete)),
                          leading: IconButton(onPressed: ()async{

 showDialog(context: context, 
                builder: (context){
                  return AlertDialog(
                    title: Text('Edit Driver Info'),
                    content:Container(height: 350,width: 300,
                    child: SingleChildScrollView(
                      child: Column(
                          children: [
                            customTextForm(controller: dname, hintText: "Name", labelText: 'Name'),
                            SizedBox(height: 10,),
                           TextFormField(controller: dage , 
                            keyboardType: TextInputType.number,                       
                               decoration: InputDecoration(
                                 hintText: "Age",
                                 labelText: "Age",
                                 border: OutlineInputBorder(),
                             ),
                            ),
                            SizedBox(height: 10,),
                               TextFormField(controller: dcontactNumber, 
                            keyboardType: TextInputType.number,                      
                               decoration: InputDecoration(
                                 hintText: "Contact Number",
                                 labelText: "Contact Number",
                                 border: OutlineInputBorder(),
                             ),
                            ),
                            SizedBox(height: 10,),
                             TextFormField(controller: dsalary, 
                            keyboardType: TextInputType.number,                     
                               decoration: InputDecoration(
                                 hintText: "Salary",
                                 labelText: "Salary",
                                 border: OutlineInputBorder(),
                             ),
                            ),
                          ],
                        ),
                    ),
                    
                  ),
                   actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                             showDialog(context: context, 
                builder: (context){
                  return AlertDialog(
                    title: Text('Driver  Info Updated'),
                    icon: Icon(Icons.done),
                  );
                });
                setState(() {
                  loaddDetails();
                });
                      },
                      child: Text('Update',style: TextStyle(color: Colors.black87),),
                    ),
                ],
                  );
                });
                d.name=dname.text;
                d.age=int.parse(dage.text);
                d.salary=int.parse(dsalary.text);
                d.contactNumber=dcontactNumber.text;


                            int r= await DBHandler.instance.updateDriver(d);
                              Navigator.of(context).pop();
                                                 setState(() {
                    dage.text="";
                    dcontactNumber.text="";
                    dsalary.text="";
                    dname.text="";
                    loaddDetails();
      
    });
           
           

                          }, icon: Icon(Icons.edit)),

                          onTap: (){

                             showDialog(
                context: context, 
                builder: (context){
                  return AlertDialog(
                    title: Text('Driver Detail'),
                    content: Container(height: 240,width: 200,
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Image.memory(base64Decode(d.image),height: 100,width: 100),
                          Text("Name "+d.name),
                          SizedBox(height: 10,),
                          Text("Age "+d.age.toString()),
                          SizedBox(height: 10,),
                          Text("Contact Number "+d.contactNumber),
                          SizedBox(height: 10,),
                          Text("Salary "+d.salary.toString()),
                          SizedBox(height: 10,),
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
            );
          }
      ),   
    );
  }
}