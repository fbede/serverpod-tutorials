import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplenoteapp_client/simplenoteapp_client.dart';
import 'package:simplenoteapp_flutter/note_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleNote App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Notes'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> {
  final TextEditingController controller = TextEditingController();
  final String newText = 'Type your note here ...';
  late Future<void> loadData;
  bool dialogLoading = false;
  int? indexIsDeleting;

  @override
  void initState() {
    controller.text = newText;
    loadData = ref.read(notesProvider.notifier).getNotes();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void resetController() {
    controller.text = newText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: buildBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNote(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildBody() {
    return FutureBuilder(
      future: loadData,
      builder: (context, snapshot) {
        final items = ref.watch(notesProvider);

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (items.isEmpty) {
          return const Center(child: Text('List is empty'));
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index].data),
              onTap: () => openNote(note: items[index]),
              trailing: GestureDetector(
                onTap: () async {
                  setState(() {
                    indexIsDeleting = index;
                  });
                  await ref
                      .read(notesProvider.notifier)
                      .deleteNote(items[index]);
                  setState(() {
                    indexIsDeleting = null;
                  });
                },
                child: buildDeleteIcon(index),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildDeleteIcon(int index) {
    if (index == indexIsDeleting) {
      return const CircularProgressIndicator();
    }
    return const Icon(Icons.delete);
  }

  Widget buildSaveButton() {
    if (dialogLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return const Text('Save');
    }
  }

  void openNote({Note? note}) {
    showDialog(
      context: context,
      builder: (context) {
        modifyController(note: note);

        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                      child: TextField(
                    controller: controller,
                    expands: true,
                    maxLines: null,
                    minLines: null,
                    decoration: const InputDecoration(border: InputBorder.none),
                  )),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      setState(() {
                        dialogLoading = true;
                      });
                      if (note == null) {
                        await ref.read(notesProvider.notifier).createNote(
                              Note(data: controller.text),
                            );
                      } else {
                        note.data = controller.text;
                        await ref.read(notesProvider.notifier).updateNote(note);
                      }
                      setState(() {
                        dialogLoading = false;
                      });
                      navigator.pop();
                    },
                    child: buildSaveButton(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void modifyController({Note? note}) {
    if (note == null) {
      controller.text = newText;
    } else {
      controller.text = note.data;
    }
  }
}
