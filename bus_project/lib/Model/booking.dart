class Booking{
  int id;
  String vehicle,driver,departure,arrival,date;
  int amount;
  Booking({this.id=-1,required this.date,
  required this.driver,required this.vehicle,
  required this.departure,required this.arrival,required this.amount});

  Map<String,dynamic> toMap()
  {
    return <String,dynamic>{
      "date": date,
      "driver": driver,
      "vehicle": vehicle,     
      "departure": departure,
      "arrival": arrival,                    
      "amount": amount
    };
  }
}
