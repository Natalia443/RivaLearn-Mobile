import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});
  static const String name = 'ChatScreen';
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final gemini = ref.watch(chatAIProvider);
    ref.listen(chatAIProvider, (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) => scrollDown());
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatea aqui'),
      ),
      body: gemini.when(
        data: (messages) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: DecoratedBox(
                      decoration: BoxDecoration(
                        color: messages[index].isUser
                            ? const Color(0xFF323540)
                            : const Color.fromARGB(255, 69, 148, 161),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          messages[index].message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: TextFormField(
                      textInputAction: TextInputAction.send,
                      onFieldSubmitted: (_) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        ref
                            .read(chatAIProvider.notifier)
                            .send(textController.text);
                        textController.clear();
                      },
                      controller: textController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ref
                          .read(chatAIProvider.notifier)
                          .send(textController.text);
                      textController.clear();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
        error: (error, _) => Text('$error'),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
