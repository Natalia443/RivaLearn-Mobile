import 'package:flutter_application_1/entities/entities.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: "/",
    name: AuthScreen.name,
    builder: (context, state) => const AuthScreen(),
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
    path: "/flashcards",
    name: FlashcardScreen.name,
    builder: (context, state) => FlashcardScreen(
      deckId: state.extra as String,
    ),
  ),
  GoRoute(
    path: "/deckSelection",
    name: DeckSelectionScreen.name,
    builder: (context, state) => DeckSelectionScreen(
      selectedWord: state.extra as String,
    ),
  ),
  GoRoute(
    path: "/quiz",
    name: QuizScreen.name,
    builder: (context, state) => QuizScreen(
      deckId: state.extra as String,
    ),
  ),
  GoRoute(
    path: "/stats",
    name: StatsScreen.name,
    builder: (context, state) => const StatsScreen(),
  ),
  GoRoute(
    path: "/storiesDeck",
    name: StoriesDeckSelectionScreen.name,
    builder: (context, state) => const StoriesDeckSelectionScreen(),
  ),
  GoRoute(
    path: "/stories",
    name: AiStoriesScreen.name,
    builder: (context, state) => AiStoriesScreen(deck: state.extra as Deck),
  ),
  GoRoute(
    path: "/chat",
    name: ChatScreen.name,
    builder: (context, state) => const ChatScreen(),
  ),
]);
