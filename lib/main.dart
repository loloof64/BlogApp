import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vlog_app/data/note.dart';
import 'package:vlog_app/i18n/translations.g.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vlog_app/pages/edit_note_page.dart';
import 'package:vlog_app/pages/new_note_page.dart';
import 'package:vlog_app/services/database_helper.dart';
import 'dart:ui' as ui;

String formatDateTimeWithSystemLocale(DateTime dateTime) {
  Locale systemLocale = ui.PlatformDispatcher.instance.locale;
  DateFormat formatter = DateFormat.yMMMd(systemLocale.toString()).add_jm();
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

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _refreshNotes() async {
    _notes = await DatabaseHelper.instance.getNotes();
    setState(() {});
  }

  Future _doCreateNewNote({
    required String title,
    required String content,
  }) async {
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.errors.empty_title),
        ),
      );
      return;
    }
    final creationDate = DateTime.now();

    final newNote = Note(
      id: -1,
      creationDate: creationDate,
      modificationDate: creationDate,
      title: title,
      content: content,
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
  }) async {
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.errors.empty_title),
        ),
      );
      return;
    }

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

  Future _openEditNotePage(int index) async {
    final noteToEdit = _notes[index];
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return EditNotePage(
          index: index,
          startTitle: noteToEdit.title,
          startContent: noteToEdit.content,
          onValidation: _doEditNote,
        );
      }),
    );
  }

  Future _purposeCreateNote() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return NewNotePage(onValidation: _doCreateNewNote);
      }),
    );
  }

  Future _openDeleteNoteDialog(int index) async {
    final noteToEdit = _notes[index];
    final confirmation = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(t.home.delete_node_dialog_title),
            content: Text(
                t.home.deleted_note_dialog_message(Title: noteToEdit.title)),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Text(t.misc.buttons.cancel),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(t.misc.buttons.ok),
                ),
              ),
            ],
          );
        });
    if (confirmation == true) {
      final id = noteToEdit.id;
      await DatabaseHelper.instance.delete(id);

      if (!mounted) return;
      _refreshNotes();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.home.deleted_note),
        ),
      );
    }
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
                0: FlexColumnWidth(0.5),
                1: FlexColumnWidth(0.12),
                2: FlexColumnWidth(0.12),
                3: FlexColumnWidth(0.05),
                4: FlexColumnWidth(0.05)
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
                        onPressed: () => _openEditNotePage(index),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                        ),
                        onPressed: () => _openDeleteNoteDialog(index),
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
