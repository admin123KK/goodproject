import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text(
          'Pick Up Lines',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 181, 7, 7),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Column(
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 250,
                    width: 350,
                    decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1702750722257-6bc38db1267a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),fit: BoxFit.cover,),
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(24),
                    ),
                
                    child: const Center(child: Text('"Hello Namste Nepal"',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                    ),
                  
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 250,
                    width: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1702594369985-163331c12097?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),fit: BoxFit.cover),
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(24)),
                    child: const Center(
                      child: Text('"Hello Namste Nepal"',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 250,
                    width: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1682687218147-9806132dc697?q=80&w=1975&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.green,
                    ),
                    child: const Center(
                      child: Text('"Hello Namste Nepal"',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 250,
                    width: 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1611516491426-03025e6043c8?q=80&w=1933&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),fit: BoxFit.cover),
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Center(child: Text('"Hello Namste Nepal"',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      drawer: Drawer(),
    );
  }
}
