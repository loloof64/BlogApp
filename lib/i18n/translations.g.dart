/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 3
/// Strings: 39 (13 per locale)
///
/// Built on 2024-08-05 at 11:41 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build),
	es(languageCode: 'es', build: _TranslationsEs.build),
	fr(languageCode: 'fr', build: _TranslationsFr.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  );

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _TranslationsMiscEn misc = _TranslationsMiscEn._(_root);
	late final _TranslationsHomeEn home = _TranslationsHomeEn._(_root);
	late final _TranslationsErrorsEn errors = _TranslationsErrorsEn._(_root);
	late final _TranslationsNewNoteEn new_note = _TranslationsNewNoteEn._(_root);
	late final _TranslationsEditNoteEn edit_note = _TranslationsEditNoteEn._(_root);
}

// Path: misc
class _TranslationsMiscEn {
	_TranslationsMiscEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get app_title => 'Vlog application';
	late final _TranslationsMiscButtonsEn buttons = _TranslationsMiscButtonsEn._(_root);
}

// Path: home
class _TranslationsHomeEn {
	_TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _TranslationsHomeConfirmationsEn confirmations = _TranslationsHomeConfirmationsEn._(_root);
	String get delete_node_dialog_title => 'Delete note ?';
	String deleted_note_dialog_message({required Object Title}) => 'Do you want to delete note \'${Title}\' ?';
	String get deleted_note => 'Deleted note';
}

// Path: errors
class _TranslationsErrorsEn {
	_TranslationsErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get empty_title => 'Gave up : title cannot be empty !';
}

// Path: new_note
class _TranslationsNewNoteEn {
	_TranslationsNewNoteEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get page_title => 'Add a new note';
	String get title_prompt => 'Note title';
}

// Path: edit_note
class _TranslationsEditNoteEn {
	_TranslationsEditNoteEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get page_title => 'Edit note';
	String get title_prompt => 'Note title';
}

// Path: misc.buttons
class _TranslationsMiscButtonsEn {
	_TranslationsMiscButtonsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get ok => 'Ok';
	String get cancel => 'Cancel';
}

// Path: home.confirmations
class _TranslationsHomeConfirmationsEn {
	_TranslationsHomeConfirmationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get created_note => 'Note created';
	String get modified_note => 'Note modified';
}

// Path: <root>
class _TranslationsEs extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsEs.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super.build(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	@override late final _TranslationsEs _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsMiscEs misc = _TranslationsMiscEs._(_root);
	@override late final _TranslationsHomeEs home = _TranslationsHomeEs._(_root);
	@override late final _TranslationsErrorsEs errors = _TranslationsErrorsEs._(_root);
	@override late final _TranslationsNewNoteEs new_note = _TranslationsNewNoteEs._(_root);
	@override late final _TranslationsEditNoteEs edit_note = _TranslationsEditNoteEs._(_root);
}

// Path: misc
class _TranslationsMiscEs extends _TranslationsMiscEn {
	_TranslationsMiscEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get app_title => 'Aplicación de vlog';
	@override late final _TranslationsMiscButtonsEs buttons = _TranslationsMiscButtonsEs._(_root);
}

// Path: home
class _TranslationsHomeEs extends _TranslationsHomeEn {
	_TranslationsHomeEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeConfirmationsEs confirmations = _TranslationsHomeConfirmationsEs._(_root);
	@override String get delete_node_dialog_title => 'Borrar nota ?';
	@override String deleted_note_dialog_message({required Object Title}) => '¿Quieres borrar la nota \'${Title}\'?';
	@override String get deleted_note => 'Nota borrada';
}

// Path: errors
class _TranslationsErrorsEs extends _TranslationsErrorsEn {
	_TranslationsErrorsEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get empty_title => 'Cancelado: ¡el título no puede estar vacío!';
}

// Path: new_note
class _TranslationsNewNoteEs extends _TranslationsNewNoteEn {
	_TranslationsNewNoteEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get page_title => 'Agregar una nueva nota';
	@override String get title_prompt => 'Título de la nota';
}

// Path: edit_note
class _TranslationsEditNoteEs extends _TranslationsEditNoteEn {
	_TranslationsEditNoteEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get page_title => 'Editar la nota';
	@override String get title_prompt => 'Título de la nota';
}

// Path: misc.buttons
class _TranslationsMiscButtonsEs extends _TranslationsMiscButtonsEn {
	_TranslationsMiscButtonsEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get ok => 'De acuerdo';
	@override String get cancel => 'Anular';
}

// Path: home.confirmations
class _TranslationsHomeConfirmationsEs extends _TranslationsHomeConfirmationsEn {
	_TranslationsHomeConfirmationsEs._(_TranslationsEs root) : this._root = root, super._(root);

	@override final _TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get created_note => 'Nota creada';
	@override String get modified_note => 'Nota modificada';
}

// Path: <root>
class _TranslationsFr extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsFr.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super.build(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	@override late final _TranslationsFr _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsMiscFr misc = _TranslationsMiscFr._(_root);
	@override late final _TranslationsHomeFr home = _TranslationsHomeFr._(_root);
	@override late final _TranslationsErrorsFr errors = _TranslationsErrorsFr._(_root);
	@override late final _TranslationsNewNoteFr new_note = _TranslationsNewNoteFr._(_root);
	@override late final _TranslationsEditNoteFr edit_note = _TranslationsEditNoteFr._(_root);
}

// Path: misc
class _TranslationsMiscFr extends _TranslationsMiscEn {
	_TranslationsMiscFr._(_TranslationsFr root) : this._root = root, super._(root);

	@override final _TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get app_title => 'Application vlog';
	@override late final _TranslationsMiscButtonsFr buttons = _TranslationsMiscButtonsFr._(_root);
}

// Path: home
class _TranslationsHomeFr extends _TranslationsHomeEn {
	_TranslationsHomeFr._(_TranslationsFr root) : this._root = root, super._(root);

	@override final _TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeConfirmationsFr confirmations = _TranslationsHomeConfirmationsFr._(_root);
	@override String get delete_node_dialog_title => 'Effacer la note ?';
	@override String deleted_note_dialog_message({required Object Title}) => 'Souhaitez-vous effacer la note \'${Title}\' ?';
	@override String get deleted_note => 'Note effacée';
}

// Path: errors
class _TranslationsErrorsFr extends _TranslationsErrorsEn {
	_TranslationsErrorsFr._(_TranslationsFr root) : this._root = root, super._(root);

	@override final _TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get empty_title => 'Abandon : le titre ne peut pas être vide !';
}

// Path: new_note
class _TranslationsNewNoteFr extends _TranslationsNewNoteEn {
	_TranslationsNewNoteFr._(_TranslationsFr root) : this._root = root, super._(root);

	@override final _TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get page_title => 'Ajouter une nouvelle note';
	@override String get title_prompt => 'Titre de la note';
}

// Path: edit_note
class _TranslationsEditNoteFr extends _TranslationsEditNoteEn {
	_TranslationsEditNoteFr._(_TranslationsFr root) : this._root = root, super._(root);

	@override final _TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get page_title => 'Éditer la note';
	@override String get title_prompt => 'Titre de la note';
}

// Path: misc.buttons
class _TranslationsMiscButtonsFr extends _TranslationsMiscButtonsEn {
	_TranslationsMiscButtonsFr._(_TranslationsFr root) : this._root = root, super._(root);

	@override final _TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get ok => 'D\'accord';
	@override String get cancel => 'Annuler';
}

// Path: home.confirmations
class _TranslationsHomeConfirmationsFr extends _TranslationsHomeConfirmationsEn {
	_TranslationsHomeConfirmationsFr._(_TranslationsFr root) : this._root = root, super._(root);

	@override final _TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get created_note => 'Note créée';
	@override String get modified_note => 'Note modifiée';
}
