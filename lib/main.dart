import 'package:flutter/material.dart';
import 'package:vlog_app/data/note.dart';
import 'package:vlog_app/i18n/translations.g.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vlog_app/services/database_helper.dart';

void main() async {
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

  Future _refreshNotes() async {
    _notes = await DatabaseHelper.instance.getNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _notes.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_notes[index].title),
              subtitle: Text(_notes[index].content),
            );
          },
        ),
      ),
    );
  }
}
