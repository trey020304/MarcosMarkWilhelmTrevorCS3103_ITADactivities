import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My CV',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  // Hardcoded credentials
  final String _correctUsername = "Trevor Marcos";
  final String _correctPassword = "TrevorMarcos2004";

  void _login() {
    if (_formKey.currentState!.validate()) {
      if (_usernameController.text == _correctUsername &&
          _passwordController.text == _correctPassword) {
        // Navigate to CV Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyCvPage()),
        );
      } else {
        // Show error message
        setState(() {
          _errorMessage = "Incorrect username or password. Please try again.";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center everything
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Ensures centered text
              children: [
                // Center the 'Welcome to your Curriculum Vitae!' text
                Text(
                  'Welcome to your Curriculum Vitae!',
                  textAlign: TextAlign.center, // Ensure the text is centered
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 32),
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
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

class MyCvPage extends StatefulWidget {
  @override
  _MyCvPageState createState() => _MyCvPageState();
}

class _MyCvPageState extends State<MyCvPage> {
  File? _profileImage;

  Future<void> _showImageOptions() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Profile Picture Options'),
          content: Text('Choose an action:'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
              child: Text('Choose from Gallery'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
              child: Text('Take Picture'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _profileImage = null;
                });
                Navigator.of(context).pop();
              },
              child: Text('Default Picture'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'My CV',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        backgroundColor: Color(0xFF2196F3),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF2196F3),
              ),
              child: Text(
                'CV Sections',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.circle,
                  color: const Color.fromARGB(255, 114, 114, 114), size: 30),
              title: Text('Education',
                  style: TextStyle(
                    fontSize: 16,
                  )),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EducationPage()));
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.circle,
                  color: const Color.fromARGB(255, 114, 114, 114), size: 30),
              title: Text('Skills', style: TextStyle(fontSize: 16)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SkillsPage()));
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.circle,
                  color: const Color.fromARGB(255, 114, 114, 114), size: 30),
              title: Text('Projects', style: TextStyle(fontSize: 16)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProjectsPage()));
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              leading: Icon(Icons.circle,
                  color: const Color.fromARGB(255, 114, 114, 114), size: 30),
              title: Text('Experience', style: TextStyle(fontSize: 16)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ExperiencePage()));
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _showImageOptions,
                child: ClipOval(
                  child: _profileImage == null
                      ? Image.asset(
                          'assets/trevor.jpg',
                          width: 175,
                          height: 175,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          _profileImage!,
                          width: 175,
                          height: 175,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Trevor Marcos',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '+63 908 136 9112',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 4),
              Text(
                '22-04183@g.bastate-u.edu.ph',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 32),
              Container(
                width: double.infinity,
                height: 200,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'I am a Computer Science student with three years of experience in coding. I am passionate about programming, and I am seeking opportunities towards several fields such as Web and Mobile Development, Data Science, and Game Development.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EducationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Education',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF2196F3),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0), // Add padding around the content
        child: SingleChildScrollView(
          //Scrollable content
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align text to the start
            children: [
              Text(
                'Elementary',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'School:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              Text(
                'Marian Learning Center and Science High School',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 8),
              Text(
                'Year Graduated:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              Text(
                '2015 – 2016',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Secondary',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Junior High School:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              Text(
                'St. Bridget College of Batangas',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 8),
              Text(
                'Year Graduated:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              Text(
                '2019 – 2020',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 8),
              Text(
                'Senior High School:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              Text(
                'Lyceum of the Philippines – Batangas',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 8),
              Text(
                'Year Graduated:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              Text(
                '2021 – 2022',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 16),
              Text(
                'Tertiary',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'School:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              Text(
                'Batangas State University – Alangilan',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 8),
              Text(
                'Year Graduated:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              Text(
                'Currently Enrolled',
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SkillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Skills', style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF2196F3),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the content
        child: SingleChildScrollView(
          //For scrollable content
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align text to the start
            children: [
              Text(
                'Skills in Programming (Hard Skills):',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildBulletPointList([
                'Data structures and algorithms',
                'Object-oriented programming (OOP)',
                'Database and SQL',
                'Web application development',
              ]),
              SizedBox(height: 16),
              Text(
                'Skills in the Development (Soft Skills):',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildBulletPointList([
                'Communication',
                'Teamwork and conflict resolution',
                'Problem solving',
                'Adaptability',
                'Curiosity',
                'Time Management',
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF2196F3),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the content
        child: SingleChildScrollView(
          //For scrollable content
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align text to the start
            children: [
              Text(
                'Created Projects:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildBulletPointList([
                'Dumpster Dash  → video game made from Python',
                'CliniClick → hospital appointment system made from Python',
                'ACICStance Corner App  → systemized documentation app for the CICS Council service made from Visual Studio (C#)',
              ]),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class ExperiencePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Experience',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF2196F3),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the content
        child: SingleChildScrollView(
          //For scrollable content
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align text to the start
            children: [
              Text(
                'Learned Programming Languages:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildBulletPointList([
                'C',
                'C++',
                'C#',
                'Python',
                'Java',
                'JavaScript',
                'HTML and CSS',
                'SQL',
              ]),
              SizedBox(height: 16),
              Text(
                'Project Development Roles:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildBulletPointList([
                'Back-End Developer',
                'Full-Stack Developer',
                'Project Assistant Manager',
                'Software Quality Assurance',
              ]),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

//Method to build a bullet point list
Widget _buildBulletPointList(List<String> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: items
        .map((item) => Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('● $item',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
            ))
        .toList(),
  );
}
