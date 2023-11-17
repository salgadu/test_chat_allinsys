import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mensageiro/app/features/auth/login/presenter/pages/login_controller.dart';

class LoginPage extends StatefulWidget {
  final LoginController controller;

  const LoginPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController telefone = TextEditingController();
  TextEditingController senha = TextEditingController();
  var mascaraTelefone = MaskTextInputFormatter(
    mask: '+55 (##) # ####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Texto informativo para o número de telefone
              Text(
                'Digite seu número de telefone',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Campo de entrada para o número de telefone
              TextFormField(
                keyboardType: TextInputType.number,
                controller: telefone,
                inputFormatters: [mascaraTelefone],
                style: TextStyle(
                  fontFamily: 'Dylan Medium',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF7F5F7)),
                  ),
                ),
              ),
              SizedBox(height: 24.0),

              // Texto informativo para a senha
              Text(
                'Digite sua senha',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Campo de entrada para a senha
              TextFormField(
                controller: senha,
                obscureText: true,
                style: TextStyle(
                  fontFamily: 'Dylan Medium',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFF7F5F7)),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          widget.controller.singIn(
            phone: telefone.text.replaceAll(RegExp(r'[^0-9]'), ''),
            password: senha.text,
          );
        },
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
