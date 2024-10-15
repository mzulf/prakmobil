import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../widgets/meal_category_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final loadedCategories = await ApiService.getCategories();
    setState(() {
      categories = loadedCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resep Favorit'),
        backgroundColor: Colors.deepOrange,  // Warna oren gelap untuk AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sekarang kamu tidak perlu bingung lagi untuk cari-cari resep untuk masak makanan favoritmu setiap hari!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepOrangeAccent,  // Warna oren cerah untuk teks
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Kategori Makanan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,  // Warna oren gelap untuk judul
                ),
              ),
              SizedBox(height: 16),
              categories.isEmpty
                  ? Center(child: CircularProgressIndicator(color: Colors.deepOrangeAccent))  // Warna oren cerah untuk indikator loading
                  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return MealCategoryCard(
                    category: categories[index],
                    color: Colors.deepOrangeAccent.withOpacity(0.2),  // Warna oren cerah dengan transparansi untuk background kartu
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,  // Warna putih untuk background BottomNavigationBar
        selectedItemColor: Colors.deepOrange,  // Warna oren gelap untuk item yang dipilih
        unselectedItemColor: Colors.deepOrangeAccent.withOpacity(0.6),  // Warna oren cerah dengan transparansi untuk item yang tidak dipilih
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Cari'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
