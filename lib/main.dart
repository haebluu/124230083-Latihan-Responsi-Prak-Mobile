import 'package:flutter/material.dart';
import 'package:latres/views/favorites_page.dart';
import 'package:latres/views/profile_page.dart';
import 'package:latres/views/register_page.dart';
import 'package:provider/provider.dart';
import 'services/hive_service.dart';
import 'controllers/auth_controller.dart';
import 'controllers/anime_controller.dart';
import 'controllers/favorite_controller.dart';
import 'controllers/profile_controller.dart';
import 'views/login_page.dart';
import 'views/home_page.dart';
// ... import views lainnya

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();
  
  // 1. Inisialisasi AuthController dan cek status login di luar runApp
  final authController = AuthController();
  await authController.checkLoginStatus(); 
  
  runApp(MyApp(authController: authController));
}

class MyApp extends StatelessWidget {
  final AuthController authController;

  const MyApp({Key? key, required this.authController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 2. MultiProvider untuk menyediakan semua controllers
    return MultiProvider(
      providers: [
        // a. AuthController: Menggunakan .value karena sudah diinisialisasi di atas
        ChangeNotifierProvider.value(value: authController), 
        
        // b. AnimeController: Fetch data saat inisialisasi
        ChangeNotifierProvider(
          create: (_) => AnimeController()..fetchTopAnime(),
        ),
        
        // c. FavoriteController: Load data saat inisialisasi
        ChangeNotifierProvider(
          create: (_) => FavoriteController()..loadFavorites(),
        ),
        
        // d. ProfileController: Load data statis/image path saat inisialisasi
        ChangeNotifierProvider(
          create: (_) => ProfileController()..loadProfileImage(),
        ),
      ],
      child: MaterialApp(
        title: 'MyAnimeArchive',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // 3. Consumer untuk menentukan halaman awal (Login atau Home)
        home: Consumer<AuthController>(
          builder: (context, auth, child) {
            if (auth.currentUsername != null) {
              return const MainWrapper(); // Jika ada session
            }
            return const LoginPage(); // Jika tidak ada session
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

// ... (Definisi MainWrapper tetap sama, berisi Home, Favorites, Profile)
// Wrapper untuk Bottom Navigation Bar (Home, Favorite, Profile)
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
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}