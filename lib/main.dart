import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Todos'),
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
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Add a Todo', contentPadding: EdgeInsets.all(10)),
              controller: _textController,
              textInputAction: TextInputAction.done,
              onSubmitted: (String value) {},
            ),
            RadioListTile(
                dense: true,
                title: const Text('All'),
                value: 1,
                groupValue: 2,
                onChanged: (filter) {}),
            RadioListTile(
                dense: true,
                title: const Text('Processing'),
                value: 2,
                groupValue: 2,
                onChanged: (filter) {}),
            RadioListTile(
                dense: true,
                title: const Text('Completed'),
                value: 3,
                groupValue: 2,
                onChanged: (filter) {}),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonBar(
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: (() {}),
                        child: const Text('Remove Completed')),
                    ElevatedButton(
                        onPressed: (() {}),
                        child: const Text('Mark All Completed'))
                  ],
                ),
              ],
            ),
            const Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "add a todo",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
