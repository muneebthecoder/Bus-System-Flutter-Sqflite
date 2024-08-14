import 'package:flutter/material.dart';
import 'package:mid_bus_project/Model/booking.dart';
import 'package:mid_bus_project/Model/expense.dart';
import '../Model/dbhelper.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
    TextEditingController beExpence=TextEditingController();
  TextEditingController beamount=TextEditingController();

  List<Booking> blist=[];
  Future<void> loadDetails()async
  {
    blist=await DBHandler.instance.getAllBooking();
    print("load B ${blist.length}");
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
      appBar: AppBar(title: Text("BOOKING"),backgroundColor: Colors.black87,),
      body: ListView.builder(
         itemCount: blist.length,
         itemBuilder:(context,index){
          Booking b=blist[index];
          return Card(
            child: Column(
              children: [
                ListTile(
                        title: Text("Booking No ${(blist.length)}",),
                        subtitle: Text(b.departure+" To "+b.arrival),
                        trailing: IconButton(onPressed: ()async {
                            int r= await DBHandler.instance.deleteDriver(b.id);
                            if(r>0){
                             blist.removeAt(index);
                              setState(() {
                                
                              });
                            }


                        }, icon: Icon(Icons.delete)),
                        onTap: (){
                           showDialog(
              context: context, 
              builder: (context){
                return AlertDialog(
                  title: Text('Booking Detail'),
                  content: Container(height: 280,width: 200,
                    child: Column(
                      children: [
                       Text("Booking No : "+b.id.toString()),
                        SizedBox(height: 10,),
                        Text("Date : "+b.date),
                        SizedBox(height: 10,),
                        Text("Driver Name : "+b.driver),
                        SizedBox(height: 10,),
                        Text("Vehical Name : "+b.vehicle),
                        SizedBox(height: 10,),
                        Text("Amount : "+b.amount.toString()),
                        SizedBox(height: 10,),
                        Text("Departure : "+b.departure),
                        SizedBox(height: 10,),
                        Text("Arrival : "+b.arrival),
                        SizedBox(height: 10,),
                        
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK',style: TextStyle(color: Colors.black87),),
                    ),
                                        TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        showDialog(
              context: context, 
              builder: (context){
                return AlertDialog(
                  title: Text('Add Expense'),
                  content: Container(height: 200,width: 200,
                    child: Column(
                      children: [
                            TextFormField(controller: beExpence,                       
                               decoration: InputDecoration(
                                 hintText: "Expense",
                                 labelText: "Expense",
                                 border: OutlineInputBorder(),
                             ),
                            ),
                        SizedBox(height: 10,),
                           TextFormField(controller: beamount, 
                            keyboardType: TextInputType.number,                        
                               decoration: InputDecoration(
                                 hintText: "Amount",
                                 labelText: "Amount",
                                 border: OutlineInputBorder(),
                             ),
                            ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: ()async {
              Expense ex=Expense(
              date: b.date, 
              driver: b.driver,
              vehicle: b.vehicle,
              departure:b.departure,
              arrival: b.arrival,
              b_amount: b.amount,
              e_amount: int.parse(beamount.text),
              expense: beExpence.text,
              );
            int rowid=await  DBHandler.instance.insertExpense(ex);
            print('rowid $rowid');
            
            Navigator.of(context).pop();
              if(rowid>0){
                showDialog(context: context, 
                builder: (context){
                  return AlertDialog(
                    title: Text('Expense Added'),
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
                      },
                      child: Text('Add Expense',style: TextStyle(color: Colors.black87),),
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