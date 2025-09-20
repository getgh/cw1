import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter and Image Toggle',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  int _counter = 0;
  bool _isImageOne = true;
  bool _isLightTheme = true;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward(from: 1.0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleImage() {
    setState(() {
      _isImageOne = !_isImageOne;
      _animationController.forward(from: 0.0);
    });
  }

  void _toggleTheme() {
    setState(() {
      _isLightTheme = !_isLightTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isLightTheme ? ThemeData.light() : ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Counter and Image Toggle'),
        ),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Counter display with dynamic text color
                  Text(
                    'Counter Value: $_counter',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: _isLightTheme ? Colors.black : Colors.white,
                        ),
                  ),
                  const SizedBox(height: 40),
                  // Image with fade transition
                  FadeTransition(
                    opacity: _animation,
                    child: Image.asset(
                      _isImageOne ? 'assets/image1.png' : 'assets/image2.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Toggle image button
                  ElevatedButton(
                    onPressed: _toggleImage,
                    child: const Text('Toggle Image'),
                  ),
                  const SizedBox(height: 20),
                  // Toggle theme button
                  ElevatedButton(
                    onPressed: _toggleTheme,
                    child: Text(
                      _isLightTheme ? 'Switch to Dark Mode' : 'Switch to Light Mode',
                    ),
                  ),
                ],
              ),
            ),
            // Increment button with plus sign in bottom-left corner
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: _incrementCounter,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}