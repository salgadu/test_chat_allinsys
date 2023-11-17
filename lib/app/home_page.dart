import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
              child: Image.asset('assets/menssageiro1.png'),
            ),
            SizedBox(height: 16),
            Text(
              'Mensageiro',
              style: TextStyle(
                fontFamily: 'Dylan Medium',
                fontSize: 30,
              ),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Modular.to.pushNamed('/auth/login/'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xFF000000), 
                    backgroundColor: Color(0xFFFFFFFF),
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: 'Dylan Medium',
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => Modular.to.pushNamed('/auth/register/'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xFFFFFFFF),
                    backgroundColor: Color(0xFF2C2E35),
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Text(
                    'Registrar conta',
                    style: TextStyle(
                      fontFamily: 'Dylan Medium',
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
