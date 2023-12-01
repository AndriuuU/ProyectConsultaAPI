import 'package:flutter/material.dart';
import 'package:consulta_dermatologica/services/user_service.dart';

import '../models/models.dart'; // Asegúrate de importar el servicio

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // Controladores para los campos de edición
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  // Variable para el campo de seguro

  // Variable para mostrar el email del usuario
  String _email = "";

  @override
  void initState() {
    super.initState();
    // Llama al método para obtener los datos del usuario al inicio
    getUserData();
  }

  void getUserData() async {
    // Llama al servicio para obtener los datos del usuario
    final ClienteModel2? cliente = await UserService().getUser();

    // Verifica si se obtuvo el cliente y actualiza los controladores
    if (cliente != null) {
      setState(() {
        _nameController.text = cliente.nombre;
        _addressController.text = cliente.direccion;
        _phoneController.text = cliente.telefono;
        _email = cliente.email;
        // No actualizamos el controlador de contraseña para que no se pueda modificar
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de nombre
            _buildTextField("Nombre", _nameController),
            SizedBox(height: 16),

            // Campo de dirección
            _buildTextField("Dirección", _addressController),
            SizedBox(height: 16),

            // Campo de teléfono
            _buildTextField("Teléfono", _phoneController),
            SizedBox(height: 16),

            // Campo de correo electrónico (sin posibilidad de edición)
            _buildTextField(
                "Correo Electronico", TextEditingController()..text = _email,
                isEditable: false),
            SizedBox(height: 16),

            // Botón de Guardar

            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: () {
                // Lógica para guardar los cambios
                saveChanges();
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isPassword = false, bool isEditable = true}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      enabled:
          isEditable, // Hace que el campo sea no editable si isEditable es false
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Future<void> saveChanges() async {
    if (mounted) {
      String name = _nameController.text;
      String address = _addressController.text;
      String phone = _phoneController.text;
      String email = _email;
      String password = _passwordController.text;

      bool exito =
          await UserService().updateCliente(name, address, phone, email);
      if (exito) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cambios guardados con éxito'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No se pudo guardar los cambios'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
