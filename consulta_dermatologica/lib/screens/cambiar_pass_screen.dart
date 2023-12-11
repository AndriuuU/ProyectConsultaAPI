import 'package:consulta_dermatologica/models/ClienteModel2.dart';
import 'package:consulta_dermatologica/services/user_service.dart';
import 'package:flutter/material.dart';

class CambiarPasswordScreen extends StatefulWidget {
  CambiarPasswordScreen();

  @override
  _CambiarPasswordScreenState createState() => _CambiarPasswordScreenState();
}

class _CambiarPasswordScreenState extends State<CambiarPasswordScreen> {
  TextEditingController _passwordController1 = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();

  String _email = "";

  @override
  void initState() {
    super.initState();
    getUserData(); // Llama a getUserData al iniciar el widget
  }

  void getUserData() async {
    // Llama al servicio para obtener los datos del usuario
    final ClienteModel2? cliente = await UserService().getUser();

    // Verifica si se obtuvo el cliente y actualiza los controladores
    if (cliente != null) {
      setState(() {
        _email = cliente.email;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cambiar Contraseña'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de correo electrónico (sin posibilidad de edición)
            _buildTextField("Correo Electrónico", _email, isEditable: false),
            SizedBox(height: 16),

            // Campo de nueva contraseña
            _buildPasswordTextField("Nueva Contraseña", _passwordController1,
                isPasswordVisible: false),
            SizedBox(height: 16),

            // Campo de confirmar contraseña
            _buildPasswordTextField(
                "Confirmar Contraseña", _passwordController2,
                isPasswordVisible: false),
            SizedBox(height: 16),

            Container(
                alignment: Alignment.center,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.deepPurple,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    child: Text(
                      'Cambiar Contraseña',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    // Lógica para cambiar la contraseña
                    changePassword();
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String text,
      {bool isPassword = false, bool isEditable = true}) {
    return TextField(
      controller: TextEditingController()..text = text,
      obscureText: isPassword,
      enabled: isEditable,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPasswordTextField(String label, TextEditingController controller,
      {bool isPasswordVisible = false}) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            obscureText: !isPasswordVisible,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> changePassword() async {
    String newPassword1 = _passwordController1.text;
    String newPassword2 = _passwordController2.text;

    if (newPassword1.isEmpty || newPassword2.isEmpty) {
      // Muestra un mensaje si alguno de los campos está vacío
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, completa ambos campos de contraseña.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (newPassword1 != newPassword2) {
      // Muestra un mensaje si las contraseñas no coinciden
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Las contraseñas no coinciden.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Obtener el correo electrónico del usuario
    String email = _email;

    // Llamar a la función para actualizar la contraseña
    bool success = await UserService().updateUser(email, newPassword1);

    if (success) {
      // Muestra un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Contraseña cambiada con éxito.'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Muestra un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al cambiar la contraseña. Inténtalo de nuevo.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
