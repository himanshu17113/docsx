import 'package:docs/models/error_model.dart';
import 'package:docs/reposistory/auth_repo.dart';
import 'package:docs/reposistory/doc_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import '../colors.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void signout(WidgetRef ref) {
    ref.read(AuthRepositoryprovider).signcut();
    ref.read(userProvider.notifier).update((state) => null);
  }

  void createdocument(BuildContext context, WidgetRef ref) async {
    final token = ref.read(userProvider)?.token;

    final Navigator = Routemaster.of(context);

    final snackBar = ScaffoldMessenger.of(context);

    ErrorModel errorModel = await ref.read(DocRepoProvider).CreateDoc(token!);

    if (errorModel.data != null) {
      Navigator.push('/document/${errorModel.data.id}');
    } else {
      snackBar.showSnackBar(SnackBar(content: Text(errorModel.error!)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(ref.watch(userProvider)!.token);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        actions: [
          IconButton(
            //  onPressed: () => createDocument(context, ref),
            icon: const Icon(
              Icons.add,
              color: kBlackColor,
            ),
            onPressed: () => createdocument(context, ref),
          ),
          IconButton(
            onPressed: () => signout(ref),
            icon: const Icon(
              Icons.logout,
              color: kRedColor,
            ),
          ),
        ],
      ),
      body: Center(
          child: Text(
        // ref.watch(AuthRepositoryprovider)!.email,
        ref.watch(userProvider)!.token,
      )),
    );
  }
}
