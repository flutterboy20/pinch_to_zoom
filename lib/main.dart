import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: const Text("Pinch to zoom"),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: MyInteractiveViewer(
                  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.AVJBYaoO6aKDKg6es-6KJAHaEK%26pid%3DApi&f=1",
                  clipBehavior: Clip.none),
            ),
          )),
    );
  }
}

class MyInteractiveViewer extends StatefulWidget {
  String path;
  Clip clipBehavior = Clip.hardEdge;
  MyInteractiveViewer(this.path, {Key? key, required this.clipBehavior})
      : super(key: key);
  @override
  _MyInteractiveViewerState createState() => _MyInteractiveViewerState();
}

class _MyInteractiveViewerState extends State<MyInteractiveViewer> {
  final transformationController = TransformationController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InteractiveViewer(
        clipBehavior: widget.clipBehavior,
        transformationController: transformationController,
        boundaryMargin: const EdgeInsets.all(20.0),
        minScale: 0.1,
        maxScale: 1.6,
        onInteractionEnd: (details) {
          setState(() {
            transformationController.toScene(Offset.zero);
          });
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(widget.path)),
      ),
    );
  }
}
