import 'package:api_consumption/presentation/providers/video_games_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi lista de videojuegos'),
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(videoGamesProvider.notifier).loadVideoGamesInfo();
  }

  @override
  Widget build(BuildContext context) {
    final videoGamesInfo = ref.watch(videoGamesProvider);
    return ListView.builder(
      itemCount: videoGamesInfo.length,
      itemBuilder: (context, index) {
        final videoGame = videoGamesInfo[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListBody(
            children: [
              Row(
                children: [
                  Image.network(
                    videoGame.sampleCover.thumbnailImage,
                    width: 100,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(videoGame.title),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        );
      },
    );
  }
}
