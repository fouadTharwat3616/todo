import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/register_screen.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/homescreen.dart';
import 'package:todo/tabs/tasks/custom_text_form_field.dart';
import 'package:todo/tabs/tasks/default_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName='login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController =TextEditingController();
  final passwordController =TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title:Text(
          'Login',style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontSize: 20
        )
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image:AssetImage('assets/images/background.png'),
            fit: BoxFit.fill
          )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back!',style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                   labelText: 'Email',
                    controller: emailController,
                   validator: (value){
                     if(value == null || value.isEmpty)
                     {
                       return 'Email can not be empty';
                     }
                   return null;
                   },
                ),
                CustomTextFormField(
                  labelText: 'Password',
                    controller: passwordController,
                  validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return 'Password can not be empty';
                    }
                    else if(value.length < 6)
                      {
                        return 'Password should be at least < 6';
                      }
                    return null;
                  },
                  isPassword: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                DefaultElevatedButton(
                    onpressed: login,
                  child: Row(
                    children: [
                      const Spacer(),
                      Text(
                        'login',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.whitecolor,
                          fontSize: 14
                        ),
                      ),
                      const Spacer(flex: 8,),
                      const Icon(Icons.arrow_forward),
                      const Spacer(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed(RegisterScreen.routeName);
                    },
                    child: const Text(
                        'OR Create an Account',
                    ),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
  void login(){
    if (formKey.currentState?.validate() == true) {
      FirebaseUtils.Login(
          email: emailController.text,
          password: passwordController.text
      ).then( (user){
                Provider.of<UserProvider>(context,listen: false).UpdateUser(user);
                Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
              })
          .catchError((error){
           if(error is FirebaseAuthException && error.message != null)
             {
               Fluttertoast.showToast(
                   msg: error.message!,
                   toastLength: Toast.LENGTH_SHORT
               );
             }
           else
             {
               Fluttertoast.showToast(
                   msg: 'something went wrong',
                   toastLength: Toast.LENGTH_SHORT,
               );
             }


      });
     // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }
}
