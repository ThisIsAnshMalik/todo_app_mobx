import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_mobx/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: ((context) => TodoList()),
      builder: ((context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Todos'),
        );
      }),
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
    final list = Provider.of<TodoList>(context);
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
              onSubmitted: (String value) {
                list.addTodo(value);
                _textController.clear();
              },
            ),
            Observer(
              builder: (_) => Column(
                children: <Widget>[
                  RadioListTile(
                      dense: true,
                      title: const Text('All'),
                      value: VisibilityFilter.all,
                      groupValue: list.filter,
                      onChanged: (filter) => list.filter = filter!),
                  RadioListTile(
                      dense: true,
                      title: const Text('Pending'),
                      value: VisibilityFilter.pending,
                      groupValue: list.filter,
                      onChanged: (filter) => list.filter = filter!),
                  RadioListTile(
                      dense: true,
                      title: const Text('Completed'),
                      value: VisibilityFilter.completed,
                      groupValue: list.filter,
                      onChanged: (filter) => list.filter = filter!),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Observer(
                    builder: (_) => ButtonBar(
                          children: <Widget>[
                            ElevatedButton(
                              child: const Text('Remove Completed'),
                              onPressed: list.canRemoveAllCompleted
                                  ? list.removeCompleted
                                  : null,
                            ),
                            ElevatedButton(
                              child: const Text('Mark All Completed'),
                              onPressed: list.canMarkAllCompleted
                                  ? list.markAllAsCompleted
                                  : null,
                            )
                          ],
                        ))
              ],
            ),
            Observer(
                builder: (_) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      list.itemsDescription,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ))),
            Observer(
                builder: (_) => Flexible(
                      child: ListView.builder(
                          itemCount: list.visibleTodos.length,
                          itemBuilder: (_, index) {
                            final todo = list.visibleTodos[index];
                            return Observer(
                                builder: (_) => CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      value: todo.done,
                                      onChanged: (flag) => todo.done = flag!,
                                      title: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: Text(
                                            todo.description,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () =>
                                                list.removeTodo(todo),
                                          )
                                        ],
                                      ),
                                    ));
                          }),
                    ))
          ],
        ),
      ),
    );
  }
}
