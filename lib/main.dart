
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Locadora(),
  ));
}

class Locadora extends StatefulWidget {
  const Locadora({super.key});

  @override
  State<Locadora> createState() => _LocadoraState();
}

class _LocadoraState extends State<Locadora> {
  String carro = 'Econômico';
  bool seguro = false;
  bool gps = false;
  bool motorista = false;
  double dias = 1;

  double get preco {
    if (carro == 'Econômico') return 120;
    if (carro == 'SUV') return 180;
    return 300;
  }

  double get bruto {
    return (preco + (seguro ? 40 : 0) + (gps ? 15 : 0)) *
        dias + (motorista ? 100 : 0);
  }

  double get desconto {
    if (dias >= 15) return bruto * 0.10;
    if (dias >= 7) return bruto * 0.05;
    return 0;
  }

  String dinheiro(double valor) {
    return 'R\$ ${valor.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locadora de Carros'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Veículo'),

          RadioGroup<String>(
            groupValue: carro,
            onChanged: (valor) {
              setState(() {
                carro = valor!;
              });
            },
            child: const Column(
              children: [
                RadioListTile(
                  title: Text('Econômico - R\$ 120/dia'),
                  value: 'Carro Econômico',
                ),
                RadioListTile(
                  title: Text('SUV - R\$ 180/dia'),
                  value: ' Carro SUV',
                ),
                RadioListTile(
                  title: Text('Luxo - R\$ 300/dia'),
                  value: ' Carro Luxo',
                ),
              ],
            ),
          ),

          const Divider(),

          const Text('Opcionais'),

          CheckboxListTile(
            title: const Text('Seguro - R\$ 40/dia'),
            value: seguro,
            onChanged: (valor) {
              setState(() {
                seguro = valor!;
              });
            },
          ),

          CheckboxListTile(
            title: const Text('GPS - R\$ 15/dia'),
            value: gps,
            onChanged: (valor) {
              setState(() {
                gps = valor!;
              });
            },
          ),

          SwitchListTile(
            title: const Text('Motorista adicional - R\$ 100'),
            value: motorista,
            onChanged: (valor) {
              setState(() {
                motorista = valor;
              });
            },
          ),

          const Divider(),

          Text('Quantidade de dias: ${dias.toInt()}'),

          Slider(
            value: dias,
            min: 1,
            max: 30,
            divisions: 29,
            onChanged: (valor) {
              setState(() {
                dias = valor;
              });
            },
          ),

          const Divider(),

          const Text('Resumo da locação'),
          Text('Veículo: $carro'),
          Text('Dias: ${dias.toInt()}'),
          Text('Seguro: ${seguro ? "Sim" : "Não"}'),
          Text('GPS: ${gps ? "Sim" : "Não"}'),
          Text('Motorista adicional: ${motorista ? "Sim" : "Não"}'),
          Text('Valor bruto: ${dinheiro(bruto)}'),
          Text('Desconto: ${dinheiro(desconto)}'),
          Text('Valor final: ${dinheiro(bruto - desconto)}'),

          const SizedBox(height: 16),

          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (contexto) => AlertDialog(
                  title: const Text('Confirmar reserva'),
                  content: Text(
                    'Veículo: $carro\n'
                    'Dias: ${dias.toInt()}\n'
                    'Seguro: ${seguro ? "Sim" : "Não"}\n'
                    'GPS: ${gps ? "Sim" : "Não"}\n'
                    'Motorista: ${motorista ? "Sim" : "Não"}\n'
                    'Valor bruto: ${dinheiro(bruto)}\n'
                    'Desconto: ${dinheiro(desconto)}\n'
                    'Valor final: ${dinheiro(bruto - desconto)}',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(contexto),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(contexto);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Reserva realizada com sucesso!',
                            ),
                          ),
                        );
                      },
                      child: const Text('Confirmar Reserva'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Finalizar Reserva'),
          ),
        ],
      ),
    );
  }
}
