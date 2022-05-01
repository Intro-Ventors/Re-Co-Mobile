import 'package:flutter/material.dart';

class VRBackgrounds extends StatefulWidget {
  const VRBackgrounds({Key? key}) : super(key: key);

  @override
  State<VRBackgrounds> createState() => _VRBackgroundsState();
}

class _VRBackgroundsState extends State<VRBackgrounds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            //adds a virtual background to collection
          },
        ),
        title: const Text(
          "Virtual Backgrounds",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        children: [
          Container(
            color: Colors.amber,
          ),
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.purple,
          ),
          Container(
            color: Colors.green,
          ),
          Container(color: Colors.indigo),
          Container(
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

/*   Widget buildGridView() => GridView.builder(
      gridDelegate: SilverGridDelegateWithFixedCrossAxisCount(),
      itemCount: media.length,
      itemBuilder: (context, index) {
        final item = media[index];

        return buildTile(item);
      });

  Widget buildTile() {

  } */
}
