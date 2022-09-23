import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var tfData = TextEditingController();

  Future<void> writeData() async {
    var writeData = await getApplicationDocumentsDirectory(); 
    var appFoldersRoad = await writeData.path;
    var folder = File('$appFoldersRoad/myFile.txt'); //write data to RAM method

    folder.writeAsString(tfData.text);
    tfData.text = '';
  }

  Future<void> readData() async {
    try {
      var readData = await getApplicationDocumentsDirectory();
      var appFoldersRoad = await readData.path;
      var folder = File('$appFoldersRoad/myFile.txt');

      String readedData = await folder.readAsString();
      tfData.text = readedData;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Data Error')));
    }
  }

  Future<void> deleteData() async {
    var deleteData = await getApplicationDocumentsDirectory();
    var appFoldersRoad = await deleteData.path;
    var folder = File('$appFoldersRoad/myFile.txt');

    if (folder.existsSync()) {
      folder.delete();
    }

    tfData.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Folders'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: tfData,
                decoration: InputDecoration(
                  hintText: 'Enter Data',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      writeData();
                    },
                    child: Text('Write')),
                ElevatedButton(
                    onPressed: () {
                      readData();
                    },
                    child: Text('Read')),
                ElevatedButton(
                    onPressed: () {
                      deleteData();
                    },
                    child: Text('Delete')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
