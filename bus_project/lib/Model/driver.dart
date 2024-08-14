class Driver{
  int id,age;
  String name,contactNumber,image;
  int salary;
  Driver({this.id=-1,required this.name,
  required this.age,required this.contactNumber,required this.image,
  required this.salary,});

  Map<String,dynamic> toMap()
  {
    return <String,dynamic>{
      "name":name,
      "age": age,
      "contactNumber": contactNumber,
      "image": image,
      "salary": salary
    };
  }
}