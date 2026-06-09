import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mock_data.dart';
import 'models.dart';

void main() {
  runApp(const AdaptisApp());
}

class AdaptisApp extends StatelessWidget {
  const AdaptisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ADAPTIS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF12664F),
          primary: const Color(0xFF12664F),
          secondary: const Color(0xFFE07A5F),
          tertiary: const Color(0xFF2E86AB),
          surface: const Color(0xFFF7F8F3),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F8F3),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B4336), Color(0xFF12664F), Color(0xFFE07A5F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo_mark.png', width: 110, errorBuilder: (_, __, ___) => const Icon(Icons.school, size: 96, color: Colors.white)),
            const SizedBox(height: 22),
            const Text('ADAPTIS', style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w900, letterSpacing: 0)),
            const SizedBox(height: 8),
            const Text('Learn sharp, even with poor network.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  int page = 0;

  final items = const [
    _OnboardingItem(Icons.network_check, 'Adaptive lessons', 'ADAPTIS senses Good, Fair or Poor connection and changes the learning mode for you.'),
    _OnboardingItem(Icons.offline_pin, 'Offline learning', 'Download notes and lessons when WiFi is strong, then study later without stress.'),
    _OnboardingItem(Icons.sync, 'Progress sync', 'Your lesson progress, quiz answers and downloads are saved locally and synced when internet returns.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: _finish, child: const Text('Skip')),
              ),
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  onPageChanged: (value) => setState(() => page = value),
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    final item = items[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 132,
                          height: 132,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(.12),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Icon(item.icon, size: 70, color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(height: 34),
                        Text(item.title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 14),
                        Text(item.body, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, height: 1.5, color: Color(0xFF52615B))),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(items.length, (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: page == index ? 28 : 9,
                  height: 9,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: page == index ? Theme.of(context).colorScheme.primary : const Color(0xFFD7DDD6),
                    borderRadius: BorderRadius.circular(99),
                  ),
                )),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: page == items.length - 1 ? _finish : () => controller.nextPage(duration: const Duration(milliseconds: 260), curve: Curves.easeOut),
                  child: Text(page == items.length - 1 ? 'Get started' : 'Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _finish() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AuthShell()));
  }
}

class _OnboardingItem {
  const _OnboardingItem(this.icon, this.title, this.body);
  final IconData icon;
  final String title;
  final String body;
}

class AuthShell extends StatefulWidget {
  const AuthShell({super.key});

  @override
  State<AuthShell> createState() => _AuthShellState();
}

class _AuthShellState extends State<AuthShell> {
  bool login = true;
  bool reset = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 24),
            Image.asset('assets/logo_name.png', height: 82, errorBuilder: (_, __, ___) => const Text('ADAPTIS', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900))),
            const SizedBox(height: 28),
            Text(reset ? 'Reset password' : login ? 'Welcome back' : 'Create account', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(reset ? 'Enter your school email. We will send a reset link.' : 'Use your ADAPTIS school account. Any password works in this demo.', style: const TextStyle(color: Color(0xFF60716A))),
            const SizedBox(height: 24),
            if (!reset && !login) const _RolePicker(),
            const _Input(label: 'Email', icon: Icons.mail_outline),
            if (!reset) const _Input(label: 'Password', icon: Icons.lock_outline, obscure: true),
            if (!reset && !login) const _Input(label: 'School / Institution', icon: Icons.apartment),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                icon: Icon(reset ? Icons.send : login ? Icons.login : Icons.person_add_alt),
                label: Text(reset ? 'Send reset link' : login ? 'Login as Student' : 'Register'),
                onPressed: () {
                  if (reset) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password reset sent. Check your email.')));
                    setState(() => reset = false);
                  } else {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const StudentShell()));
                  }
                },
              ),
            ),
            TextButton(
              onPressed: () => setState(() {
                reset = false;
                login = !login;
              }),
              child: Text(login ? 'New here? Register' : 'Already have an account? Login'),
            ),
            TextButton(onPressed: () => setState(() => reset = true), child: const Text('Forgot password?')),
          ],
        ),
      ),
    );
  }
}

class _RolePicker extends StatefulWidget {
  const _RolePicker();

  @override
  State<_RolePicker> createState() => _RolePickerState();
}

class _RolePickerState extends State<_RolePicker> {
  String role = 'Student';
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(value: 'Student', label: Text('Student'), icon: Icon(Icons.school)),
        ButtonSegment(value: 'Teacher', label: Text('Teacher'), icon: Icon(Icons.co_present)),
      ],
      selected: {role},
      onSelectionChanged: (value) => setState(() => role = value.first),
    );
  }
}

class _Input extends StatelessWidget {
  const _Input({required this.label, required this.icon, this.obscure = false});
  final String label;
  final IconData icon;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

class StudentShell extends StatefulWidget {
  const StudentShell({super.key});

  @override
  State<StudentShell> createState() => _StudentShellState();
}

class _StudentShellState extends State<StudentShell> {
  int index = 0;
  final pages = const [HomeScreen(), CoursesScreen(), DownloadsScreen(), MessagesScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Courses'),
          NavigationDestination(icon: Icon(Icons.download_outlined), selectedIcon: Icon(Icons.download), label: 'Downloads'),
          NavigationDestination(icon: Icon(Icons.chat_outlined), selectedIcon: Icon(Icons.chat), label: 'Messages'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Bonjour, Amina',
      subtitle: 'Learning from Yaounde with Data Saver ready.',
      actions: [
        IconButton(onPressed: () => push(context, const NotificationsScreen()), icon: const Icon(Icons.notifications_outlined)),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NetworkModePanel(compact: false),
          const SizedBox(height: 18),
          Row(
            children: const [
              Expanded(child: StatTile(label: 'Saved local', value: '72%', icon: Icons.save_alt)),
              SizedBox(width: 12),
              Expanded(child: StatTile(label: 'Pending sync', value: '3', icon: Icons.sync_problem)),
            ],
          ),
          const SizedBox(height: 22),
          SectionTitle(title: 'Continue learning', action: 'See all', onTap: () => push(context, const CoursesScreen())),
          const SizedBox(height: 12),
          CourseCard(course: courses.first),
          const SizedBox(height: 22),
          SectionTitle(title: 'Today in ADAPTIS', action: 'Progress', onTap: () => push(context, const ProgressScreen())),
          const SizedBox(height: 12),
          ...notifications.take(3).map((item) => InfoRow(icon: Icons.bolt, text: item)),
        ],
      ),
    );
  }
}

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'My Courses',
      subtitle: 'Enrolled courses from your school.',
      child: Column(children: courses.map((course) => CourseCard(course: course)).toList()),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => push(context, CourseDetailsScreen(course: course)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundColor: Color(course.colorHex), child: const Icon(Icons.school, color: Colors.white)),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(course.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    Text('${course.teacher} - ${course.location}', style: const TextStyle(color: Color(0xFF60716A))),
                  ])),
                ],
              ),
              const SizedBox(height: 14),
              LinearProgressIndicator(value: course.progress, minHeight: 8, borderRadius: BorderRadius.circular(99)),
              const SizedBox(height: 8),
              Text('${(course.progress * 100).round()}% completed - ${course.modules} modules', style: const TextStyle(color: Color(0xFF60716A))),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key, required this.course});
  final Course course;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: course.title,
      subtitle: '${course.teacher} - ${course.location}',
      back: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NetworkModePanel(compact: true),
          const SizedBox(height: 18),
          SectionTitle(title: 'Modules and lessons', action: 'Download all', onTap: () => toast(context, 'Download queued for strong WiFi.')),
          const SizedBox(height: 10),
          ...course.lessons.map((lesson) => LessonTile(course: course, lesson: lesson)),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ActionChip(avatar: const Icon(Icons.quiz), label: const Text('Quizzes'), onPressed: () => push(context, const QuizListScreen())),
              ActionChip(avatar: const Icon(Icons.assignment), label: const Text('Assignments'), onPressed: () => push(context, const AssignmentScreen())),
              ActionChip(avatar: const Icon(Icons.show_chart), label: const Text('Progress'), onPressed: () => push(context, const ProgressScreen())),
            ],
          ),
        ],
      ),
    );
  }
}

class LessonTile extends StatelessWidget {
  const LessonTile({super.key, required this.course, required this.lesson});
  final Course course;
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        leading: Icon(lesson.downloaded ? Icons.offline_pin : Icons.play_circle_outline, color: Theme.of(context).colorScheme.primary),
        title: Text(lesson.title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text('${lesson.duration} - ${lesson.summary}'),
        trailing: IconButton(icon: const Icon(Icons.download_outlined), onPressed: () => toast(context, 'Lesson saved for offline access.')),
        onTap: () => push(context, LessonPlayerScreen(course: course, lesson: lesson)),
      ),
    );
  }
}

class LessonPlayerScreen extends StatefulWidget {
  const LessonPlayerScreen({super.key, required this.course, required this.lesson});
  final Course course;
  final Lesson lesson;

  @override
  State<LessonPlayerScreen> createState() => _LessonPlayerScreenState();
}

class _LessonPlayerScreenState extends State<LessonPlayerScreen> {
  String quality = 'Good';
  bool dataSaver = false;
  double progress = .42;

  String get mode {
    if (dataSaver) return 'Audio + Text';
    if (quality == 'Good') return 'HD Video';
    if (quality == 'Fair') return 'SD Video';
    return 'Audio + Text';
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: widget.lesson.title,
      subtitle: widget.course.title,
      back: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 210,
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: mode == 'Audio + Text' ? const Color(0xFFFFF4E8) : const Color(0xFF102E27),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(mode == 'Audio + Text' ? Icons.headphones : Icons.play_circle_fill, color: mode == 'Audio + Text' ? const Color(0xFFE07A5F) : Colors.white, size: 66),
                const SizedBox(height: 12),
                Text(mode, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: mode == 'Audio + Text' ? const Color(0xFF6E3B22) : Colors.white)),
                Text('Simulated adaptive player', style: TextStyle(color: mode == 'Audio + Text' ? const Color(0xFF8E5E43) : Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('Connection quality', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'Good', label: Text('Good'), icon: Icon(Icons.signal_cellular_alt)),
              ButtonSegment(value: 'Fair', label: Text('Fair'), icon: Icon(Icons.network_cell)),
              ButtonSegment(value: 'Poor', label: Text('Poor'), icon: Icon(Icons.signal_cellular_connected_no_internet_0_bar)),
            ],
            selected: {quality},
            onSelectionChanged: (value) => setState(() => quality = value.first),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Data Saver mode'),
            subtitle: const Text('Force audio and text to save mobile data.'),
            value: dataSaver,
            onChanged: (value) => setState(() => dataSaver = value),
          ),
          const SizedBox(height: 8),
          Text(widget.lesson.text, style: const TextStyle(fontSize: 16, height: 1.5)),
          const SizedBox(height: 18),
          LinearProgressIndicator(value: progress, minHeight: 9, borderRadius: BorderRadius.circular(99)),
          const SizedBox(height: 10),
          FilledButton.icon(
            icon: const Icon(Icons.save),
            label: const Text('Save progress locally'),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setDouble('lessonProgress:${widget.lesson.id}', progress);
              if (context.mounted) toast(context, 'Progress saved locally. Pending sync when network returns.');
            },
          ),
        ],
      ),
    );
  }
}

class NetworkModePanel extends StatefulWidget {
  const NetworkModePanel({super.key, required this.compact});
  final bool compact;

  @override
  State<NetworkModePanel> createState() => _NetworkModePanelState();
}

class _NetworkModePanelState extends State<NetworkModePanel> {
  String quality = 'Fair';
  bool dataSaver = false;

  @override
  Widget build(BuildContext context) {
    final mode = dataSaver ? 'Audio + Text' : quality == 'Good' ? 'HD Video' : quality == 'Fair' ? 'SD Video' : 'Audio + Text';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF102E27), borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.wifi_tethering, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(child: Text('$quality network - $mode', style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800))),
            ],
          ),
          if (!widget.compact) ...[
            const SizedBox(height: 12),
            const Text('Demo control: change quality to show adaptive switching.', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: ['Good', 'Fair', 'Poor'].map((item) => ChoiceChip(
                label: Text(item),
                selected: quality == item,
                onSelected: (_) => setState(() => quality = item),
              )).toList(),
            ),
          ],
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Data Saver', style: TextStyle(color: Colors.white)),
            subtitle: const Text('Best for MTN/Orange mobile data', style: TextStyle(color: Colors.white70)),
            value: dataSaver,
            onChanged: (value) => setState(() => dataSaver = value),
          ),
        ],
      ),
    );
  }
}

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lessons = courses.expand((course) => course.lessons.where((lesson) => lesson.downloaded)).toList();
    return AppScaffold(
      title: 'Downloads',
      subtitle: 'Available offline on this phone.',
      child: Column(
        children: [
          const InfoRow(icon: Icons.storage, text: 'Storage used: 182 MB. Night Shift downloads allowed on strong WiFi.'),
          ...lessons.map((lesson) => Card(
            elevation: 0,
            color: Colors.white,
            child: ListTile(
              leading: const Icon(Icons.offline_pin, color: Color(0xFF12664F)),
              title: Text(lesson.title),
              subtitle: const Text('Ready with zero internet'),
              trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => toast(context, 'Offline item removed from demo list.')),
            ),
          )),
        ],
      ),
    );
  }
}

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Quizzes',
      subtitle: 'Practice and sync results later.',
      back: true,
      child: Column(
        children: [
          Card(
            elevation: 0,
            color: Colors.white,
            child: ListTile(
              leading: const Icon(Icons.quiz, color: Color(0xFF12664F)),
              title: const Text('Adaptive Learning Basics'),
              subtitle: const Text('3 questions - saved offline if needed'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => push(context, const QuizAttemptScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizAttemptScreen extends StatefulWidget {
  const QuizAttemptScreen({super.key});

  @override
  State<QuizAttemptScreen> createState() => _QuizAttemptScreenState();
}

class _QuizAttemptScreenState extends State<QuizAttemptScreen> {
  final answers = <int, int>{};

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Quiz Attempt',
      subtitle: 'Answers save locally during poor network.',
      back: true,
      child: Column(
        children: [
          for (var i = 0; i < quizQuestions.length; i++)
            Card(
              elevation: 0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${i + 1}. ${quizQuestions[i].question}', style: const TextStyle(fontWeight: FontWeight.w800)),
                    ...List.generate(quizQuestions[i].options.length, (optionIndex) => RadioListTile<int>(
                      value: optionIndex,
                      groupValue: answers[i],
                      onChanged: (value) => setState(() => answers[i] = value ?? 0),
                      title: Text(quizQuestions[i].options[optionIndex]),
                    )),
                  ],
                ),
              ),
            ),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              icon: const Icon(Icons.done_all),
              label: const Text('Submit quiz'),
              onPressed: answers.length == quizQuestions.length ? () {
                final score = answers.entries.where((entry) => quizQuestions[entry.key].correctIndex == entry.value).length;
                push(context, QuizResultScreen(score: score));
              } : null,
            ),
          ),
        ],
      ),
    );
  }
}

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({super.key, required this.score});
  final int score;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Quiz Result',
      subtitle: 'Result saved locally and ready to sync.',
      back: true,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
            child: Column(
              children: [
                const Icon(Icons.emoji_events, size: 72, color: Color(0xFFE07A5F)),
                Text('$score/${quizQuestions.length}', style: const TextStyle(fontSize: 44, fontWeight: FontWeight.w900)),
                const Text('Good effort. Your teacher can see this after sync.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Assignment Submission',
      subtitle: 'Submit text or file when ready.',
      back: true,
      child: Column(
        children: [
          const _Input(label: 'Assignment answer', icon: Icons.edit_note),
          const _Input(label: 'Attach file name', icon: Icons.attach_file),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              icon: const Icon(Icons.cloud_upload),
              label: const Text('Submit assignment'),
              onPressed: () => toast(context, 'Assignment saved locally. It will sync when internet returns.'),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Progress Tracking',
      subtitle: 'Course completion and activity history.',
      back: true,
      child: Column(
        children: [
          Row(children: const [
            Expanded(child: StatTile(label: 'Avg progress', value: '50%', icon: Icons.trending_up)),
            SizedBox(width: 12),
            Expanded(child: StatTile(label: 'Completed', value: '8', icon: Icons.check_circle)),
          ]),
          const SizedBox(height: 16),
          ...courses.map((course) => InfoRow(icon: Icons.school, text: '${course.title}: ${(course.progress * 100).round()}% complete')),
        ],
      ),
    );
  }
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Messages',
      subtitle: 'Chat with your teachers.',
      child: Column(
        children: messages.map((message) => Card(
          elevation: 0,
          color: Colors.white,
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(message.name),
            subtitle: Text(message.preview),
            trailing: Text(message.time),
            onTap: () => push(context, ChatScreen(thread: message)),
          ),
        )).toList(),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.thread});
  final MessageThread thread;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: thread.name,
      subtitle: thread.role,
      back: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ChatBubble(text: 'Good evening. I downloaded the notes but my quiz was pending sync.', mine: true),
          ChatBubble(text: 'No problem. Open ADAPTIS when network is back and it will sync.', mine: false),
          const SizedBox(height: 12),
          const _Input(label: 'Write a message', icon: Icons.message_outlined),
          SizedBox(width: double.infinity, child: FilledButton.icon(icon: const Icon(Icons.send), label: const Text('Send'), onPressed: () => toast(context, 'Message queued for delivery.'))),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.text, required this.mine});
  final String text;
  final bool mine;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: mine ? Theme.of(context).colorScheme.primary : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(text, style: TextStyle(color: mine ? Colors.white : const Color(0xFF1D2B26))),
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Notifications',
      subtitle: 'Course alerts and sync updates.',
      back: true,
      child: Column(children: notifications.map((item) => InfoRow(icon: Icons.notifications_active, text: item)).toList()),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Profile',
      subtitle: 'Amina Njoya - Student',
      actions: [
        IconButton(onPressed: () => push(context, const SettingsScreen()), icon: const Icon(Icons.settings_outlined)),
      ],
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
            child: const Row(
              children: [
                CircleAvatar(radius: 34, child: Icon(Icons.person, size: 36)),
                SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Amina Njoya', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  Text('Government Bilingual High School, Yaounde'),
                ])),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const InfoRow(icon: Icons.language, text: 'Language: English. French support planned.'),
          const InfoRow(icon: Icons.security, text: 'Local progress protected in demo storage.'),
          const InfoRow(icon: Icons.data_usage, text: 'Mobile data usage reduced by Data Saver.'),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Settings',
      subtitle: 'Account, storage, language and data.',
      back: true,
      child: Column(
        children: [
          SwitchListTile(title: const Text('Only download on WiFi'), value: true, onChanged: (_) {}),
          SwitchListTile(title: const Text('Queue notifications offline'), value: true, onChanged: (_) {}),
          SwitchListTile(title: const Text('Default Data Saver'), value: false, onChanged: (_) {}),
          ListTile(leading: const Icon(Icons.logout), title: const Text('Logout'), onTap: () => push(context, const AuthShell())),
        ],
      ),
    );
  }
}

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.title, required this.subtitle, required this.child, this.back = false, this.actions});
  final String title;
  final String subtitle;
  final Widget child;
  final bool back;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: back ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)) : null,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF60716A))),
        ]),
        actions: actions,
        centerTitle: false,
        backgroundColor: const Color(0xFFF7F8F3),
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [child],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title, required this.action, required this.onTap});
  final String title;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900))),
        TextButton(onPressed: onTap, child: Text(action)),
      ],
    );
  }
}

class StatTile extends StatelessWidget {
  const StatTile({super.key, required this.label, required this.value, required this.icon});
  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 10),
        Text(value, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
        Text(label, style: const TextStyle(color: Color(0xFF60716A))),
      ]),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(child: Text(text)),
      ]),
    );
  }
}

void push(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}

void toast(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
