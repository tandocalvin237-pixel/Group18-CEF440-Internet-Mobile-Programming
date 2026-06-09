import 'models.dart';

const courses = [
  Course(
    id: 'ict101',
    title: 'ICT Fundamentals',
    teacher: 'Mme Ngono',
    location: 'Yaounde',
    progress: 0.72,
    modules: 6,
    colorHex: 0xFF12664F,
    lessons: [
      Lesson(
        id: 'ict-l1',
        title: 'Computer Networks in Daily Learning',
        duration: '18 min',
        summary: 'How networks carry school content across mobile data and WiFi.',
        text: 'Networks help students in Buea, Bamenda, Douala and Yaounde access lessons even when bandwidth changes. ADAPTIS reduces data pressure by switching from video to audio and text when the connection becomes weak.',
        downloaded: true,
      ),
      Lesson(
        id: 'ict-l2',
        title: 'Staying Productive With Poor Internet',
        duration: '12 min',
        summary: 'Offline-first learning habits for low-resource settings.',
        text: 'Download notes when WiFi is strong, keep Data Saver on when using mobile data, and allow progress sync when the network returns.',
      ),
    ],
  ),
  Course(
    id: 'bio202',
    title: 'Biology: Human Body',
    teacher: 'Sir Foncha',
    location: 'Bamenda',
    progress: 0.48,
    modules: 5,
    colorHex: 0xFF2E86AB,
    lessons: [
      Lesson(
        id: 'bio-l1',
        title: 'Respiration and Energy',
        duration: '22 min',
        summary: 'A lesson with video, audio and text formats.',
        text: 'Respiration releases energy from food. In ADAPTIS, this lesson can continue as text notes when the student has only EDGE or unstable 3G.',
      ),
      Lesson(
        id: 'bio-l2',
        title: 'Blood Circulation',
        duration: '16 min',
        summary: 'Understand the heart and blood vessels.',
        text: 'The heart pumps blood through arteries and veins. Downloadable notes make this content available during transport or network outages.',
      ),
    ],
  ),
  Course(
    id: 'math300',
    title: 'Mathematics: Statistics',
    teacher: 'Mr Etoundi',
    location: 'Douala',
    progress: 0.31,
    modules: 4,
    colorHex: 0xFFE07A5F,
    lessons: [
      Lesson(
        id: 'math-l1',
        title: 'Mean, Median and Mode',
        duration: '15 min',
        summary: 'Practical statistics with class data.',
        text: 'Mean, median and mode help summarize exam scores, attendance, and survey data from students across Cameroon.',
      ),
    ],
  ),
];

const quizQuestions = [
  QuizQuestion(
    question: 'What should ADAPTIS do when the connection is poor?',
    options: ['Force HD video', 'Switch to audio and text', 'Log out the student'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'Why is offline access important?',
    options: ['It saves learning progress during network drops', 'It deletes courses', 'It blocks quizzes'],
    correctIndex: 0,
  ),
  QuizQuestion(
    question: 'Which mode saves the most data?',
    options: ['HD Video', 'Audio + Text', 'Large image mode'],
    correctIndex: 1,
  ),
];

const messages = [
  MessageThread(
    name: 'Mme Ngono',
    role: 'ICT Teacher',
    preview: 'Bonsoir, your network quiz feedback is ready.',
    time: '4:20 PM',
  ),
  MessageThread(
    name: 'Sir Foncha',
    role: 'Biology Teacher',
    preview: 'Please download Module 2 before tomorrow.',
    time: 'Yesterday',
  ),
];

const notifications = [
  'New ICT note is available for offline download.',
  'Your Biology quiz result synced successfully.',
  'Data Saver activated because mobile data is expensive today.',
  'Pending progress from Statistics will sync when internet returns.',
];
