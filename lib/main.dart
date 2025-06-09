import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky/Services/theme_notifier.dart';
import 'package:tasky/add_task_screen.dart';
import 'package:tasky/completed_tasks_screen.dart';
import 'package:tasky/home_screen.dart';
import 'package:tasky/login_screen.dart';
import 'package:tasky/profile_screen.dart';
import 'package:tasky/tasks_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/todotasks_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyAppWrapper(),
    ),
  );
}

class MyAppWrapper extends StatefulWidget {
  const MyAppWrapper({super.key});

  @override
  State<MyAppWrapper> createState() => _MyAppWrapperState();
}

class _MyAppWrapperState extends State<MyAppWrapper> {
  String? username;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUsername();
  }

  Future<void> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return MyApp(username: username);
  }
}

class MyApp extends StatelessWidget {
 final String ? username;
  const MyApp({super.key,required this.username});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       theme:lightTheme,
        darkTheme: darkTheme,
        // ThemeData(
     //    elevatedButtonTheme: ElevatedButtonThemeData(
     //      style:ElevatedButton.styleFrom(
     //        fixedSize:Size(343,40),
     //        backgroundColor: Color(0xff15B86C)
     //      )
     //    ),
     //
     //    bottomNavigationBarTheme: BottomNavigationBarThemeData(
     //      backgroundColor: Color(0xff181818),
     //      type: BottomNavigationBarType.fixed,
     //      selectedItemColor: Color(0xff15B86C),
     //      unselectedItemColor: Color(0xffC6C6C6),
     //
     //    ),
     //      switchTheme: SwitchThemeData(
     //        trackColor: MaterialStateProperty.resolveWith<Color>(
     //              (Set<MaterialState> states) {
     //            if (states.contains(MaterialState.selected)) {
     //              return Color(0xff15B86C); // Custom green track when ON
     //            }
     //            return Colors.grey.withOpacity(0.5); // Grey track when OFF
     //          },
     //        ),
     //      ),
     //
     //
     //
     //      scaffoldBackgroundColor: Color(0xff181818),
     //    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff15B86C)),
     //    useMaterial3: true,
     //    textTheme: TextTheme(
     //      displayMedium: TextStyle(
     //        fontSize: 28,
     //        fontWeight: FontWeight.w400,
     //        color: Color(0xffFFFFFF),
     //      ),
     //      displayLarge: TextStyle(
     //        fontSize: 24,
     //        fontWeight: FontWeight.w400,
     //        color: Color(0xffFFFCFC),
     //      ),
     //      displaySmall: TextStyle(
     //        fontSize: 16,
     //        fontWeight: FontWeight.w400,
     //        color: Color(0xffFFFCFC),
     //
     //      )
     //      )
     //
     // ),
      themeMode: themeNotifier.currentTheme,
        home:LoginScreen(),
      routes: {
         LoginScreen.Routname:(context)=>LoginScreen(),
        AddTaskScreen.Routname:(context)=>HomeScreen(),
        TasksScreen.Routname:(context)=>TasksScreen(),
        CompletedTasks.Routname:(context)=>CompletedTasks(),
        ProfileScreen.Routname:(context)=>ProfileScreen(),
        Todotasks.Routname:(context)=>Todotasks(),

      },


    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Color(0xff181818),
  colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff15B86C), brightness: Brightness.dark),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      fixedSize: Size(343, 40),
      backgroundColor: Color(0xff15B86C),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xff282828), // Same dark card background
    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade700),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade700),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xff15B86C), width: 2),
    ),
    hintStyle: TextStyle(color: Colors.grey.shade400),
    labelStyle: TextStyle(color: Colors.white),
  ),



  appBarTheme: AppBarTheme(
    color: Color(0xff181818),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xff181818),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0xff15B86C),
    unselectedItemColor: Color(0xffC6C6C6),
  ),
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Color(0xff15B86C);
        }
        return Colors.grey.withOpacity(0.5); // Grey track when OFF
      },
    ),
    thumbColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey.shade400;
        }
        return Colors.white; // Always white thumb (ON or OFF)
      },
    ),
  ),


  textTheme: TextTheme(
    displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, color: Colors.white),
    displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white),
    displaySmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
  ),
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff15B86C), brightness: Brightness.light),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      fixedSize: Size(343, 40),
      backgroundColor: Color(0xff15B86C),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white, // White background
    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xff15B86C), width: 2),
    ),
    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
    labelStyle: TextStyle(color: Colors.black),
  ),



  appBarTheme: AppBarTheme(
    color: Colors.white
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0xff15B86C),
    unselectedItemColor: Colors.grey,
  ),

  textTheme: TextTheme(
    displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, color: Colors.black),
    displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black),
    displaySmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
  ),
);