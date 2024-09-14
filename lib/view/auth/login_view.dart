import 'package:chat_app_2/components/my_button.dart';
import 'package:chat_app_2/components/my_textfield.dart';
import 'package:chat_app_2/helper/auth_api_calls.dart';
import 'package:chat_app_2/helper/helper_functions.dart';
import 'package:http_exception/http_exception.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({
    super.key,
    required this.onTap
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //login method
  void loginUser() async {
    //show login circle
    showDialog(
      context: context, 
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      )
    );

    if(emailController.text == "") {
      if (context.mounted) Navigator.pop(context);
      displayMessageToUser("El email es obligatorio!", context);
    } else if(passwordController.text == "") { 
      if (context.mounted) Navigator.pop(context);
      displayMessageToUser("La contraseña es obligatoria!", context);
    } else {
      //try login
      try {
        
        //getting user credentials
        final response = await apiLoginUser(
          emailController.text,
          passwordController.text,
        );

        //validate response status
        validateResponseStatus(response);

        //pop loading circle
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
          
              //email textfield
              MyTextfield(
                hintText: "Email",
                obscureText: false,
                controller: emailController
              ),

              const SizedBox(height: 10),

              //password textfield
              MyTextfield(
                hintText: "Password",
                obscureText: true,
                controller: passwordController
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

              //sign in button
              MyButton(
                text: "Iniciar Session",
                onTap: loginUser
              ),

              const SizedBox(height: 25),

              //dont have an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No tienes una cuenta?",
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Registrarse",
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