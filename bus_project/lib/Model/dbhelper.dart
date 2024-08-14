import 'package:mid_bus_project/Model/booking.dart';
import 'package:mid_bus_project/Model/driver.dart';
import 'package:mid_bus_project/Model/expense.dart';
import 'package:mid_bus_project/Model/vehicle.dart';
import 'package:sqflite/sqflite.dart';

class DBHandler
{
  DBHandler._privateConstructor();
  Database? _database;
  static DBHandler instance=DBHandler._privateConstructor();
  Future<Database> get database async{
    _database ??= await initializeDatabase();
    return _database!;
  }
  Future<Database> initializeDatabase() async
  {
        String dbpath=await  getDatabasesPath();
        dbpath=dbpath+"/Bus.db";
      Database db  =await openDatabase(
        dbpath,version: 1,
        onCreate: _createDB
      );
      return db;
  }
   _createDB(Database db,int v)async
  {
    String query='''
                 create table Driver(
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    name TEXT,
                    age INTEGER,
                    contactNumber TEXT,
                    image TEXT,
                    salary INTEGER
                   )''';
                  await db.execute(query);
               query='''  create table Vehicle(
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    name TEXT,
                    model TEXT
                  )''';
                  await db.execute(query);
              query='''  create table Booking(
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    date TEXT,
                    vehicle TEXT,
                    driver TEXT,
                    departure TEXT,
                    arrival TEXT,                    
                    amount INTEGER
                  )''';
                  db.execute(query);
                query='''create table Expense(
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    date TEXT,
                    vehicle TEXT,
                    driver TEXT,
                    departure TEXT,
                    arrival TEXT,                    
                    b_amount INTEGER,
                    e_amount INTEGER,
                    expense Text
                  )
                 ''';
                await db.execute(query);

  }
  //Driver
  Future<int> insertDriver(Driver div) async
  {
    Database db=await database;
    int rowid=await db.insert('Driver', div.toMap());
    return rowid;
  }
  Future<List<Driver>> getAllDrivers()async
  {
    Database db=await database;
    List<Map<String,dynamic>> rows= await db.query('Driver');
    List<Driver> divlist= rows.map((e) => 
     Driver(id: e["id"], 
     name: e["name"], 
     age: e["age"], 
     contactNumber: e["contactNumber"],
     image: e["image"], 
     salary: e["salary"])
    ).toList();
    return divlist; 
 }
 Future<List<String>> getDriverName()async
 {
      Database db=await database;
    List<Map<String,dynamic>> rows=await
      db.query('Driver',columns: ["name"]);
      return  rows.map((e) => e["name"].toString()).toList();

 }
 Future<int> deleteDriver(int id)async{
  Database db=await database;
 return await  db.delete('Driver',where: 'id=?',whereArgs: [id]);
 }
Future<int> updateDriver(Driver s) async {
    Database db = await database;
    int r = await db.update('Driver', s.toMap(),
        where: "id=?", whereArgs: [s.id]);
    return r;
  }

 //Vehicle
 Future<int> insertVehicle(Vehicle veh) async
  {
    Database db=await database;
    int rowid=await db.insert('Vehicle', veh.toMap());
    return rowid;
  }
  Future<List<Vehicle>> getAllVehicles()async
  {
    Database db=await database;
   List<Map<String,dynamic>> rows= await db.query('Vehicle');
    List<Vehicle> divlist= rows.map((e) => 
     Vehicle(id: e["id"], 
     name: e["name"], 
     model: e["model"])
    ).toList();
    return divlist; 
 }
 Future<List<String>> getVehicleName()async
 {
      Database db=await database;
    List<Map<String,dynamic>> rows=await
      db.query('Vehicle',columns: ["name"]);
      return  rows.map((e) => e["name"].toString()).toList();
 }
 Future<int> deleteVehicle(int id)async{
  Database db=await database;
 return await  db.delete('Vehicle',where: 'id=?',whereArgs: [id]);
 }
Future<int> updateVehical(Vehicle s) async {
    Database db = await database;
    int r = await db.update('Vehicle', s.toMap(),
        where: "id=?", whereArgs: [s.id]);
    return r;
  }


 //Booking
 Future<int> insertBooking(Booking div) async
  {
    Database db=await database;
    int rowid=await db.insert('Booking', div.toMap());
    return rowid;
  }
  Future<List<Booking>> getAllBooking()async
  {
    Database db=await database;
   List<Map<String,dynamic>> rows= await db.query('Booking');
    List<Booking> divlist= rows.map((e) => 
     Booking(id: e["id"], 
     date: e["date"], 
     vehicle: e["vehicle"], 
     driver: e["driver"], 
     departure: e["departure"],
     arrival: e["arrival"],
     amount: e["amount"],
     )
    ).toList();
    return divlist; 
 }
 Future<int> deleteBooking(int id)async{
  Database db=await database;
 return await  db.delete('Booking',where: 'id=?',whereArgs: [id]);
 }

 //Expense
 Future<int> insertExpense(Expense div) async
  {
    Database db=await database;
    int rowid=await db.insert('Expense', div.toMap());
    return rowid;
  }
  Future<List<Expense>> getAllExpense()async
  {
    Database db=await database;
   List<Map<String,dynamic>> rows= await db.query('Expense');
    List<Expense> divlist= rows.map((e) => 
     Expense(id: e["id"], 
     date: e["date"], 
     vehicle: e["vehicle"], 
     driver: e["driver"], 
     departure: e["departure"],
     arrival: e["arrival"],
     b_amount: e["b_amount"],
     e_amount: e["e_amount"],
     expense: e["expense"], 
     )
    ).toList();
    return divlist; 
 }
 Future<int> deleteExpense(int id)async{
  Database db=await database;
 return await  db.delete('Expense',where: 'id=?',whereArgs: [id]);
 }
}



