import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/project_variables.dart';
import '../core/widgets/custom_elevated_button.dart';
import '../view_models.dart/sign_in_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    final TextEditingController _textEditingController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Sign in"),
      ),
      body: GestureDetector(
        onTap: () {
          focusNode.unfocus();
        },
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/loginbackground.jpg'), fit: BoxFit.cover)),
          child: context.watch<SignInModel>().busy
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: TextField(
                          focusNode: focusNode,
                          controller: _textEditingController,
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          autofocus: false,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            )),
                            hintText: 'Select an username',
                            hintStyle: TextStyle(color: Colors.white70),
                            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          ),
                        ),
                      ),
                      CustomElevatedButton(
                          buttonColor: ColorItems.generalTurquaseColor,
                          buttonTextStyle: FontItems.boldTextInter20,
                          buttonTitle: "Sign in",
                          buttonMetod: () => Provider.of<SignInModel>(context, listen: false)
                              .signIn(_textEditingController.text, context)),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
