import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/homescreen.dart';
import 'package:todo/tabs/tasks/custom_text_form_field.dart';
import 'package:todo/tabs/tasks/default_elevated_button.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController =TextEditingController();
  final passwordController =TextEditingController();
  final NameController =TextEditingController();
  final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title:Text(
            'Create Account',style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                SizedBox(height: 35,),
                CustomTextFormField(
                    labelText: 'First Name',
                    controller: NameController,
                  validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return 'First Name can not be empty';
                    }
                    return null;
                  },
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
                  isPassword: true,
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
                ),
                const SizedBox(
                  height: 20,
                ),
                DefaultElevatedButton(
                  onpressed: registre,
                  child: Row(
                    children: [
                      const Spacer(),
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.whitecolor,
                            fontSize: 14
                        ),
                      ),
                      const Spacer(flex: 8,),
                      Icon(Icons.arrow_forward),
                      const Spacer(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: const Text(
                    'Already Have An Account',
                  ),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }

  void registre(){
    if (formKey.currentState?.validate() == true) {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }
}

