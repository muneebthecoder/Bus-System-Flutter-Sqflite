class Vehicle{
  int id;
  String model,name;

  Vehicle({this.id=-1,required this.name,required this.model});

  Map<String,dynamic> toMap()
  {
    return <String,dynamic>{
      "name":name,
      "model": model
    };
  }
}
