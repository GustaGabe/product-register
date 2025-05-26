// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_masked_text3/flutter_masked_text3.dart';

import 'model/produto_model.dart';
import 'widgets/chip_info.dart';
import 'widgets/text_field_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista e Cadastro de Produto',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<ProdutoModel> productData = [
    ProdutoModel(
      nome: 'Smartphone Galaxy A54',
      precoCompra: 1199.99,
      precoVenda: 1599.99,
      quantidade: 17,
      descricao: 'Celular com câmera tripla e ótima performance.',
      categoria: 'Eletrônicos',
      imagem:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjteVXpwXK5aWtJlTJaICkJ0y6fOfv_5la5w&s',
      ativo: true,
      emPromocao: true,
      desconto: 12.0,
    ),
    ProdutoModel(
      nome: 'Camiseta Polo Masculina',
      precoCompra: 35.90,
      precoVenda: 59.90,
      quantidade: 50,
      descricao: 'Camiseta polo 100% algodão.',
      categoria: 'Roupas',
      imagem:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx13LGizQwG0n0y3yL5lloi7lAhpgojSYmog&s',
      ativo: true,
      emPromocao: false,
      desconto: 0,
    ),
  ];

  void _addNewProduct() async {
    var produto = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProductFormPage(),
      ),
    );
    if (produto != null) {
      setState(() {
        productData.add(produto);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista e Cadastro de Produto',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.deepPurple[100],
      body: ProductDetailsPage(productData: productData),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewProduct,
        label: const Text('Novo Produto', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  final List<ProdutoModel> productData;

  const ProductDetailsPage({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return productData.isEmpty
        ? const Center(
            child: Text(
              'Nenhum produto cadastrado.',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.only(bottom: 75),
            itemCount: productData.length,
            itemBuilder: (context, index) {
              final product = productData[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.label, color: Colors.deepPurple),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              product.nome,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (product.imagem != null && product.imagem!.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.imagem!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(child: Text('Imagem não carregada')),
                          ),
                        ),
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ChipInfoWidget(
                              label: 'Compra R\$ ${product.precoCompra.toStringAsFixed(2)}',
                              icon: Icons.shopping_cart,
                            ),
                            const SizedBox(width: 8),
                            ChipInfoWidget(
                              label: 'Venda R\$ ${product.precoVenda.toStringAsFixed(2)}',
                              icon: Icons.attach_money,
                            ),
                            const SizedBox(width: 8),
                            ChipInfoWidget(
                              label: 'Qtd ${product.quantidade}',
                              icon: Icons.inventory,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.category, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            'Categoria: ${product.categoria}',
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.description, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text('Descrição: ${product.descricao}',
                                style: const TextStyle(fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Icon(
                              product.ativo ? Icons.check_circle : Icons.cancel,
                              color: product.ativo ? Colors.green : Colors.red,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              product.ativo ? 'Ativo' : 'Inativo',
                              style: const TextStyle(fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              product.emPromocao ? Icons.discount : Icons.price_check,
                              color: product.emPromocao ? Colors.orange : Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              product.emPromocao ? 'Em Promoção' : 'Sem Promoção',
                              style: const TextStyle(fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.percent, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text(
                              'Desconto: ${product.desconto.toStringAsFixed(0)}%',
                              style: const TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
