
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool ispasswordvisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          'Login Screen',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.account_circle,
              size: 90,
              color: Colors.red,
            ),

            SizedBox(height: 20),

            Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Username',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Enter username',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: TextFormField(
                    obscureText: !ispasswordvisible,

                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),

                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            ispasswordvisible =
                                !ispasswordvisible;
                          });
                        },

                        icon: Icon(
                          ispasswordvisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),

                      hintText: 'Enter password',
                      filled: true,
                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: () {},

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
