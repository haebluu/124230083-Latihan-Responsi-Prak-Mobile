import 'package:flutter/material.dart';
import 'package:latres/views/register_page.dart';
import 'package:provider/provider.dart';
import 'services/hive_service.dart';
import 'controllers/auth_controller.dart';
import 'controllers/anime_controller.dart';
import 'controllers/favorite_controller.dart';
import 'controllers/profile_controller.dart';
import 'views/login_page.dart';
import 'views/favorites_page.dart';
import 'views/profile_page.dart';
import 'views/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();
  
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthController()..checkLoginStatus(),
        ), 
        ChangeNotifierProvider(
          create: (_) => AnimeController()..fetchTopAnime(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteController()..loadFavorites(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileController()..loadProfileImage(),
        ),
      ],
      child: MaterialApp(
        title: 'MyAnime',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,

          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 18, 
              fontWeight: FontWeight.bold, 
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: Color.fromRGBO(206, 1, 88, 1), 
          ),

        ),
        home: Consumer<AuthController>(
          builder: (context, auth, child) {
            if (auth.currentUsername == null) {
              return const LoginPage(); 
            }
            return const MainWrapper();
          },
        ),
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const MainWrapper(),
        },
      ),
    );
  }
}

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;
  
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavoritesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(206, 1, 88, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}