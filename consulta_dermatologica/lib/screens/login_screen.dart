import 'package:consulta_dermatologica/screens/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:consulta_dermatologica/providers/login_form_provider.dart';
import 'package:consulta_dermatologica/services/services.dart';
import 'package:consulta_dermatologica/widgets/widgets.dart';
import '../models/models.dart';
import '../ui/input_decorations.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 230),
          CardLoginContainer(
              child: Column(
            children: [
              SizedBox(height: 10),
              Text('Login', style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 20),
              ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(), child: _LoginForn()),
            ],
          )),
          SizedBox(height: 50),
          TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, 'register'),
            style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                shape: MaterialStateProperty.all(StadiumBorder())),
            child: Text('Crear una nueva cuenta',
                style: TextStyle(fontSize: 18, color: Colors.black87)),
          ),
          SizedBox(height: 50),
        ],
      ),
    )));
  }
}

class _LoginForn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'prueba@gmail.com',
                      labelText: 'Correo electronico',
                      prefixIcon: Icons.alternate_email_rounded),
                  onChanged: (value) => loginForm.email = value),
              SizedBox(height: 20),
              TextFormField(
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '*******',
                    labelText: 'Contraseña',
                    prefixIcon: Icons.lock_outline),
                onChanged: (value) => loginForm.password = value,
                validator: (value) {
                  return (value != null && value.length >= 4)
                      ? null
                      : 'La contraseña tiene que tener mas de 4 caracteres';
                },
              ),
              SizedBox(height: 25),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    child: Text(
                      loginForm.isLoading ? 'Espere' : 'Ingresar',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        final authService =
                            Provider.of<AuthService>(context, listen: false);

                        if (!loginForm.isValidForm()) return;

                        loginForm.isLoading = true;

                        final UsuarioModel? usuario = await authService.login(
                            loginForm.email, loginForm.password);
                        loginForm.isLoading = false;
                        if (usuario != null) {
                          if (usuario.enable == false) {
                            print('Error Usuario desactivado');
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('El usuario esta DESACTIVADO'),
                                duration: Duration(
                                    seconds:
                                        2), // Duración del mensaje en pantalla
                              ),
                            );

                             loginForm.isLoading = true;
                          } else if (usuario.role == "ROLE_USER") {
                            // Comprobar si la contraseña comienza con los caracteres especificados
                            final String password = loginForm.password ?? '';
                            if (password.startsWith('ç*') ||
                                password.startsWith('-')) {
                              // Redirigir a otra pantalla
                              Navigator.pushNamed(context, Routes.cambiarPass);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('TIENES QUE CAMBIAR LA CONTRASEÑA'),
                                  duration: Duration(
                                      seconds:
                                          4), // Duración del mensaje en pantalla
                                ),
                              );
                            } else
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaginaPrincipal()));

                            /*
                            final citasService =
                            Provider.of<CitasService>(context, listen: false);
                            final CitasModel? misCitas = await citasService.miCita(); 
                            */
                          } else if (usuario.role == "ROLE_ADMIN") {
                            //Menu admin
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaginaAdmin()));
                          }
                        } else {
                          print('Error con el usuario o contraseña');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Error con el usuario o contraseña'),
                              duration: Duration(
                                  seconds:
                                      2), // Duración del mensaje en pantalla
                            ),
                          );
                        }
                      },
              )
            ],
          )),
    );
  }
}
