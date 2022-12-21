import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/locator.dart';
import '../view_models.dart/sign_in_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textEditingController = TextEditingController();
    return ChangeNotifierProvider(
        create: (context) => getIt<SignInModel>(),
        child: Consumer<SignInModel>(
          builder: (context, SignInModel model, child) => Scaffold(
            appBar: AppBar(
              title: const Text("Sign in"),
            ),
            body: Container(
              child: model.busy
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('User Name'),
                        TextField(
                          controller: _textEditingController,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              await model.signIn(_textEditingController.text, context);
                            },
                            child: const Text("Sign In"))
                      ],
                    ),
            ),
          ),
        ));
  }
}
