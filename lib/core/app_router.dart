import 'package:flutter_application_1/entities/book.dart';
import 'package:flutter_application_1/screens/book_catalog_screen.dart';
import 'package:flutter_application_1/screens/book_detail_screen.dart';
import 'package:flutter_application_1/screens/deck_creator_screen.dart';
import 'package:flutter_application_1/screens/decks_screen.dart';
import 'package:flutter_application_1/screens/dictionary_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/lang_selection_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/main_menu_screen.dart';
import 'package:flutter_application_1/screens/pdf_reader_screen.dart';
import 'package:flutter_application_1/screens/signup_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: "/",
    name: MainMenuScreen.name,
    builder: (context, state) => const MainMenuScreen(),
  ),
  GoRoute(
    path: "/home-screen",
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: "/catalog",
    name: BookCatalogScreen.name,
    builder: (context, state) => BookCatalogScreen(
      lang: state.extra as String,
    ),
  ),
  GoRoute(
    path: "/details",
    name: BookDetailScreen.name,
    builder: (context, state) => BookDetailScreen(
      book: state.extra as Book,
    ),
  ),
  GoRoute(
    path: "/default_texts",
    name: LangSelectionScreen.name,
    builder: (context, state) => const LangSelectionScreen(),
  ),
  GoRoute(
    path: "/dictionary",
    name: DictionaryScreen.name,
    builder: (context, state) => const DictionaryScreen(),
  ),
  GoRoute(
    path: "/signup",
    name: SignUpScreen.name,
    builder: (context, state) => const SignUpScreen(),
  ),
  GoRoute(
    path: "/login",
    name: LoginScreen.name,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: "/pdfviewer",
    name: PDFViewerScreen.name,
    builder: (context, state) => const PDFViewerScreen(),
  ),
  GoRoute(
    path: "/decks",
    name: DeckScreen.name,
    builder: (context, state) => const DeckScreen(),
  ),
  GoRoute(
    path: "/create_deck",
    name: DeckCreatorScreen.name,
    builder: (context, state) => const DeckCreatorScreen(),
  ),
]);
