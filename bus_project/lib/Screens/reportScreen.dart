import 'package:flutter/material.dart';
import 'package:mid_bus_project/Model/expense.dart';

import '../Model/dbhelper.dart';

class ReportExpense extends StatefulWidget {
  const ReportExpense({super.key});


  @override
  State<ReportExpense> createState() => _ReportExpenseState();
}

class _ReportExpenseState extends State<ReportExpense> {
  List<Expense> elist=[];
  Future<void> loadDetails()async
  {
    elist=await DBHandler.instance.getAllExpense();
    print("load e ${elist.length}");
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
      appBar: AppBar(title: Text("BOOKING REPORT"),backgroundColor: Colors.black87,),
            body: ListView.builder(
         itemCount: elist.length,
         itemBuilder:(context,index){
          Expense e=elist[index];
          return Card(
            child: Column(
              children: [
                ListTile(
                        title: Text("Booking Report ${(elist.length)}",),
                        trailing: IconButton(onPressed: ()async{
                            int r= await DBHandler.instance.deleteDriver(e.id);
                            if(r>0){
                             elist.removeAt(index);
                              setState(() {
                                
                              });
                            }

                        }, icon: Icon(Icons.delete)),
                        onTap: (){
                           showDialog(
              context: context, 
              builder: (context){
                return AlertDialog(
                  title: Text('REPORT'),
                  content: Container(height: 300,width: 200,
                    child: Column(
                      children: [
                        Text("Booking No : "+e.id.toString()),
                        SizedBox(height: 10,),
                        Text("Date : "+e.date),
                        SizedBox(height: 10,),
                        Text("Driver Name : "+e.driver),
                        SizedBox(height: 10,),
                        Text("Vehical Name : "+e.vehicle),
                        SizedBox(height: 10,),
                        Text("Expense : "+e.expense),
                        SizedBox(height: 10,),
                        Text("Expense Amount : "+e.e_amount.toString()),
                        SizedBox(height: 10,),
                        Text("Booking Amount : "+e.b_amount.toString()),
                        SizedBox(height: 10,),
                        Text("Departure : "+e.departure),
                        SizedBox(height: 10,),
                        Text("Arrival : "+e.arrival),
                        SizedBox(height: 10,),
                        Text("Profit : ${(e.b_amount-e.e_amount)}"),
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
                        showDialog(context: context, 
                builder: (context){
                  return AlertDialog(
                    title: Text('Printed Succeefully !'),
                    icon: Icon(Icons.done),
                  );
                });
                      },
                      child: Text('Print',style: TextStyle(color: Colors.black87),),
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