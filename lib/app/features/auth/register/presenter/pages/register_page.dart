import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mensageiro/app/features/auth/register/domain/entity/register_auth.dart';

import 'register_controller.dart';

class RegisterPage extends StatefulWidget {
  final RegisterController controller;

  const RegisterPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final RegisterController controller;
  final _formKey = GlobalKey<FormState>();
  var number = MaskTextInputFormatter(
    mask: '+55 (##) # ####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  TextEditingController nome = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
  }

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
        title: const Text("Registro"),
        centerTitle: true,
      ),
      body: Observer(
        builder: (context) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.isError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Erro no registro'),
                  const SizedBox(height: 15),
                  FloatingActionButton(
                    onPressed: () => controller.setError(false),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: const Icon(Icons.check, color: Colors.white),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildTextFormField(
                        labelText: 'Nome',
                        controller: nome,
                      ),
                      SizedBox(height: 24.0),
                      _buildTextFormField(
                        labelText: 'Número de telefone',
                        controller: phone,
                        inputFormatters: [number],
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 24.0),
                      _buildTextFormField(
                        labelText: 'Senha',
                        controller: password,
                        obscureText: true,
                      ),
                      SizedBox(height: 24.0),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Future.delayed(const Duration(seconds: 3));
          if (_formKey.currentState!.validate()) {
            final data = RegisterAuth(
              name: nome.text,
              password: password.text,
              phone: phone.text.replaceAll(RegExp(r'[^0-9]'), ''),
            );
            await controller.registerUser(data: data);
          }
        },
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildTextFormField({
    required String labelText,
    required TextEditingController controller,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira $labelText';
            }
            return null;
          },
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(
            fontFamily: 'Dylan Medium',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
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
      ],
    );
  }
}
