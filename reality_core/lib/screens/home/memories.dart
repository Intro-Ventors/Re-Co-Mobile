import 'package:flutter/material.dart';

class Memories extends StatefulWidget {
  const Memories({Key? key}) : super(key: key);

  @override
  State<Memories> createState() => _MemoriesState();
}

class _MemoriesState extends State<Memories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Memories",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).accentColor,
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
