import 'package:firebase/presentation/blocs.dart';
import 'package:firebase/presentation/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PostsCubit>().getPosts('user_posts');
  }

  void onProfileTap() {
    context.pop();
    context.push('/profile');
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();
    final postsCubit = context.watch<PostsCubit>();
    final posts = context.watch<PostsCubit>().state.posts;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pizarra de mensajes"),
      ),
      drawer: CustomDrawer(
        onHomeTap: () {
          context.go('/');
        },
        onProfileTap: onProfileTap,
        onLogoutTap: () {
          authCubit.signOutUser().then((value) => context.go('/'));
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return CustomPost(
                      user: post['email'],
                      message: post['message'],
                      postId: post['id'],
                      likes: List<String>.from(
                        post['likes'] ?? [],
                      ),
                      collectionPath: 'user_posts',
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: "Escribe un mensaje",
                      controller: _messageController,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  IconButton.filled(
                    onPressed: () {
                      postsCubit.addPost("user_posts", authCubit.state.email,
                          _messageController.text);
                      _messageController.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Registrado como: ',
                    style: TextStyle(color: colors.secondary),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    authCubit.state.email,
                    style: TextStyle(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
