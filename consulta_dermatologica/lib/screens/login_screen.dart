import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:consulta_dermatologica/providers/login_form_provider.dart';
import 'package:consulta_dermatologica/services/services.dart';
import 'package:consulta_dermatologica/widgets/widgets.dart';
import '../models/models.dart';
import '../ui/input_decorations.dart';
import 'screens.dart';

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
                onChanged: (value) => loginForm.email = value
              ),
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

                        

                        final UsuarioModel? usuario = await authService.login(
                            loginForm.email, loginForm.password);

                       
                        if (usuario != null) {
                          if (usuario.role == "ROLE_USER") {
                           

                           Navigator.pushReplacementNamed(context, 'vercita');
                            /*
                            final citasService =
                            Provider.of<CitasService>(context, listen: false);
                            final CitasModel? misCitas = await citasService.miCita(); 
                            */

                          } else if (usuario.role == "ROLE_ADMIN") {
                            //Menu admin
                            Navigator.pushReplacementNamed(context, 'graphs');
                          }
                        } else {
                          print('Error con el usuario o contraseña');
                          
                        }
                      },
              )
            ],
          )),
    );
  }
}