import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'E-mail',
                  hintText: "algumacoisa@gmail.com",
                  labelStyle: const TextStyle(fontSize: 18, color: Colors.blue),
                  // errorText: "E-mail inválido",
                  // prefixText: "R\$ ",
                  // suffixText: "cm",
                ),
                // obscureText: true,
                // obscuringCharacter: "#",
                // keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
                onChanged: onChange,
                onSubmitted: onSubmitted,
              ),
              ElevatedButton(
                onPressed: () {
                  login();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    String email = emailController.text;
    print("Entrar: $email");
    emailController.clear();
  }

  void onChange(String text) {
    print("Mudou: $text");
  }

  void onSubmitted(String text) {
    print("Enviado: $text");
  }
}
