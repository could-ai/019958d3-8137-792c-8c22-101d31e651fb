import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESCALA CTRM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    WeeklyScheduleView(),
    Text('Efetivo'),
    Text('Perfil'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ESCALA CTRM'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Escala',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Efetivo',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            onTap: _onItemTapped,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.grey[200],
            child: const Center(
              child: Text(
                'Desenvolvido pelo 2º Sgt BM Fábio para o Centro de Treinamento e Reciclagem de Motoristas.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WeeklyScheduleView extends StatelessWidget {
  const WeeklyScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de dias da semana
    final daysOfWeek = ['SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB', 'DOM'];
    
    // Dados de exemplo para a escala
    final schedule = {
      'SEG': [
        {'name': '2º Sgt BM Fábio', 'role': 'Motorista'},
        {'name': 'Cb BM João', 'role': 'Chefe de Viatura'},
      ],
      'TER': [
        {'name': '3º Sgt BM Carlos', 'role': 'Motorista'},
      ],
      'QUA': [
        {'name': 'Sd BM Ana', 'role': 'Socorrista'},
        {'name': '2º Sgt BM Fábio', 'role': 'Motorista'},
      ],
      'QUI': [
        {'name': 'Cb BM Pedro', 'role': 'Chefe de Viatura'},
      ],
      'SEX': [
        {'name': '1º Ten BM Maria', 'role': 'Oficial de Dia'},
        {'name': '2º Sgt BM Fábio', 'role': 'Motorista'},
      ],
      'SAB': [],
      'DOM': [],
    };

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Escala da Semana',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: daysOfWeek.length,
              itemBuilder: (context, index) {
                final day = daysOfWeek[index];
                final scheduledPersonnel = schedule[day] ?? [];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          day,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        if (scheduledPersonnel.isEmpty)
                          const Text('Ninguém escalado.')
                        else
                          ...scheduledPersonnel.map(
                            (person) => ListTile(
                              title: Text(person['name']!),
                              subtitle: Text(person['role']!),
                              leading: const Icon(Icons.person_outline),
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
