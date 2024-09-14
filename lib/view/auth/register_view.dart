import 'package:chat_app_2/components/my_button.dart';
import 'package:chat_app_2/components/my_textfield.dart';
import 'package:chat_app_2/helper/helper_functions.dart';
import 'package:chat_app_2/helper/auth_api_calls.dart';
import 'package:flutter/material.dart';
import 'package:http_exception/http_exception.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    super.key,
    required this.onTap
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  //register method
  void registerUser() async {

    //show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator()
      ),
    );

    //username not null
    if(usernameController.text == "") {
      if (context.mounted) Navigator.pop(context);
      displayMessageToUser("El nombre de usuario es obligatorio!", context);
    }
    //passwords match
    else if(passwordController.text == "" || passwordController.text != confirmPwController.text) {
      if (context.mounted) Navigator.pop(context);
      displayMessageToUser("Las contraseñas no coinciden!", context);
    } else {

      //try creating the user
      try {
        //create the user
        final response = await apiRegisterUser(
          usernameController.text,
          emailController.text,
          passwordController.text,
          confirmPwController.text
        );

        //validate response status
        validateResponseStatus(response);
        if (context.mounted) Navigator.pop(context);

      } on HttpException catch (e) {
        //pop loading circle
        if (context.mounted) Navigator.pop(context);
        //display error message to user
        displayMessageToUser(e.toString(), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
          
              const SizedBox(height: 25),
          
              //app name
              const Text(
                "M I N I M A L",
                style: TextStyle(fontSize: 20),
              ),
          
              const SizedBox(height: 50),
          
              //username textfield
              MyTextfield(
                hintText: "Nombre de usuario",
                obscureText: false,
                controller: usernameController
              ),

              const SizedBox(height: 10),

              //email textfield
              MyTextfield(
                hintText: "Email",
                obscureText: false,
                controller: emailController
              ),

              const SizedBox(height: 10),

              //password textfield
              MyTextfield(
                hintText: "Contraseña",
                obscureText: true,
                controller: passwordController
              ),

              const SizedBox(height: 10),

              //confirm password textfield
              MyTextfield(
                hintText: "Confirmar contraseña",
                obscureText: true,
                controller: confirmPwController
              ),

              const SizedBox(height: 10),

              //forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Olvidaste tu contraseña?",
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              //register in button
              MyButton(
                text: "Registrarse",
                onTap: registerUser
              ),

              const SizedBox(height: 25),

              //dont have an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tienes una cuenta?",
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Inicia session",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}