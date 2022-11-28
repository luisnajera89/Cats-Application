import 'dart:convert';

class Planet {
  final int?id;
  final String Description;
  final String Type;
  final String Size;
  final String Image;
  final String Name;

  Planet(
  {
    this.id, required this.Description, required this.Type, required this.Size, required this.Image, required this.Name
  }
  );
  factory Planet.formMap(Map<String, dynamic> json) => 
    Planet(id: json['id'], Description: json['Description'], Type: json['Type'], Size: json['Size'], Image: json['Image'], Name: json['Name']);

    Map<String, dynamic> toMap(){
      return{
        'id': id,
        'Description': Description,
        'Type': Type,
        'Size': Size,
        'Image': Image,
        'Name': Name,
      };
    }
}





