import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({super.key});

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

//Implementamos TickerProviderStateMixin por que comunmente se implementa en
//Widgets que necitan realizar animaciones
class _TabBarWidgetState extends State<TabBarWidget>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    //Inicializamos el TabControler
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  //Llamamos a dispose por que todo controlador debe cerrarse o destruirse
  //despues que el widget sea elininado
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tab Bar"),
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(
            icon: Icon(Icons.home),
          ),
          Tab(
            icon: Icon(Icons.person),
          ),
          Tab(
            icon: Icon(Icons.settings),
          ),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        //Declaro todos los tabs
        children: const [
          Center(child: Text("Pantalla de Home")),
          Center(child: Text("Pantalla de Perfil")),
          Center(child: Text("Pantalla de Configuracion")),
        ],
      ),
    );
  }
}
