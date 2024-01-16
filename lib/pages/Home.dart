import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double taxa = 0;
  TextEditingController txtTotal = TextEditingController();
  TextEditingController qtdPessoas = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  void precoFinal() {
    setState(() {
      var total = double.parse(txtTotal.text);
      var qtd = int.parse(qtdPessoas.text);
      var comissao = (taxa * total) / 100;
      var totalPagar = (total + comissao) / qtd;


      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Align(
            alignment: Alignment.center,
            child: Text(
              "Total a Pagar por Pessoa",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          content: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Total da Conta:  R\$ $total",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Taxa do Garçom: R\$ $comissao",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Total por pessoa: R\$ $totalPagar",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
              ),
              child: Text("OK"),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          "Racha Conta",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(

        child: Column(
          children: [
            Form(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 20),
                  child: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/7551/7551564.png",
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 15, 15, 20),
              child: TextFormField(
                validator: (valor){
                  if(valor!.isEmpty){
                    return 'Campo obrigatório';
                  } else{
                    return null;
                  }
                },
                controller: txtTotal,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Total da conta",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    "Taxa de Serviços %:",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Slider(
                  value: taxa,
                  min: 0,
                  max: 10,
                  label: "$taxa",
                  divisions: 10,
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey,
                  onChanged: (double valor) {
                    setState(() {
                      taxa = valor;
                    });
                  },
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 15, 15, 20),
              child: TextFormField(
                validator: (valor){
                  if(valor!.isEmpty){
                    return 'Campo obrigatório';
                  } else{
                    return null;
                  }
                },
                controller: qtdPessoas,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Quantidade de Pessoas",
                  border: OutlineInputBorder(),

                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  if(_formkey.currentState!.validate()){
                    precoFinal();
                  }
                },
                child: Text(
                  "Calcular",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
