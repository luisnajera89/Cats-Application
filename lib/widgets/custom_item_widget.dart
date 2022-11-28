import 'package:flutter/material.dart';

import '../helpers/database_helper.dart';
import '../models/cat_model.dart';

class CustomItem extends StatefulWidget {
  final Planet planet;

  const CustomItem({Key?key, required this.planet}) :super(key: key);

  @override
  State<CustomItem> createState() => _CustomItemState();
}

class _CustomItemState extends State<CustomItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Name:${widget.planet.Name},| Description:${widget.planet.Description}| Type:${widget.planet.Type},| Size:${widget.planet.Size}'),
      onLongPress: (){
        
        setState(() {
          DatabaseHelper.instance.delete(widget.planet.id!);
        });
      },
    );
  }
}