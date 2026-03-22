import 'package:flutter/material.dart';

void main() {
  runApp(const MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora IMC',
      home: const PantallaIMC(),
    );
  }
}

class PantallaIMC extends StatefulWidget {
  const PantallaIMC({super.key});

  @override
  State<PantallaIMC> createState() => _PantallaIMCState();
}

class _PantallaIMCState extends State<PantallaIMC> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  String _resultadoIMC = '';
  String _categoria = '';

  void calcularIMC() {
    if (_formKey.currentState!.validate()) {
      double peso = double.parse(_pesoController.text);
      double altura = double.parse(_alturaController.text) / 100;

      double imc = peso / (altura * altura);

      String categoria = '';

      if (imc < 18.5) {
        categoria = 'Bajo peso';
      } else if (imc >= 18.5 && imc <= 24.9) {
        categoria = 'Peso normal';
      } else if (imc >= 25.0 && imc <= 29.9) {
        categoria = 'Sobrepeso';
      } else {
        categoria = 'Obesidad';
      }

      setState(() {
        _resultadoIMC = imc.toStringAsFixed(2);
        _categoria = categoria;
        Color obtenerColor(String categoria) {
  switch (categoria) {
    case 'Bajo peso':
      return Colors.blue;
    case 'Peso normal':
      return Colors.green;
    case 'Sobrepeso':
      return Colors.orange;
    case 'Obesidad':
      return Colors.red;
    default:
      return Colors.black;
  }
}
      });
    }
  }

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Ingresa tu peso y altura para calcular tu IMC.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _pesoController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Peso (kg)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El peso no puede estar vacío';
                  }

                  double? peso = double.tryParse(value);
                  if (peso == null) {
                    return 'Ingresa un número válido';
                  }

                  if (peso <= 0) {
                    return 'El peso debe ser positivo';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _alturaController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Altura (m)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La altura no puede estar vacía';
                  }

                  double? altura = double.tryParse(value);
                  if (altura == null) {
                    return 'Ingresa un número válido';
                  }

                  if (altura <= 0) {
                    return 'La altura debe ser positiva';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: calcularIMC,
                child: const Text('Calcular IMC'),
              ),
              const SizedBox(height: 30),

              Text(
                _resultadoIMC.isEmpty ? '' : 'Tu IMC es: $_resultadoIMC',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              Text(
                _categoria.isEmpty ? '' : 'Categoría: $_categoria',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}