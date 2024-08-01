import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hiveworkapp/showMovies.dart';
 
void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox("mybox");
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cached Objects',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MoviesScreen(),
    );
  }
}
 
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  final myBox = Hive.box("mybox");
 
  void writeData() {
    myBox.put(2, "Lochan");
  }
 
  void readData() {
    print(myBox.get(2));
  }
 
  void deleteData() {
    myBox.delete(1);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    writeData();
                  },
                  child: Text("Write"),
                  color: Colors.blue,
                ),
                MaterialButton(
                  onPressed: () {
                    readData();
                  },
                  child: Text("Read"),
                  color: Colors.green,
                ),
                MaterialButton(
                  onPressed: () {
                    deleteData();
                  },
                  child: Text("Delete"),
                  color: Colors.red,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
 
