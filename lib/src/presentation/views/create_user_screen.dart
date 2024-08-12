import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifespark_machine_task/src/config/navigators.dart';
import 'package:lifespark_machine_task/src/config/validators.dart';
import 'package:lifespark_machine_task/src/domain/usecases/create_user_usecase.dart';
import 'package:lifespark_machine_task/src/presentation/views/home_screen.dart';
import 'package:lifespark_machine_task/src/presentation/widgets/custom_filled_button.dart';
import 'package:lifespark_machine_task/src/presentation/widgets/logo_label_widget.dart';
import 'package:lifespark_machine_task/src/presentation/widgets/text_input_field.dart';
import 'package:lifespark_machine_task/injection_container.dart' as di;

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(CupertinoIcons.back),
                ),
                const SizedBox(width: 10),
                const LogoLabelWidget(),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Oh Wait!!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'You are new here! Enter your details \nto continue',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                TextInputField(
                  controller: nameController,
                  hintText: 'Name',
                  validator: validateName,
                ),
                const SizedBox(height: 20),
                TextInputField(
                  controller: emailController,
                  hintText: 'Email address',
                  validator: validateEmail,
                ),
                const Spacer(),
                CustomFilledButton(
                  onPressed: onCreatePressed,
                  text: 'Create',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onCreatePressed() async {
    final createUserUsecase = di.getIt.get<CreateUserUsecase>();
    if (formKey.currentState!.validate()) {
      await createUserUsecase.call(emailController.text, nameController.text);
      nextScreenRemoveUntil(context, const HomeScreen());
    }
  }
}
