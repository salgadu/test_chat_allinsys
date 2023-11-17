import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mensageiro/app/core/store/auth/auth_store.dart';

class CustomDrawer extends StatelessWidget {
  final AuthStore _authStore = Modular.get<AuthStore>();
  CustomDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey, // Changed color to grey
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: _authStore.user?.photo?.isEmpty ?? true
                      ? null
                      : NetworkImage(
                          _authStore.user!.photo!,
                        ),
                  child: _authStore.user?.photo?.isEmpty ?? true
                      ? Text(
                          _authStore.user!.name.substring(0, 1),
                          style: TextStyle(
                            fontFamily: 'Dylan Medium', // Changed font to Dylan Medium
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  _authStore.user?.name ?? '',
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'Dylan Medium', // Changed font to Dylan Medium
                    fontSize: 25,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildDrawerItem(
                label: 'Configurações',
                icon: Icons.settings,
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              _buildDrawerItem(
                label: 'Ajuda',
                icon: Icons.help,
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              _buildDrawerItem(
                label: 'Sair', 
              icon: Icons.exit_to_app,
              onTap: (
() async => await _authStore.signOut()
              ),
              )
            ],
          ),
         
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required String label,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontFamily: 'Dylan Medium', // Changed font to Dylan Medium
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      leading: Icon(
        icon,
        color: Colors.black,
      ),
      onTap: onTap,
    );
  }
}
