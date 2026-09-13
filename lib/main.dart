import 'dart:async';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:ui' as ui;
void main() {
  runApp(const StudentAIHub());
}

class StudentAIHub extends StatelessWidget {
  const StudentAIHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudentAI Hub',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
      ),
      home: const WelcomePage(),
    );
  }
}

// ======================================================
// WELCOME PAGE
// ======================================================

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4F46E5),
              Color(0xFF7C3AED),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'StudentAI Hub 🤖',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 5,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage('assets/profile.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Your AI-powered student companion',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 45),
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF4F46E5),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignInPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Get Started →',
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
        ),
      ),
    );
  }
}

// ======================================================
// SIGN IN PAGE
// ======================================================

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 70),
            const Icon(
              Icons.school_rounded,
              size: 75,
              color: Colors.indigo,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome Back 👋',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Sign in to continue to StudentAI Hub',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: passwordController,
              obscureText: hidePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    hidePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: signIn,
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Don't have an account? Create Account",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// HOME PAGE
// ======================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'StudentAI Hub 🤖',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4F46E5),
                    Color(0xFF7C3AED),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello 👋',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Welcome back!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Learn smarter. Create faster. Grow better.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Student Tools',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                HomeFeatureCard(
                  icon: Icons.document_scanner_rounded,
                  title: 'AI Scanner',
                  subtitle: 'Scan documents',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ScannerPage(),
                      ),
                    );
                  },
                ),

                // ================= CAREER =================
                HomeFeatureCard(
                  icon: Icons.work_rounded,
                  title: 'AIML Career',
                  subtitle: 'Career guidance',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CareerPage(),
                      ),
                    );
                  },
                ),

                HomeFeatureCard(
                  icon: Icons.smart_toy_rounded,
                  title: 'AI Prompts',
                  subtitle: 'Useful prompts',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AIPromptsPage(),
                      ),
                    );
                  },
                ),

                // ================= AI POSTERS =================
                HomeFeatureCard(
  icon: Icons.palette_rounded,
  title: 'AI Posters',
  subtitle: 'Create posters',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AIPosterPage(),
      ),
    );
  },
),

                HomeFeatureCard(
                  icon: Icons.menu_book_rounded,
                  title: 'Study AI',
                  subtitle: 'Study smarter',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const StudyPlannerPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 28),
            const Text(
              'Quick Start',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.indigo.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: Colors.indigo,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Text(
                      'Use AI tools to make your student life easier.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (_) {},
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ======================================================
// HOME FEATURE CARD
// ======================================================

class HomeFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const HomeFeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 9,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: Colors.indigo,
                size: 30,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// SCANNER PAGE
// ======================================================

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final ImagePicker _picker = ImagePicker();

  XFile? _selectedImage;
  bool _analyzing = false;
  String _result = '';

  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (image != null && mounted) {
        setState(() {
          _selectedImage = image;
          _result = '';
        });
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not select image: $e'),
        ),
      );
    }
  }

  Future<void> analyzeWithAI() async {
    if (_selectedImage == null) return;

    setState(() {
      _analyzing = true;
      _result = '';
    });

    try {
      final bytes = await _selectedImage!.readAsBytes();

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://127.0.0.1:8000/analyze'),
      );

      final fileName = _selectedImage!.name.toLowerCase();

      MediaType contentType;

      if (fileName.endsWith('.png')) {
        contentType = MediaType('image', 'png');
      } else if (fileName.endsWith('.webp')) {
        contentType = MediaType('image', 'webp');
      } else {
        contentType = MediaType('image', 'jpeg');
      }

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: _selectedImage!.name,
          contentType: contentType,
        ),
      );

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(
        streamedResponse,
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          _result = data['analysis'] ?? 'No analysis received.';
        });
      } else {
        try {
          final data = jsonDecode(response.body);

          setState(() {
            _result =
                'AI Error: ${data['detail'] ?? 'Unknown error'}';
          });
        } catch (_) {
          setState(() {
            _result =
                'AI Error: ${response.statusCode}\n${response.body}';
          });
        }
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _result =
            'Could not connect to AI backend.\n\n'
            'Make sure the backend is running.\n\n'
            'Error: $e';
      });
    } finally {
      if (mounted) {
        setState(() {
          _analyzing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Scanner 🤖'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Scan & Analyze',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Upload a document or photo and let StudentAI Hub analyze it.',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 25),
            Container(
              height: 280,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: _selectedImage == null
                  ? const Center(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.document_scanner_outlined,
                            size: 70,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'No document selected',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        _selectedImage!.path,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) {
                          return const Center(
                            child: Icon(
                              Icons.image,
                              size: 70,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _analyzing
                  ? null
                  : () => pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Take Photo'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _analyzing
                  ? null
                  : () => pickImage(ImageSource.gallery),
              icon: const Icon(Icons.photo_library),
              label: const Text('Choose from Photos'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_selectedImage != null)
              ElevatedButton.icon(
                onPressed:
                    _analyzing ? null : analyzeWithAI,
                icon: _analyzing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.auto_awesome),
                label: Text(
                  _analyzing
                      ? 'Analyzing...'
                      : 'Analyze with AI',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 17,
                  ),
                ),
              ),
            const SizedBox(height: 25),
            if (_result.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.blue.shade50,
                  border: Border.all(
                    color: Colors.blue.shade100,
                  ),
                ),
                child: Text(
                  _result,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// STUDY PLANNER PAGE
// ======================================================

class StudyPlannerPage extends StatefulWidget {
  const StudyPlannerPage({super.key});

  @override
  State<StudyPlannerPage> createState() =>
      _StudyPlannerPageState();
}

class _StudyPlannerPageState
    extends State<StudyPlannerPage> {
  final TextEditingController taskController =
      TextEditingController();

  final List<String> tasks = [];
  final List<bool> completed = [];

  Timer? studyTimer;

  int selectedMinutes = 25;
  int remainingSeconds = 25 * 60;
  bool timerRunning = false;

  void startStudyTimer() {
    if (timerRunning) return;

    setState(() {
      timerRunning = true;
    });

    studyTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (remainingSeconds > 0) {
          if (!mounted) {
            timer.cancel();
            return;
          }

          setState(() {
            remainingSeconds--;
          });
        } else {
          timer.cancel();

          if (!mounted) return;

          setState(() {
            timerRunning = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Study session completed! 🎉',
              ),
            ),
          );
        }
      },
    );
  }

  void pauseStudyTimer() {
    studyTimer?.cancel();

    setState(() {
      timerRunning = false;
    });
  }

  void resetStudyTimer() {
    studyTimer?.cancel();

    setState(() {
      remainingSeconds = selectedMinutes * 60;
      timerRunning = false;
    });
  }

  String getTimerText() {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  void addTask() {
    final task = taskController.text.trim();

    if (task.isEmpty) return;

    setState(() {
      tasks.add(task);
      completed.add(false);
      taskController.clear();
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
      completed.removeAt(index);
    });
  }

  @override
  void dispose() {
    studyTimer?.cancel();
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final completedCount =
        completed.where((item) => item).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Planner 📚'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'My Study Plan',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add your study tasks and stay organized.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4F46E5),
                    Color(0xFF7C3AED),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${DateTime.now().day}/'
                          '${DateTime.now().month}/'
                          '${DateTime.now().year}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Stay focused and complete your tasks today 🎯',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (tasks.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.indigo.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$completedCount / ${tasks.length} tasks completed',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: completedCount / tasks.length,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),

            // ================= TIMER =================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF312E81),
                    Color(0xFF4F46E5),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.timer_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Study Timer',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        getTimerText(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  DropdownButton<int>(
                    value: selectedMinutes,
                    dropdownColor: const Color(0xFF312E81),
                    iconEnabledColor: Colors.white,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    underline: Container(),
                    items: const [
                      DropdownMenuItem<int>(
                        value: 20,
                        child: Text('20 minutes'),
                      ),
                      DropdownMenuItem<int>(
                        value: 25,
                        child: Text('25 minutes'),
                      ),
                      DropdownMenuItem<int>(
                        value: 30,
                        child: Text('30 minutes'),
                      ),
                      DropdownMenuItem<int>(
                        value: 45,
                        child: Text('45 minutes'),
                      ),
                      DropdownMenuItem<int>(
                        value: 60,
                        child: Text('60 minutes'),
                      ),
                    ],
                    onChanged: timerRunning
                        ? null
                        : (value) {
                            if (value == null) return;

                            setState(() {
                              selectedMinutes = value;
                              remainingSeconds = value * 60;
                            });
                          },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: timerRunning
                            ? pauseStudyTimer
                            : startStudyTimer,
                        icon: Icon(
                          timerRunning
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                        ),
                        label: Text(
                          timerRunning
                              ? 'Pause'
                              : 'Start',
                        ),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton.icon(
                        onPressed: resetStudyTimer,
                        icon: const Icon(
                          Icons.restart_alt_rounded,
                        ),
                        label: const Text('Reset'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================= ADD TASK =================

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      hintText: 'Enter study task',
                      prefixIcon:
                          const Icon(Icons.task_alt),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),
                    onSubmitted: (_) => addTask(),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 55,
                  width: 55,
                  child: ElevatedButton(
                    onPressed: addTask,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ================= TASK LIST =================

            if (tasks.isEmpty)
              const Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu_book_rounded,
                        size: 70,
                        color: Colors.indigo,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'No study tasks yet',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Add your first task above.',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin:
                          const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: ListTile(
                        leading: Checkbox(
                          value: completed[index],
                          onChanged: (value) {
                            setState(() {
                              completed[index] =
                                  value ?? false;
                            });
                          },
                        ),
                        title: Text(
                          tasks[index],
                          style: TextStyle(
                            fontWeight:
                                FontWeight.w600,
                            decoration:
                                completed[index]
                                    ? TextDecoration
                                        .lineThrough
                                    : TextDecoration.none,
                            color:
                                completed[index]
                                    ? Colors.grey
                                    : Colors.black,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                          onPressed: () =>
                              deleteTask(index),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// AI PROMPTS PAGE
// ======================================================

class AIPromptsPage extends StatefulWidget {
  const AIPromptsPage({super.key});

  @override
  State<AIPromptsPage> createState() =>
      _AIPromptsPageState();
}

class _AIPromptsPageState
    extends State<AIPromptsPage> {
  final TextEditingController searchController =
      TextEditingController();

  String selectedCategory = 'All';

  final List<Map<String, String>> prompts = [
    {
      'category': 'Study',
      'title': 'Master Any Topic',
      'icon': '📚',
      'prompt':
          'Act as an expert teacher. Explain [TOPIC] in simple student-friendly language. Start with the basics, then explain the concept step by step with real-life examples. Highlight important points, common mistakes, and finish with a short revision summary.',
    },
    {
      'category': 'Study',
      'title': 'Difficult Concept Simplifier',
      'icon': '🧠',
      'prompt':
          'I find [TOPIC] difficult. Teach it to me like a beginner. Use simple words, analogies, examples, and a step-by-step explanation. Then give me 5 questions to check my understanding.',
    },
    {
      'category': 'Study',
      'title': 'Chapter Notes Maker',
      'icon': '📖',
      'prompt':
          'Create well-organized study notes for [CHAPTER]. Include definitions, important concepts, examples, formulas if applicable, key points, common mistakes, and a quick revision section.',
    },
    {
      'category': 'Study',
      'title': 'Active Recall Tutor',
      'icon': '🔄',
      'prompt':
          'Help me learn [TOPIC] using active recall. First give me a short explanation, then ask me questions one at a time without immediately showing the answer. After I answer, evaluate my response and explain what I missed.',
    },
    {
      'category': 'Study',
      'title': 'Real-Life Example Teacher',
      'icon': '🌍',
      'prompt':
          'Explain [TOPIC] using 3 simple real-life examples. For each example, connect it clearly to the actual concept and explain why the example helps me understand it.',
    },
    {
      'category': 'Study',
      'title': 'Quick Revision Coach',
      'icon': '⚡',
      'prompt':
          'Give me a quick revision of [TOPIC]. Include the most important concepts, definitions, formulas, examples, common mistakes, and 10 key points I should remember before an exam.',
    },
    {
      'category': 'Assignment',
      'title': 'Assignment Planner',
      'icon': '📝',
      'prompt':
          'Help me plan my assignment on [TOPIC]. Break it into clear steps, suggest what I should research, create a logical structure, and give me a completion checklist.',
    },
    {
      'category': 'Assignment',
      'title': 'Research Guide',
      'icon': '🔎',
      'prompt':
          'Help me research [TOPIC] for a student assignment. Give me the important subtopics I should study, useful questions to investigate, and a logical order for presenting my findings.',
    },
    {
      'category': 'Assignment',
      'title': 'Presentation Builder',
      'icon': '🎤',
      'prompt':
          'Create a classroom presentation plan about [TOPIC]. Give me a slide-by-slide structure, key points for every slide, examples, and a short speaking guide for each section.',
    },
    {
      'category': 'Assignment',
      'title': 'Assignment Reviewer',
      'icon': '✅',
      'prompt':
          'Review my assignment about [TOPIC]. Check the organization, clarity, missing important points, grammar, and logical flow. Give constructive suggestions without changing my original ideas unnecessarily.',
    },
    {
      'category': 'Assignment',
      'title': 'Question Generator',
      'icon': '❓',
      'prompt':
          'Create questions that my teacher could ask about my assignment on [TOPIC]. Include basic, conceptual, application-based, and challenging questions with brief guidance on what a good answer should contain.',
    },
    {
      'category': 'Assignment',
      'title': 'Project Report Structure',
      'icon': '📄',
      'prompt':
          'Create a professional student project report structure for [PROJECT TOPIC]. Include introduction, problem statement, objectives, methodology, implementation, results, limitations, conclusion, and future scope.',
    },
    {
      'category': 'Coding',
      'title': 'Debug My Code',
      'icon': '🐛',
      'prompt':
          'Act as a programming mentor. Analyze my [LANGUAGE] code carefully. Identify errors, explain why they occur, provide corrected code, and explain every important change step by step.',
    },
    {
      'category': 'Coding',
      'title': 'Explain Code Line-by-Line',
      'icon': '💻',
      'prompt':
          'Explain the following [LANGUAGE] code line by line in beginner-friendly language. Explain what each important line does, why it is needed, and how the overall program works.',
    },
    {
      'category': 'Coding',
      'title': 'Code Optimizer',
      'icon': '⚡',
      'prompt':
          'Review my [LANGUAGE] code and suggest ways to make it cleaner, more efficient, readable, and maintainable. Explain the reason behind every suggested improvement.',
    },
    {
      'category': 'Coding',
      'title': 'Test Case Generator',
      'icon': '🧪',
      'prompt':
          'Create test cases for my [PROGRAM/PROJECT]. Include normal cases, edge cases, invalid inputs, and expected outputs. Explain what each test case is checking.',
    },
    {
      'category': 'Coding',
      'title': 'Project Idea Builder',
      'icon': '🚀',
      'prompt':
          'Suggest 5 practical student projects using [TECHNOLOGY]. For each project give the problem it solves, main features, technologies required, difficulty level, and future improvement ideas.',
    },
    {
      'category': 'Coding',
      'title': 'Coding Learning Roadmap',
      'icon': '🗺️',
      'prompt':
          'Create a beginner-to-intermediate learning roadmap for [PROGRAMMING LANGUAGE/TECHNOLOGY]. Give me the correct learning order, important concepts, practice exercises, mini projects, and milestones.',
    },
    {
      'category': 'Exam',
      'title': 'Last-Minute Revision',
      'icon': '🎯',
      'prompt':
          'I have an exam on [SUBJECT] soon. Create a focused revision plan covering the most important concepts first. Include quick explanations, key points, likely questions, and a final rapid-revision checklist.',
    },
    {
      'category': 'Exam',
      'title': 'Mock Test Generator',
      'icon': '📋',
      'prompt':
          'Create a mock test for [SUBJECT/TOPIC]. Include easy, medium, and difficult questions. Mix multiple-choice, short-answer, and long-answer questions. Give the answer key at the end.',
    },
    {
      'category': 'Exam',
      'title': 'Viva Preparation',
      'icon': '🎓',
      'prompt':
          'Prepare me for a viva on [TOPIC]. Ask questions one at a time, starting with basic concepts and gradually becoming harder. After each answer, evaluate it and explain how I can improve.',
    },
    {
      'category': 'Exam',
      'title': 'Important Questions Finder',
      'icon': '⭐',
      'prompt':
          'For [SUBJECT/CHAPTER], identify the concepts most important for exam preparation. Create a list of probable question types and explain why each topic is important to understand.',
    },
    {
      'category': 'Exam',
      'title': 'Answer Writing Coach',
      'icon': '✍️',
      'prompt':
          'Teach me how to write a high-quality exam answer for [QUESTION]. Show me how to structure the answer, what key points to include, how to use examples, and how to make the explanation clear.',
    },
    {
      'category': 'Exam',
      'title': '7-Day Exam Planner',
      'icon': '📅',
      'prompt':
          'Create a 7-day preparation plan for my [SUBJECT] exam. Divide the syllabus into manageable sections and include learning, revision, practice questions, mock tests, and rest periods.',
    },
    {
      'category': 'Career',
      'title': 'Career Roadmap',
      'icon': '🧭',
      'prompt':
          'Create a beginner-friendly career roadmap for becoming a [CAREER]. Include important skills, technologies, learning order, practical projects, portfolio ideas, and interview preparation.',
    },
    {
      'category': 'Career',
      'title': 'Skill Gap Analyzer',
      'icon': '📊',
      'prompt':
          'I want to become a [CAREER]. Help me identify the skills I should learn, organize them into beginner, intermediate, and advanced levels, and create a practical plan to improve each skill.',
    },
    {
      'category': 'Career',
      'title': 'Interview Practice',
      'icon': '💼',
      'prompt':
          'Act as an interviewer for a beginner applying for a [ROLE]. Ask realistic interview questions one at a time. After each answer, give constructive feedback and explain how I can improve.',
    },
    {
      'category': 'Career',
      'title': 'Portfolio Project Ideas',
      'icon': '🏆',
      'prompt':
          'Suggest 5 portfolio projects suitable for a student interested in [CAREER]. For each project explain the problem, features, technologies, difficulty, and what skill it demonstrates to recruiters.',
    },
    {
      'category': 'Career',
      'title': 'Learning Path Builder',
      'icon': '📈',
      'prompt':
          'Create a practical learning path for [CAREER/TECHNOLOGY]. Tell me what to learn first, what to learn next, what I should practice, and which projects I should build to demonstrate my skills.',
    },
    {
      'category': 'Career',
      'title': 'Career Options Explorer',
      'icon': '🔭',
      'prompt':
          'I am interested in [FIELD]. Explain the different career paths available in this field, the skills required for each, typical beginner projects, and how I can decide which path suits my interests.',
    },
  ];

  List<Map<String, String>> get filteredPrompts {
    final query = searchController.text.toLowerCase();

    return prompts.where((prompt) {
      final matchesCategory =
          selectedCategory == 'All' ||
          prompt['category'] == selectedCategory;

      final matchesSearch =
          prompt['title']!
              .toLowerCase()
              .contains(query) ||
          prompt['prompt']!
              .toLowerCase()
              .contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  Future<void> copyPrompt(String prompt) async {
    await Clipboard.setData(
      ClipboardData(text: prompt),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Prompt copied! 📋'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      'All',
      'Study',
      'Assignment',
      'Coding',
      'Exam',
      'Career',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Prompts 🤖'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              10,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Smart Prompt Library',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Better prompts → better AI results 🚀',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: searchController,
                  onChanged: (_) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: 'Search prompts...',
                    prefixIcon:
                        const Icon(Icons.search),
                    suffixIcon:
                        searchController.text.isNotEmpty
                            ? IconButton(
                                icon:
                                    const Icon(Icons.clear),
                                onPressed: () {
                                  searchController.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder:
                        (_, __) =>
                            const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category =
                          categories[index];

                      return ChoiceChip(
                        label: Text(category),
                        selected:
                            selectedCategory ==
                                category,
                        onSelected: (_) {
                          setState(() {
                            selectedCategory =
                                category;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredPrompts.isEmpty
                ? const Center(
                    child: Text(
                      'No prompts found 🔍',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      8,
                      20,
                      20,
                    ),
                    itemCount:
                        filteredPrompts.length,
                    itemBuilder: (context, index) {
                      final item =
                          filteredPrompts[index];

                      return Card(
                        margin:
                            const EdgeInsets.only(
                          bottom: 14,
                        ),
                        elevation: 2,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.all(17),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration:
                                        BoxDecoration(
                                      color: Colors.indigo
                                          .withValues(
                                        alpha: 0.08,
                                      ),
                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                        14,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        item['icon']!,
                                        style:
                                            const TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                      children: [
                                        Text(
                                          item['title']!,
                                          style:
                                              const TextStyle(
                                            fontSize: 18,
                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          item['category']!,
                                          style:
                                              const TextStyle(
                                            color:
                                                Colors.indigo,
                                            fontSize: 13,
                                            fontWeight:
                                                FontWeight
                                                    .w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.all(
                                  13,
                                ),
                                decoration:
                                    BoxDecoration(
                                  color: Colors.grey
                                      .withValues(
                                    alpha: 0.08,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(
                                    12,
                                  ),
                                ),
                                child: Text(
                                  item['prompt']!,
                                  style:
                                      const TextStyle(
                                    fontSize: 14,
                                    height: 1.45,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child:
                                    ElevatedButton.icon(
                                  onPressed: () {
                                    copyPrompt(
                                      item['prompt']!,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.copy_rounded,
                                  ),
                                  label: const Text(
                                    'Copy Prompt',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// NOTICES PAGE
// ======================================================

class Notice {
  String title;
  String description;
  String date;
  bool important;

  Notice({
    required this.title,
    required this.description,
    required this.date,
    this.important = false,
  });
}

class NoticesPage extends StatefulWidget {
  const NoticesPage({super.key});

  @override
  State<NoticesPage> createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  bool isAdmin = true;

  final List<Notice> notices = [
    Notice(
      title: 'Welcome to StudentAI Hub',
      description:
          'Welcome! Check this section regularly for important student updates.',
      date: 'Today',
      important: true,
    ),
    Notice(
      title: 'Assignment Submission',
      description:
          'Students are requested to submit their assignments before the deadline.',
      date: '11 Sep 2026',
    ),
    Notice(
      title: 'Upcoming Exam',
      description:
          'Please check your official timetable for examination details.',
      date: '10 Sep 2026',
      important: true,
    ),
  ];

  void showAddNoticeDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    bool important = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Add New Notice'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Notice Title',
                        prefixIcon: Icon(Icons.title),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Notice Details',
                        prefixIcon:
                            Icon(Icons.description),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Important Notice',
                      ),
                      value: important,
                      onChanged: (value) {
                        setDialogState(() {
                          important =
                              value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final title =
                        titleController.text.trim();
                    final description =
                        descriptionController.text.trim();

                    if (title.isEmpty ||
                        description.isEmpty) {
                      return;
                    }

                    setState(() {
                      notices.insert(
                        0,
                        Notice(
                          title: title,
                          description: description,
                          date: 'Today',
                          important: important,
                        ),
                      );
                    });

                    Navigator.pop(context);

                    ScaffoldMessenger.of(this.context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Notice added successfully! 📢',
                        ),
                      ),
                    );
                  },
                  child: const Text('Add Notice'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void deleteNotice(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Notice?'),
          content: const Text(
            'Are you sure you want to delete this notice?',
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  notices.removeAt(index);
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(this.context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text('Notice deleted'),
                  ),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void editNotice(int index) {
    final notice = notices[index];

    final titleController =
        TextEditingController(text: notice.title);

    final descriptionController =
        TextEditingController(
      text: notice.description,
    );

    bool important = notice.important;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Notice'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Notice Title',
                        prefixIcon: Icon(Icons.title),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Notice Details',
                        prefixIcon:
                            Icon(Icons.description),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Important Notice',
                      ),
                      value: important,
                      onChanged: (value) {
                        setDialogState(() {
                          important =
                              value ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text
                            .trim()
                            .isEmpty ||
                        descriptionController.text
                            .trim()
                            .isEmpty) {
                      return;
                    }

                    setState(() {
                      notice.title =
                          titleController.text.trim();
                      notice.description =
                          descriptionController.text
                              .trim();
                      notice.important = important;
                    });

                    Navigator.pop(context);

                    ScaffoldMessenger.of(this.context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Notice updated successfully! ✏️',
                        ),
                      ),
                    );
                  },
                  child:
                      const Text('Save Changes'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notices 📢',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: isAdmin
            ? [
                IconButton(
                  tooltip: 'Add Notice',
                  icon: const Icon(
                    Icons.add_circle_outline,
                  ),
                  onPressed: showAddNoticeDialog,
                ),
              ]
            : null,
      ),
      body: notices.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none_rounded,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'No notices available',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notices.length,
              itemBuilder: (context, index) {
                final notice = notices[index];

                return Card(
                  margin:
                      const EdgeInsets.only(bottom: 14),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.all(
                                12,
                              ),
                              decoration:
                                  BoxDecoration(
                                color: notice.important
                                    ? Colors.red.shade50
                                    : Colors.indigo
                                        .shade50,
                                borderRadius:
                                    BorderRadius
                                        .circular(14),
                              ),
                              child: Icon(
                                notice.important
                                    ? Icons
                                        .priority_high_rounded
                                    : Icons
                                        .notifications_rounded,
                                color: notice.important
                                    ? Colors.red
                                    : Colors.indigo,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  Text(
                                    notice.title,
                                    style:
                                        const TextStyle(
                                      fontSize: 17,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons
                                            .calendar_today,
                                        size: 14,
                                        color:
                                            Colors.grey,
                                      ),
                                      const SizedBox(
                                          width: 5),
                                      Text(
                                        notice.date,
                                        style:
                                            const TextStyle(
                                          color:
                                              Colors.grey,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (notice.important)
                              Container(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal: 8,
                                  vertical: 5,
                                ),
                                decoration:
                                    BoxDecoration(
                                  color:
                                      Colors.red.shade50,
                                  borderRadius:
                                      BorderRadius
                                          .circular(10),
                                ),
                                child: const Text(
                                  'IMPORTANT',
                                  style:
                                      TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          notice.description,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),
                        if (isAdmin) ...[
                          const SizedBox(height: 14),
                          const Divider(),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  editNotice(index);
                                },
                                icon: const Icon(
                                  Icons.edit_outlined,
                                ),
                                label:
                                    const Text('Edit'),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  deleteNotice(index);
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                label: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: isAdmin
          ? FloatingActionButton.extended(
              onPressed: showAddNoticeDialog,
              icon: const Icon(Icons.add),
              label: const Text('Add Notice'),
            )
          : null,
    );
  }
}

// ======================================================
// CAREER PAGE
// ======================================================

class CareerPage extends StatelessWidget {
  const CareerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AIML Career 🚀',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4F46E5),
                    Color(0xFF7C3AED),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius:
                    BorderRadius.circular(22),
              ),
              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    color: Colors.white,
                    size: 42,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Build Your AI Career',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Explore AIML skills, career paths and projects.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Career Paths',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _careerCard(
              icon: Icons.psychology_rounded,
              title: 'Machine Learning Engineer',
              description:
                  'Learn Python, mathematics, ML algorithms and model building.',
            ),

            _careerCard(
              icon: Icons.smart_toy_rounded,
              title: 'AI Engineer',
              description:
                  'Build intelligent applications using AI models and APIs.',
            ),

            _careerCard(
              icon: Icons.analytics_rounded,
              title: 'Data Scientist',
              description:
                  'Work with data, statistics, visualization and machine learning.',
            ),

            _careerCard(
              icon: Icons.visibility_rounded,
              title: 'Computer Vision Engineer',
              description:
                  'Build AI systems that understand images and videos.',
            ),

            _careerCard(
              icon: Icons.language_rounded,
              title: 'NLP Engineer',
              description:
                  'Work with language models, text processing and chatbots.',
            ),

            const SizedBox(height: 25),

            const Text(
              'Skills to Learn',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                Chip(
                  avatar:
                      Icon(Icons.code, size: 18),
                  label: Text('Python'),
                ),
                Chip(
                  avatar:
                      Icon(Icons.functions, size: 18),
                  label: Text('Maths'),
                ),
                Chip(
                  avatar:
                      Icon(Icons.data_object, size: 18),
                  label: Text('Data'),
                ),
                Chip(
                  avatar:
                      Icon(Icons.psychology, size: 18),
                  label: Text('Machine Learning'),
                ),
                Chip(
                  avatar:
                      Icon(Icons.smart_toy, size: 18),
                  label: Text('Deep Learning'),
                ),
                Chip(
                  avatar:
                      Icon(Icons.auto_awesome, size: 18),
                  label: Text('Generative AI'),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              'Recommended Roadmap',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _roadmapStep(
              number: '1',
              title: 'Learn Python',
              description:
                  'Variables, functions, OOP, libraries and problem solving.',
            ),

            _roadmapStep(
              number: '2',
              title: 'Learn Mathematics',
              description:
                  'Statistics, probability, linear algebra and basic calculus.',
            ),

            _roadmapStep(
              number: '3',
              title: 'Learn Machine Learning',
              description:
                  'Understand supervised, unsupervised and evaluation techniques.',
            ),

            _roadmapStep(
              number: '4',
              title: 'Build Projects',
              description:
                  'Create practical AI projects and add them to your portfolio.',
            ),

            _roadmapStep(
              number: '5',
              title: 'Learn Advanced AI',
              description:
                  'Explore deep learning, NLP, computer vision and GenAI.',
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _careerCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.indigo.withValues(alpha: 0.1),
              borderRadius:
                  BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: Colors.indigo,
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _roadmapStep({
    required String number,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.indigo,
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// ======================================================
// AI POSTER CREATION PAGE
// ======================================================

class AIPosterPage extends StatefulWidget {
  const AIPosterPage({super.key});

  @override
  State<AIPosterPage> createState() => _AIPosterPageState();
}

class _AIPosterPageState extends State<AIPosterPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();

  final GlobalKey posterKey = GlobalKey();

  String selectedTheme = 'Modern';

  bool generating = false;
  bool generated = false;
  bool exporting = false;

  final List<String> themes = [
    'Modern',
    'Education',
    'Technology',
    'Motivational',
    'AIML',
    'Event',
  ];

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    super.dispose();
  }

  void generatePoster() {
    final title = titleController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a poster title'),
        ),
      );
      return;
    }

    setState(() {
      generating = true;
      generated = false;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      setState(() {
        generating = false;
        generated = true;
      });
    });
  }

  Future<void> exportPoster() async {
    if (!generated) return;

    setState(() {
      exporting = true;
    });

    try {
      await Future.delayed(const Duration(milliseconds: 200));

      final boundary =
          posterKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;

      if (boundary == null) {
        throw Exception('Poster not ready');
      }

      final ui.Image image = await boundary.toImage(
        pixelRatio: 3.0,
      );

      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) {
        throw Exception('Could not create PNG');
      }

      final Uint8List pngBytes =
          byteData.buffer.asUint8List();

      final blob = html.Blob(
        [pngBytes],
        'image/png',
      );

      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute(
          'download',
          'student_ai_poster.png',
        )
        ..click();

      html.Url.revokeObjectUrl(url);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Poster exported successfully! 🎉'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not export poster'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          exporting = false;
        });
      }
    }
  }

  void clearPoster() {
    setState(() {
      generated = false;
      titleController.clear();
      subtitleController.clear();
      selectedTheme = 'Modern';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Poster Creator 🎨',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4F46E5),
                    Color(0xFF7C3AED),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    color: Colors.white,
                    size: 42,
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Create Amazing Posters',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Design beautiful posters for school, projects and events.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Poster Details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Poster Title',
                hintText: 'Example: AI Workshop 2026',
                prefixIcon: const Icon(Icons.title_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: subtitleController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText:
                    'Add some information about your poster...',
                prefixIcon:
                    const Icon(Icons.description_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Choose Theme',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: themes.map((theme) {
                return ChoiceChip(
                  label: Text(theme),
                  selected: selectedTheme == theme,
                  onSelected: (value) {
                    setState(() {
                      selectedTheme = theme;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed:
                    generating ? null : generatePoster,
                icon: generating
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.auto_awesome_rounded,
                      ),
                label: Text(
                  generating
                      ? 'Creating Poster...'
                      : 'Generate Poster',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            if (generated) ...[
              const Text(
                'Poster Preview',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              RepaintBoundary(
                key: posterKey,
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    minHeight: 400,
                  ),
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient: _getGradient(),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.auto_awesome_rounded,
                        color: Colors.white,
                        size: 55,
                      ),

                      const SizedBox(height: 30),

                      Text(
                        titleController.text.trim(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),

                      if (subtitleController.text
                          .trim()
                          .isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Text(
                          subtitleController.text.trim(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 17,
                            height: 1.5,
                          ),
                        ),
                      ],

                      const SizedBox(height: 30),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius:
                              BorderRadius.circular(30),
                        ),
                        child: Text(
                          selectedTheme,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 35),

                      const Text(
                        'StudentAI Hub',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed:
                      exporting ? null : exportPoster,
                  icon: exporting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(
                          Icons.download_rounded,
                        ),
                  label: Text(
                    exporting
                        ? 'Exporting...'
                        : 'Export Poster as PNG',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: clearPoster,
                  icon: const Icon(
                    Icons.refresh_rounded,
                  ),
                  label: const Text('Create New'),
                  style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }

  LinearGradient _getGradient() {
    switch (selectedTheme) {
      case 'Education':
        return const LinearGradient(
          colors: [
            Color(0xFF2563EB),
            Color(0xFF06B6D4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

      case 'Technology':
        return const LinearGradient(
          colors: [
            Color(0xFF111827),
            Color(0xFF4F46E5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

      case 'Motivational':
        return const LinearGradient(
          colors: [
            Color(0xFFEA580C),
            Color(0xFFDB2777),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

      case 'AIML':
        return const LinearGradient(
          colors: [
            Color(0xFF7C3AED),
            Color(0xFF2563EB),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

      case 'Event':
        return const LinearGradient(
          colors: [
            Color(0xFF059669),
            Color(0xFF0D9488),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

      default:
        return const LinearGradient(
          colors: [
            Color(0xFF4F46E5),
            Color(0xFF7C3AED),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }
}