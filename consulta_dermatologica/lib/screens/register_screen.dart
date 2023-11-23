import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:consulta_dermatologica/providers/login_form_provider.dart';
import 'package:consulta_dermatologica/services/services.dart';
import 'package:consulta_dermatologica/widgets/widgets.dart';
import '../ui/input_decorations.dart';


class RegisterScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 205),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 3),
                    Text('Crear cuenta', style: Theme.of(context).textTheme.headline4),
                    SizedBox(height: 9),

                    ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(),
                      child: _RegisterForm()
                    ),

                  ],
                )
              ),

              SizedBox( height: 25),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())
                ),
                child: Text('¿Deseas iniciar sesion?', style: TextStyle(fontSize:18, color: Colors.black87)),
              ),
              SizedBox( height: 50),

            ],
          ),
        )
      )
    );
  }
}

class _RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    
    final loginForm=Provider.of<LoginFormProvider>(context);
    //const List<Ciclos> listCiclos = authService.getCicles();
    
    return Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Nombre..',
                labelText: 'Tu nombre',
                prefixIcon: Icons.account_circle_outlined
              ),
              onChanged: (value) => loginForm.name=value,
              validator: (value) {
              },
            ),
            
            SizedBox(height:4),

            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'prueba@gmail.com',
                labelText: 'Correo electronico',
                prefixIcon: Icons.alternate_email_rounded
              ),
              onChanged: (value) => loginForm.email=value,
              validator: (value) {

                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                  ? null
                  : 'Escribe un correo valido';
              },
            ),

            SizedBox(height:4),

            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'C/...',
                labelText: 'Direccion',
                prefixIcon: Icons.add_home_outlined
              ),
              onChanged: (value) => loginForm.direccion=value,
              validator: (value) {
              },
            ),
             SizedBox(height:4),

            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.phone,
              decoration: InputDecorations.authInputDecoration(
                hintText: '621314213',
                labelText: 'Telefono',
                prefixIcon: Icons.add_ic_call_outlined
              ),
              onChanged: (value) => loginForm.telefono=value,
              validator: (value) {

                  return(value != null && value.length==9 )
                  ? null
                  : 'El telefono no es correcto';
              }
            ),

            SizedBox(height:4),

            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*******',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) => loginForm.password=value,
              validator: (value) {

                return(value != null && value.length>=4 )
                ? null
                : 'La contraseña tiene que tener mas de 4 caracteres';

              },
            ),
            SizedBox(height:4),

            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*******',
                labelText: 'Repite la contraseña',
                prefixIcon: Icons.lock_outline
              ),
              onChanged: (value) => loginForm.c_password=value,
              validator: (value) {

                return(value != null && value == loginForm.password)
                ? null
                : 'Tiene que ser la misma contraseña';

              },
            ),

          

            SizedBox(height:10),
            
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical:15),
                child:Text(
                  loginForm.isLoading
                    ? 'Espere'
                    : 'Ingresar',
                  style: TextStyle( color: Colors.white),
                )
              ),
              
              onPressed: loginForm.isLoading ? null : () async {
                FocusScope.of(context).unfocus();
                final authService=Provider.of<AuthService>(context, listen: false);

                if( !loginForm.isValidForm() ) return;

                loginForm.isLoading = true;
                
                final String? errorMessage =await authService.createUser(loginForm.name,loginForm.email,true,loginForm.direccion,loginForm.telefono, loginForm.password);

                
                if(errorMessage==null) {
                  //avigator.pushReplacementNamed(context, 'home');

                }else {
                  
                  Navigator.pushReplacementNamed(context, 'login');
                  loginForm.isLoading = false;
                }    
              },
            )
          ],
        )
      
    );
  }
}