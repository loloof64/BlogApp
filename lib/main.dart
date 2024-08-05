import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vlog_app/data/note.dart';
import 'package:vlog_app/i18n/translations.g.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vlog_app/services/database_helper.dart';
import 'dart:ui' as ui;

String formatDateTimeWithSystemLocale(DateTime dateTime) {
  // Obtenir la locale du système
  Locale systemLocale = ui.PlatformDispatcher.instance.locale;

  // Créer un formateur de date avec la locale du système
  DateFormat formatter = DateFormat.yMMMd(systemLocale.toString()).add_jm();

  // Formater la date
  return formatter.format(dateTime);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  runApp(TranslationProvider(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      title: t.misc.app_title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: t.misc.app_title),
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
  List<Note> _notes = [];
  final TextEditingController _newNoteTitleController = TextEditingController();
  final TextEditingController _editNoteTitleController =
      TextEditingController();
  final TextEditingController _editNoteContentController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  @override
  void dispose() {
    _editNoteContentController.dispose();
    _editNoteTitleController.dispose();
    _newNoteTitleController.dispose();
    super.dispose();
  }

  Future _refreshNotes() async {
    _notes = await DatabaseHelper.instance.getNotes();
    setState(() {});
  }

  Future _doCreateNewNote() async {
    final title = _newNoteTitleController.text;
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.home.errors.empty_title),
        ),
      );
    }

    final creationDate = DateTime.now();

    final newNote = Note(
      id: -1,
      creationDate: creationDate,
      modificationDate: creationDate,
      title: title,
      content: "",
    );
    await DatabaseHelper.instance.insert(newNote);

    if (!mounted) return;
    _refreshNotes();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.home.confirmations.created_note),
      ),
    );
  }

  Future _doEditNote({
    required int index,
    required String title,
    required String content,
  })  async {
    final modificationDate = DateTime.now();
    Note currentNote = _notes[index];
    currentNote.title = title;
    currentNote.content = content;
    currentNote.modificationDate = modificationDate;
    await DatabaseHelper.instance.update(currentNote);

    if (!mounted) return;

    _refreshNotes();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.home.confirmations.modified_note),
      ),
    );
  }

  Future _openEditNoteDialog(int index) async {
    final noteToEdit = _notes[index];
    _editNoteTitleController.text = noteToEdit.title;
    _editNoteContentController.text = noteToEdit.content;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(t.home.dialogs.edit_note_dialog_title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          t.home.dialogs.edit_note_title_prompt,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _editNoteTitleController,
                            maxLines: 1,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                TextField(
                  controller: _editNoteContentController,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onSecondary,
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: Text(t.misc.buttons.cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _doEditNote(
                    index: index,
                    title: _editNoteTitleController.text,
                    content: _editNoteContentController.text,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Text(t.misc.buttons.ok),
              ),
            ],
          );
        });
  }

  Future _purposeCreateNote() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(t.home.dialogs.new_note_dialog_title),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(t.home.dialogs.new_note_title_prompt),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _newNoteTitleController,
                      maxLines: 1,
                    ),
                  ),
                )
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onSecondary,
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: Text(t.misc.buttons.cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _doCreateNewNote();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Text(t.misc.buttons.ok),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Table(
              columnWidths: const {
                1: FlexColumnWidth(0.3),
                2: FlexColumnWidth(0.3),
                3: FlexColumnWidth(0.3),
                4: FlexColumnWidth(0.3),
              },
              border: TableBorder.all(),
              children: List.generate(_notes.length, (index) {
                final formattedCreationDate =
                    formatDateTimeWithSystemLocale(_notes[index].creationDate);
                final formattedModificationDate =
                    formatDateTimeWithSystemLocale(
                        _notes[index].modificationDate);

                return TableRow(children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _notes[index].title.toString(),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        formattedCreationDate,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        formattedModificationDate,
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                        ),
                        onPressed: () => _openEditNoteDialog(index),
                      ),
                    ),
                  ),
                ]);
              }),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _purposeCreateNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
