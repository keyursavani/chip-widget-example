import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Flutter Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class ActorFilterEntry {
  const ActorFilterEntry(this.name, this.initials);
  final String name;
  final String initials;
}


class _MyHomePageState extends State<MyHomePage> {
  int? _value = 1;
  final List<ActorFilterEntry> _cast = <ActorFilterEntry>[
    const ActorFilterEntry('Aaron Burr', 'AB'),
    const ActorFilterEntry('Alexander Hamilton', 'AH'),
    const ActorFilterEntry('Eliza Hamilton', 'EH'),
    const ActorFilterEntry('James Madison', 'JM'),
  ];
  final List<String> _filters = <String>[];

  Iterable<Widget> get actorWidgets {
    return _cast.map((ActorFilterEntry actor) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          avatar: CircleAvatar(child: Text(actor.initials)),
          label: Text(actor.name),
          selected: _filters.contains(actor.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(actor.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == actor.name;
                });
              }
            });
          },
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Text("Simple Chip Example"),
            ),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.grey.shade800,
                child: const Text('AB'),
              ),
              label: const Text('Aaron Burr'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text("Input Chip Example"),
            ),
            InputChip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: const Text('AB'),
                ),
                label: const Text('Aaron Burr'),
                onPressed: () {
                  print('I am the one thing in life.');
                }
                ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text("Wrap Example"),
            ),
            Wrap(
              children: List<Widget>.generate(
                3,
                    (int index) {
                  return ChoiceChip(
                    label: Text('Item $index'),
                    selected: _value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? index : null;
                      });
                    },
                  );
                },
              ).toList(),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text("Action Chip Example"),
            ),
            ActionChip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: const Text('AB'),
                ),
                label: const Text('Aaron Burr'),
                onPressed: () {
                  print('If you stand for nothing, Burr, what’ll you fall for?');
                }
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text("Filter Chip Example"),
            ),
            Wrap(
              children: actorWidgets.toList(),
            ),
            Text('Look for: ${_filters.join(', ')}'),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text("CircleAvatar Example"),
            ),
            CircleAvatar(
              backgroundColor: Colors.brown.shade800,
              child: const Text('AH'),
            )
          ],
        ),
      ),
    );
  }
}
