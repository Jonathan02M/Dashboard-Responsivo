import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard Premium',
      theme: ThemeData(
        fontFamily: 'Arial',
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    List<Widget> cards = [
      DashboardCard("Vendas", "R\$ 12.400", Icons.trending_up, Colors.green),
      DashboardCard("Usuários", "2.300", Icons.people, Colors.blue),
      DashboardCard("Pedidos", "890", Icons.shopping_cart, Colors.orange),
      DashboardCard("Avaliação", "4.9 ★", Icons.star, Colors.purple),
    ];

    Widget layout;

    if (width < 600) {
      layout = Column(
        key: const ValueKey("mobile"),
        children: cards
            .map((c) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: c,
                ))
            .toList(),
      );
    } else if (width < 900) {
      layout = Wrap(
        key: const ValueKey("tablet"),
        spacing: 16,
        runSpacing: 16,
        children: cards
            .map((c) => SizedBox(
                  width: (width / 2) - 24,
                  child: c,
                ))
            .toList(),
      );
    } else {
      layout = Row(
        key: const ValueKey("desktop"),
        children: cards
            .map((c) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: c,
                  ),
                ))
            .toList(),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Dashboard Premium"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 🌈 FUNDO GRADIENTE
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0F2027),
                  Color(0xFF203A43),
                  Color(0xFF2C5364),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 📦 CONTEÚDO
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: layout,
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardCard extends StatefulWidget {
  final String titulo;
  final String valor;
  final IconData icone;
  final Color cor;

  const DashboardCard(this.titulo, this.valor, this.icone, this.cor,
      {super.key});

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..scale(isHover ? 1.05 : 1.0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.1),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: widget.cor.withOpacity(0.4),
              blurRadius: isHover ? 20 : 10,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Stack(
              children: [
                Positioned(
                  right: -10,
                  bottom: -10,
                  child: Icon(
                    widget.icone,
                    size: 100,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(widget.icone, color: widget.cor, size: 32),
                    const SizedBox(height: 10),
                    Text(
                      widget.titulo,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.valor,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // 📊 barra moderna
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 0.7,
                        backgroundColor: Colors.white24,
                        color: widget.cor,
                        minHeight: 6,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}