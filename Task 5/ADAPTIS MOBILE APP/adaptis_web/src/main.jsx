import React, { useState } from 'react';
import { createRoot } from 'react-dom/client';
import {
  Activity,
  Bell,
  BookOpen,
  CheckCircle2,
  ChevronRight,
  Download,
  FileText,
  LayoutDashboard,
  LineChart,
  LogOut,
  MessageSquare,
  Network,
  Plus,
  Search,
  Send,
  Settings,
  Shield,
  Signal,
  UploadCloud,
  UserCog,
  Users,
} from 'lucide-react';
import {
  Area,
  AreaChart,
  Bar,
  BarChart,
  CartesianGrid,
  Cell,
  Pie,
  PieChart,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from 'recharts';
import './styles.css';

const courses = [
  { id: 'ict101', title: 'ICT Fundamentals', teacher: 'Mme Ngono', students: 128, progress: 72, status: 'Published', city: 'Yaounde', modules: 6 },
  { id: 'bio202', title: 'Biology: Human Body', teacher: 'Sir Foncha', students: 94, progress: 48, status: 'Draft', city: 'Bamenda', modules: 5 },
  { id: 'math300', title: 'Mathematics: Statistics', teacher: 'Mr Etoundi', students: 76, progress: 31, status: 'Published', city: 'Douala', modules: 4 },
];

const students = [
  { name: 'Amina Njoya', city: 'Yaounde', course: 'ICT Fundamentals', progress: 72, network: 'Fair', sync: 'Pending' },
  { name: 'Junior Tabe', city: 'Buea', course: 'Biology: Human Body', progress: 48, network: 'Poor', sync: 'Synced' },
  { name: 'Clarisse Mballa', city: 'Douala', course: 'Mathematics: Statistics', progress: 86, network: 'Good', sync: 'Synced' },
  { name: 'Nadine Fomuso', city: 'Bamenda', course: 'ICT Fundamentals', progress: 55, network: 'Poor', sync: 'Pending' },
];

const teachers = [
  { name: 'Mme Ngono', department: 'ICT', courses: 3, students: 128 },
  { name: 'Sir Foncha', department: 'Biology', courses: 2, students: 94 },
  { name: 'Mr Etoundi', department: 'Mathematics', courses: 2, students: 76 },
];

const qoeEvents = [
  { city: 'Yaounde', buffering: 18, switches: 44, poorUsers: 39 },
  { city: 'Douala', buffering: 12, switches: 31, poorUsers: 22 },
  { city: 'Buea', buffering: 24, switches: 52, poorUsers: 46 },
  { city: 'Bamenda', buffering: 28, switches: 61, poorUsers: 51 },
  { city: 'Garoua', buffering: 16, switches: 27, poorUsers: 33 },
];

const weekly = [
  { day: 'Mon', hd: 72, sd: 46, lite: 33 },
  { day: 'Tue', hd: 68, sd: 52, lite: 41 },
  { day: 'Wed', hd: 81, sd: 43, lite: 36 },
  { day: 'Thu', hd: 59, sd: 58, lite: 49 },
  { day: 'Fri', hd: 75, sd: 39, lite: 28 },
];

const modeShare = [
  { name: 'HD Video', value: 31, color: '#12664f' },
  { name: 'SD Video', value: 38, color: '#2e86ab' },
  { name: 'Audio + Text', value: 31, color: '#e07a5f' },
];

const messages = [
  { from: 'Amina Njoya', text: 'Madam, my quiz saved offline. It says pending sync.', time: '4:20 PM' },
  { from: 'Junior Tabe', text: 'Please can you upload the text note too? Network is poor here.', time: 'Yesterday' },
  { from: 'Admin Desk', text: 'Content review passed for ICT Module 3.', time: 'Mon' },
];

function App() {
  const [role, setRole] = useState('teacher');
  const [screen, setScreen] = useState('overview');
  const [loggedIn, setLoggedIn] = useState(false);

  if (!loggedIn) return <Login role={role} setRole={setRole} onLogin={() => setLoggedIn(true)} />;

  const nav = role === 'teacher' ? teacherNav : adminNav;
  return (
    <div className="app-shell">
      <Sidebar role={role} nav={nav} screen={screen} setScreen={setScreen} setRole={setRole} logout={() => setLoggedIn(false)} />
      <main className="main">
        <Topbar role={role} />
        {role === 'teacher' ? <TeacherScreen screen={screen} /> : <AdminScreen screen={screen} />}
      </main>
    </div>
  );
}

const teacherNav = [
  ['overview', 'Dashboard', LayoutDashboard],
  ['courses', 'My Courses', BookOpen],
  ['courseDetails', 'Course Details', FileText],
  ['createCourse', 'Create/Edit Course', Plus],
  ['modules', 'Module Manager', BookOpen],
  ['upload', 'Upload Content', UploadCloud],
  ['quizzes', 'Quiz Management', CheckCircle2],
  ['assignments', 'Assignments', FileText],
  ['studentProgress', 'Student Progress', Users],
  ['individualProgress', 'Individual Student', Activity],
  ['messages', 'Messages', MessageSquare],
  ['announcements', 'Notifications', Bell],
  ['settings', 'Profile/Settings', Settings],
];

const adminNav = [
  ['overview', 'Dashboard', LayoutDashboard],
  ['users', 'User Management', Users],
  ['students', 'Student Management', Users],
  ['teachers', 'Teacher Management', UserCog],
  ['courses', 'Course Management', BookOpen],
  ['analytics', 'Platform Analytics', LineChart],
  ['qoe', 'QoE / Network', Network],
  ['moderation', 'Content Moderation', Shield],
  ['notifications', 'System Notifications', Bell],
  ['reports', 'Reports / Export', Download],
  ['settings', 'Settings', Settings],
];

function Login({ role, setRole, onLogin }) {
  return (
    <div className="login-screen">
      <section className="login-card">
        <img src="/assets/logo-name-tagline.png" alt="ADAPTIS" className="login-logo" />
        <p className="eyebrow">Cameroon adaptive e-learning demo</p>
        <h1>{role === 'teacher' ? 'Teacher dashboard' : 'Admin command centre'}</h1>
        <p className="muted">Frontend-only simulation using mock data. Any password works.</p>
        <div className="role-switch">
          <button className={role === 'teacher' ? 'active' : ''} onClick={() => setRole('teacher')}>Teacher</button>
          <button className={role === 'admin' ? 'active' : ''} onClick={() => setRole('admin')}>Admin</button>
        </div>
        <label>Email</label>
        <input defaultValue={role === 'teacher' ? 'teacher@adaptis.cm' : 'admin@adaptis.cm'} />
        <label>Password</label>
        <input type="password" defaultValue="demo123" />
        <button className="primary" onClick={onLogin}>Login</button>
      </section>
      <section className="login-story">
        <Signal size={44} />
        <h2>Built for Good, Fair and Poor network days.</h2>
        <p>Show course management, student progress, offline sync, and QoE analytics for Cameroon classrooms.</p>
      </section>
    </div>
  );
}

function Sidebar({ role, nav, screen, setScreen, setRole, logout }) {
  return (
    <aside className="sidebar">
      <img src="/assets/logo-name.png" alt="ADAPTIS" className="brand" />
      <div className="role-pill">{role === 'teacher' ? 'Teacher Portal' : 'Admin Portal'}</div>
      <nav>
        {nav.map(([key, label, Icon]) => (
          <button key={key} className={screen === key ? 'nav-item active' : 'nav-item'} onClick={() => setScreen(key)}>
            <Icon size={18} />
            <span>{label}</span>
          </button>
        ))}
      </nav>
      <button className="nav-item" onClick={() => { setRole(role === 'teacher' ? 'admin' : 'teacher'); setScreen('overview'); }}>
        <Shield size={18} />
        <span>Switch Role</span>
      </button>
      <button className="nav-item" onClick={logout}>
        <LogOut size={18} />
        <span>Logout</span>
      </button>
    </aside>
  );
}

function Topbar({ role }) {
  return (
    <header className="topbar">
      <div>
        <p className="eyebrow">ADAPTIS {role === 'teacher' ? 'Teacher' : 'Admin'}</p>
        <h2>{role === 'teacher' ? 'Good evening, Mme Ngono' : 'Platform overview'}</h2>
      </div>
      <div className="search">
        <Search size={18} />
        <input placeholder="Search courses, users, reports..." />
      </div>
    </header>
  );
}

function TeacherScreen({ screen }) {
  const map = {
    overview: <TeacherOverview />,
    courses: <CoursesGrid mine />,
    courseDetails: <CourseDetails />,
    createCourse: <CourseForm />,
    modules: <ModuleManager />,
    upload: <UploadContent />,
    quizzes: <QuizManager />,
    assignments: <AssignmentManager />,
    studentProgress: <StudentProgress />,
    individualProgress: <IndividualStudent />,
    messages: <Messages />,
    announcements: <Announcements />,
    settings: <SettingsPanel role="teacher" />,
  };
  return map[screen] ?? map.overview;
}

function AdminScreen({ screen }) {
  const map = {
    overview: <AdminOverview />,
    users: <UsersTable title="All Users" data={[...students, ...teachers.map((t) => ({ ...t, course: t.department, progress: t.courses * 20, network: 'Good', sync: 'Active' }))]} />,
    students: <UsersTable title="Student Management" data={students} />,
    teachers: <TeachersTable />,
    courses: <CoursesGrid />,
    analytics: <PlatformAnalytics />,
    qoe: <QoeAnalytics />,
    moderation: <Moderation />,
    notifications: <Announcements admin />,
    reports: <Reports />,
    settings: <SettingsPanel role="admin" />,
  };
  return map[screen] ?? map.overview;
}

function TeacherOverview() {
  return (
    <Page title="Teacher Dashboard" subtitle="Courses, uploads, student progress and messages.">
      <Stats items={[
        ['Active courses', '3', BookOpen],
        ['Students', '128', Users],
        ['Pending syncs', '14', Network],
        ['Quiz average', '76%', CheckCircle2],
      ]} />
      <TwoCol left={<CoursesGrid mine compact />} right={<Messages compact />} />
      <StudentProgress compact />
    </Page>
  );
}

function AdminOverview() {
  return (
    <Page title="Admin Dashboard" subtitle="System-wide users, courses, network health and QoE events.">
      <Stats items={[
        ['Users', '412', Users],
        ['Courses', '18', BookOpen],
        ['Poor-network users', '191', Signal],
        ['Mode switches', '215', Network],
      ]} />
      <TwoCol left={<QoeAnalytics compact />} right={<PlatformAnalytics compact />} />
      <UsersTable title="Recent User Activity" data={students.slice(0, 3)} compact />
    </Page>
  );
}

function Page({ title, subtitle, children }) {
  return (
    <section className="page">
      <div className="page-head">
        <div>
          <h1>{title}</h1>
          <p>{subtitle}</p>
        </div>
      </div>
      {children}
    </section>
  );
}

function Stats({ items }) {
  return <div className="stats">{items.map(([label, value, Icon]) => <article className="stat" key={label}><Icon /><span>{label}</span><strong>{value}</strong></article>)}</div>;
}

function TwoCol({ left, right }) {
  return <div className="two-col"><div>{left}</div><div>{right}</div></div>;
}

function CoursesGrid({ mine = false, compact = false }) {
  return (
    <Panel title={mine ? 'My Courses' : 'Course Management'} action={mine ? 'Create course' : 'Review all'}>
      <div className={compact ? 'course-list compact' : 'course-list'}>
        {courses.map((course) => (
          <article className="course-card" key={course.id}>
            <div className="course-top">
              <div className="course-icon"><BookOpen size={22} /></div>
              <span className={course.status === 'Published' ? 'badge good' : 'badge warn'}>{course.status}</span>
            </div>
            <h3>{course.title}</h3>
            <p>{course.teacher} - {course.city}</p>
            <div className="progress"><span style={{ width: `${course.progress}%` }} /></div>
            <small>{course.modules} modules - {course.students} students - {course.progress}% avg progress</small>
          </article>
        ))}
      </div>
    </Panel>
  );
}

function CourseDetails() {
  return (
    <Page title="Course Details" subtitle="ICT Fundamentals course structure and student-facing formats.">
      <Panel title="ICT Fundamentals">
        <div className="detail-grid">
          <Info label="Teacher" value="Mme Ngono" />
          <Info label="Location" value="Yaounde" />
          <Info label="Modules" value="6" />
          <Info label="Formats" value="HD, SD, Audio, Text" />
        </div>
      </Panel>
      <ModuleManager />
    </Page>
  );
}

function CourseForm() {
  return (
    <Page title="Create/Edit Course" subtitle="Mock course builder for teacher demo.">
      <Panel title="Course Information">
        <FormGrid fields={['Course title', 'Course code', 'Department', 'School/Institution', 'Short description', 'Default language']} />
        <button className="primary"><Plus size={18} /> Save course</button>
      </Panel>
    </Page>
  );
}

function ModuleManager() {
  return (
    <Panel title="Module / Lesson Manager" action="Add module">
      {['Introduction to computer networks', 'Using offline notes', 'Data Saver and adaptive modes'].map((item, index) => (
        <div className="list-row" key={item}>
          <div><strong>Module {index + 1}</strong><p>{item}</p></div>
          <ChevronRight size={18} />
        </div>
      ))}
    </Panel>
  );
}

function UploadContent() {
  return (
    <Page title="Upload Content" subtitle="Simulated video/PDF upload and FFmpeg processing status.">
      <Panel title="New Upload">
        <div className="upload-box"><UploadCloud size={42} /><strong>Drop video, PDF or notes here</strong><span>Demo accepts mock upload only</span></div>
        <button className="primary"><UploadCloud size={18} /> Start processing</button>
      </Panel>
      <Panel title="Media Processing Status">
        {['720p HLS segments generated', '360p HLS segments generated', 'Audio-only track generated', 'Text notes linked'].map((item) => <div className="list-row" key={item}><span>{item}</span><span className="badge good">Done</span></div>)}
      </Panel>
    </Page>
  );
}

function QuizManager() {
  return (
    <Page title="Quiz Management" subtitle="Create, edit and review quizzes.">
      <Panel title="Quiz Dashboard" action="Create quiz">
        {['Adaptive Learning Basics', 'ICT Network Terms', 'Offline Study Habits'].map((item, index) => <div className="list-row" key={item}><div><strong>{item}</strong><p>{index + 3} questions - average {72 + index * 5}%</p></div><span className="badge good">Active</span></div>)}
      </Panel>
      <Panel title="Question Builder">
        <FormGrid fields={['Question', 'Option A', 'Option B', 'Option C', 'Correct answer']} />
      </Panel>
    </Page>
  );
}

function AssignmentManager() {
  return (
    <Page title="Assignment Management" subtitle="Create assignments and grade submissions.">
      <Panel title="Submissions">
        {students.map((s) => <div className="list-row" key={s.name}><div><strong>{s.name}</strong><p>{s.course} - submitted text answer</p></div><button className="ghost">Grade</button></div>)}
      </Panel>
    </Page>
  );
}

function StudentProgress({ compact = false }) {
  return (
    <Panel title="Student Progress Table">
      <table>
        <thead><tr><th>Name</th><th>Course</th><th>Progress</th><th>Network</th><th>Sync</th></tr></thead>
        <tbody>{students.slice(0, compact ? 3 : students.length).map((s) => <tr key={s.name}><td>{s.name}</td><td>{s.course}</td><td>{s.progress}%</td><td><span className={`badge ${s.network === 'Poor' ? 'bad' : s.network === 'Fair' ? 'warn' : 'good'}`}>{s.network}</span></td><td>{s.sync}</td></tr>)}</tbody>
      </table>
    </Panel>
  );
}

function IndividualStudent() {
  return (
    <Page title="Individual Student Progress" subtitle="Amina Njoya learning activity.">
      <Stats items={[['Course progress', '72%', Activity], ['Downloaded lessons', '4', Download], ['Pending sync', '2', Network], ['Quiz score', '83%', CheckCircle2]]} />
      <Panel title="Activity History">
        {['Opened ICT lesson in SD mode', 'Enabled Data Saver on mobile data', 'Downloaded Module 2 notes', 'Quiz result saved locally'].map((item) => <div className="list-row" key={item}><span>{item}</span><span className="badge warn">Demo</span></div>)}
      </Panel>
    </Page>
  );
}

function Messages({ compact = false }) {
  return (
    <Panel title="Messages" action="Open inbox">
      {messages.slice(0, compact ? 2 : messages.length).map((m) => <div className="list-row" key={m.from}><div><strong>{m.from}</strong><p>{m.text}</p></div><small>{m.time}</small></div>)}
      {!compact && <div className="message-compose"><input placeholder="Write announcement or reply..." /><button className="primary"><Send size={18} /> Send</button></div>}
    </Panel>
  );
}

function Announcements({ admin = false }) {
  return (
    <Page title={admin ? 'System Notifications' : 'Notifications / Announcements'} subtitle="Queue alerts for students with poor internet.">
      <Panel title="Create Announcement">
        <FormGrid fields={['Title', 'Audience', 'Message', 'Delivery rule']} />
        <button className="primary"><Bell size={18} /> Broadcast</button>
      </Panel>
    </Page>
  );
}

function UsersTable({ title, data, compact = false }) {
  return (
    <Panel title={title}>
      <table>
        <thead><tr><th>Name</th><th>City/Department</th><th>Course</th><th>Progress</th><th>Status</th></tr></thead>
        <tbody>{data.slice(0, compact ? 3 : data.length).map((u) => <tr key={u.name}><td>{u.name}</td><td>{u.city || u.department}</td><td>{u.course}</td><td>{u.progress}%</td><td><span className="badge good">{u.sync || 'Active'}</span></td></tr>)}</tbody>
      </table>
    </Panel>
  );
}

function TeachersTable() {
  return (
    <Panel title="Teacher Management" action="Add teacher">
      <table>
        <thead><tr><th>Name</th><th>Department</th><th>Courses</th><th>Students</th><th>Status</th></tr></thead>
        <tbody>{teachers.map((t) => <tr key={t.name}><td>{t.name}</td><td>{t.department}</td><td>{t.courses}</td><td>{t.students}</td><td><span className="badge good">Active</span></td></tr>)}</tbody>
      </table>
    </Panel>
  );
}

function PlatformAnalytics({ compact = false }) {
  return (
    <Panel title="Platform Analytics">
      <div className={compact ? 'chart small' : 'chart'}>
        <ResponsiveContainer width="100%" height="100%">
          <AreaChart data={weekly}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="day" />
            <YAxis />
            <Tooltip />
            <Area dataKey="hd" stackId="1" stroke="#12664f" fill="#12664f" />
            <Area dataKey="sd" stackId="1" stroke="#2e86ab" fill="#2e86ab" />
            <Area dataKey="lite" stackId="1" stroke="#e07a5f" fill="#e07a5f" />
          </AreaChart>
        </ResponsiveContainer>
      </div>
    </Panel>
  );
}

function QoeAnalytics({ compact = false }) {
  return (
    <Panel title="QoE / Network Analytics">
      <div className={compact ? 'chart small' : 'chart'}>
        <ResponsiveContainer width="100%" height="100%">
          <BarChart data={qoeEvents}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="city" />
            <YAxis />
            <Tooltip />
            <Bar dataKey="buffering" fill="#e07a5f" />
            <Bar dataKey="switches" fill="#12664f" />
          </BarChart>
        </ResponsiveContainer>
      </div>
      {!compact && <div className="pie-row"><ResponsiveContainer width="100%" height={220}><PieChart><Pie data={modeShare} dataKey="value" nameKey="name" outerRadius={82}>{modeShare.map((entry) => <Cell key={entry.name} fill={entry.color} />)}</Pie><Tooltip /></PieChart></ResponsiveContainer></div>}
    </Panel>
  );
}

function Moderation() {
  return (
    <Page title="Content Moderation" subtitle="Review uploaded lessons before publication.">
      <Panel title="Pending Review">
        {courses.map((c) => <div className="list-row" key={c.id}><div><strong>{c.title}</strong><p>{c.teacher} - {c.city}</p></div><button className="ghost">Approve</button></div>)}
      </Panel>
    </Page>
  );
}

function Reports() {
  return (
    <Page title="Reports / Export" subtitle="Mock exports for presentation.">
      <Panel title="Available Reports">
        {['User activity CSV', 'Course progress PDF', 'QoE events CSV', 'Offline sync report'].map((r) => <div className="list-row" key={r}><span>{r}</span><button className="ghost"><Download size={16} /> Export</button></div>)}
      </Panel>
    </Page>
  );
}

function SettingsPanel({ role }) {
  return (
    <Page title="Settings" subtitle={`${role} profile, security and platform preferences.`}>
      <Panel title="Profile / Settings">
        <FormGrid fields={['Name', 'Email', 'Language', 'Notification preference', 'Password']} />
        <button className="primary"><Settings size={18} /> Save settings</button>
      </Panel>
    </Page>
  );
}

function Panel({ title, action, children }) {
  return <section className="panel"><div className="panel-head"><h2>{title}</h2>{action && <button className="ghost">{action}</button>}</div>{children}</section>;
}

function Info({ label, value }) {
  return <div className="info"><span>{label}</span><strong>{value}</strong></div>;
}

function FormGrid({ fields }) {
  return <div className="form-grid">{fields.map((field) => <label key={field}>{field}<input placeholder={field} /></label>)}</div>;
}

createRoot(document.getElementById('root')).render(<App />);
