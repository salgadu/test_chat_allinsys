import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mensageiro/app/core/widgets/drawer/custom_drawer.dart';
import 'package:mensageiro/app/features/home/contact/presenter/pages/contacts_controller.dart';

class HomeContactPage extends StatefulWidget {
  final ContactsController controller;
  final String id;

  const HomeContactPage({Key? key, required this.controller, required this.id})
      : super(key: key);

  @override
  _HomeContactPageState createState() => _HomeContactPageState();
}

class _HomeContactPageState extends State<HomeContactPage> {
  late ContactsController controller;

  var number = MaskTextInputFormatter(
    mask: '+55 (##) # ####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
  }

  loadContact() async {
    if (widget.id.isNotEmpty && !controller.isLoading) {
      int numero = int.parse(widget.id);
      Modular.to.pushNamed('/home/chat/',
          arguments: controller.listContacts![numero]);
    }
  }

  // Function to open the add contact dialog
  void _openAddContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String newContactName = '';
        String newContactNumber = '';

        return AlertDialog(
          title: const Text('Novo contato',
          textAlign: TextAlign.center,),
         
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12),
              _buildAlertDialogTextField(
                hintText: 'Nome',
                onChanged: (value) {
                  newContactName = value;
                },
              ),
              SizedBox(height: 12),
              _buildAlertDialogTextField(
                hintText: 'Numero',
                keyboardType: TextInputType.phone,
                inputFormatters: [number],
                onChanged: (value) {
                  newContactNumber = value;
                },
              ),
              SizedBox(height: 12),
            ],
          ),
          
          
          actions: [
            _buildElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              backgroundColor: Colors.red,
              icon: Icons.close,
            ),
            _buildElevatedButton(
              onPressed: () {
                controller.addContactF(
                  newContactName,
                  newContactNumber.replaceAll(RegExp(r'[^0-9]'), ''),
                );
                Navigator.of(context).pop(); // Close the dialog
              },
              backgroundColor: Colors.green,
              icon: Icons.check,
            ),
          ],
          backgroundColor: Colors.white, // Adjust the transparency here
          elevation: 5, // You can adjust the elevation as well
        );
      },
    );
  }

  Widget _buildAlertDialogTextField({
    required String hintText,
    TextEditingController? controller,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira $hintText';
        }
        return null;
      },
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      style: TextStyle(
        fontFamily: 'Dylan Medium',
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFF7F5F7)),
        ),
      ),
    );
  }

  Widget _buildElevatedButton({
    required VoidCallback onPressed,
    required Color backgroundColor,
    required IconData icon,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        onPrimary: Colors.white,
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddContactDialog(context),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      appBar: AppBar(
        title: const Text('Contatos'),
      ),
      body: Observer(builder: (_) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.isError) {
          return const Center(
            child: Text('Erro ao carregar contatos'),
          );
        } else {
          loadContact();
          return ListView.builder(
            itemCount: controller.listContacts?.length ?? 0,
            itemBuilder: (_, index) {
              final contact = controller.listContacts![index];
              return ListTile(
                onTap: () => Modular.to.pushNamed('/home/chat/', arguments: controller.listContacts![index]),
                title: Text(contact.name),
                subtitle: Text(contact.phone),
                leading: CircleAvatar(
                  backgroundImage: contact.photo?.isEmpty ?? true
                      ? null
                      : NetworkImage(
                          contact.photo!,
                        ),
                  child: contact.photo?.isEmpty ?? true
                      ? Text(
                          contact.name.substring(0, 1),
                          style: GoogleFonts.spaceGrotesk()
                              .copyWith(fontSize: 25, color: Colors.white),
                        )
                      : null,
                ),
              );
            },
          );
        }
      }),
    );
  }
}
