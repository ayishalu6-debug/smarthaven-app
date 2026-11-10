import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const new({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool ispasswordvisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('register form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
            SizedBox(height: 3),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Adress',
              ),
            ),
            SizedBox(height: 3),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Phone',
              ),
            ),
            SizedBox(height: 3),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            SizedBox(height: 3),
            TextFormField(
              obscureText: !ispasswordvisible,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      ispasswordvisible = !ispasswordvisible;
                    });
                  },
                  icon: Icon(
                    ispasswordvisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}
