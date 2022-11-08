import 'package:docs/colors.dart';
import 'package:docs/reposistory/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  // void signInWithGoogle(WidgetRef ref, BuildContext context) async {
  //   await ref.read(AuthRepositoryprovider).signInWithGoogle();

  //   // final sMessenger = ScaffoldMessenger.of(context);
  //   // final navigator = Routemaster.of(context);
  //   // final errorModel =
  //   //     await ref.read(authRepositoryProvider).signInWithGoogle();
  //   // if (errorModel.error == null) {
  //   //   ref.read(userProvider.notifier).update((state) => errorModel.data);
  //   //   navigator.replace('/');
  //   // } else {
  //   //   sMessenger.showSnackBar(
  //   //     SnackBar(
  //   //       content: Text(errorModel.error!),
  //   //     ),
  //   //   );
  //   // }
  // }

  void signInWithGoogle(WidgetRef ref) {
    ref.read(AuthRepositoryprovider).signWithGoogle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          //onPressed: () => signInWithGoogle(ref, context),
          onPressed: () => signInWithGoogle(ref),
          icon: Image.asset(
            'assets/images/g-logo-2.png',
            height: 20,
          ),
          label: const Text(
            'Sign in with Google',
            style: TextStyle(
              color: kBlackColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: kWhiteColor,
            minimumSize: const Size(150, 50),
          ),
        ),
      ),
    );
  }
}
