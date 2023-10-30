import 'package:flutter/material.dart';

class CitySelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Kota'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Tambahkan aksi ketika ikon menu ditekan jika diperlukan
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: CitySelectionForm(
          onCitySelected: (location) {
            Navigator.pop(context, location); // Kirim kota yang dipilih kembali
          },
        ),
      ),
    );
  }
}

class CitySelectionForm extends StatefulWidget {
  final Function(String) onCitySelected;

  CitySelectionForm({required this.onCitySelected});

  @override
  _CitySelectionFormState createState() => _CitySelectionFormState();
}

class _CitySelectionFormState extends State<CitySelectionForm> {
  final TextEditingController _cityController = TextEditingController();

  void chooseCityAndReturn() {
    final selectedCity = _cityController.text;
    if (selectedCity.isNotEmpty) {
      Navigator.pop(context, selectedCity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _cityController,
            decoration: InputDecoration(labelText: 'Masukkan Kota'),
          ),
          ElevatedButton(
            onPressed: chooseCityAndReturn,
            child: Text('Pilih'),
          ),
        ],
      ),
    );
  }
}
