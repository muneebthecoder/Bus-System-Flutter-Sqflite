class Expense{
  int id;
  String vehicle,driver,departure,arrival,date;
  int b_amount,e_amount;
  String expense;
  Expense({this.id=-1,required this.date,
  required this.driver,required this.vehicle,
  required this.departure,required this.arrival,required this.b_amount,required this.e_amount,required this.expense});

  Map<String,dynamic> toMap()
  {
    return <String,dynamic>{
      "date": date,
      "driver": driver,
      "vehicle": vehicle,
      "departure": departure,
      "arrival": arrival,                    
      "b_amount": b_amount,
      "e_amount": e_amount,
      "expense": expense
    };
  }
}