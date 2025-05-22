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
        actions: const [
          IconButton(
            icon: Icon(Icons.list, color: Colors.white),
            onPressed: null,
          )
        ],
      ),
      backgroundColor: Colors.deepPurple[100],
      body: ProductDetailsPage(productData: productData),
    );
  }
}

class ProductDetailsPage extends StatefulWidget {
  final List<ProdutoModel> productData;

  const ProductDetailsPage({super.key, required this.productData});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var produto = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductFormPage(),
            ),
          );
          if (produto != null) {
            setState(() {
              widget.productData.add(produto);
            });
          }
        },
        label: const Text(
          'Novo Produto',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.deepPurple,
      ),
      body: widget.productData.isEmpty
          ? const Center(
              child: Text(
                'Nenhum produto cadastrado.',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 75),
              itemCount: widget.productData.length,
              itemBuilder: (context, index) {
                final product = widget.productData[index];
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
                        /// Nome
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

                        /// Imagem (se houver)
                        if (product.imagem != null && product.imagem.toString().isNotEmpty)
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
                        if (product.imagem != null && product.imagem.toString().isNotEmpty)
                          const SizedBox(height: 12),

                        /// Preços e quantidade
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ChipInfoWidget(
                                  label: 'Compra R\$ ${product.precoCompra}',
                                  icon: Icons.shopping_cart),
                              const SizedBox(
                                width: 8,
                              ),
                              ChipInfoWidget(
                                  label: 'Venda R\$ ${product.precoVenda}',
                                  icon: Icons.attach_money),
                              const SizedBox(
                                width: 8,
                              ),
                              ChipInfoWidget(
                                  label: 'Qtd ${product.quantidade}', icon: Icons.inventory),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        /// Categoria
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

                        /// Descrição
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

                        /// Status
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Icon(
                                product.ativo ? Icons.check_circle : Icons.cancel,
                                color: product.ativo ? Colors.green : Colors.red,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                product.ativo ? 'Ativo' : 'Inativo',
                                style: const TextStyle(fontWeight: FontWeight.w400),
                              ),

                              const SizedBox(
                                width: 12,
                              ),
                              // Informa se está em promoção
                              Icon(
                                product.emPromocao ? Icons.discount : Icons.price_check,
                                color: product.emPromocao ? Colors.orange : Colors.grey,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                product.emPromocao ? 'Em Promoção' : 'Sem Promoção',
                                style: const TextStyle(fontWeight: FontWeight.w400),
                              ),

                              const SizedBox(
                                width: 8,
                              ),
                              const Icon(
                                Icons.percent,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Desconto: ${product.desconto}%',
                                style: const TextStyle(fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final TextEditingController _productNameController = TextEditingController();
  final MoneyMaskedTextController _productPurchasePriceController = MoneyMaskedTextController(
    precision: 2,
  );
  final MoneyMaskedTextController _productSalePriceController = MoneyMaskedTextController(
    precision: 2,
  );

  final MoneyMaskedTextController _productQuantityController =
      MoneyMaskedTextController(precision: 0, decimalSeparator: '');
  final TextEditingController _productDescriptionController = TextEditingController();
  final TextEditingController _productImageController = TextEditingController();
  bool _productActive = true;
  String _productCategory = 'Eletrônicos';
  bool _productOnSale = false;
  double _discountValue = 0.0;

  bool _isValidQuantity(String quantity) {
    return int.tryParse(quantity) != null && int.parse(quantity) > 0;
  }

  void _cadastraProduto() {
    if (_productNameController.text.isEmpty) {
      _showSnackbar('Nome do produto é obrigatório!');
      return;
    }
    if (_productPurchasePriceController.text.isEmpty) {
      _showSnackbar('Preço de compra inválido!');
      return;
    }
    if (_productSalePriceController.text.isEmpty) {
      _showSnackbar('Preço venda inválido!');
      return;
    }
    if (_productQuantityController.text.isEmpty ||
        !_isValidQuantity(_productQuantityController.text)) {
      _showSnackbar('Quantidade inválida!');
      return;
    }
    if (_productDescriptionController.text.isEmpty) {
      _showSnackbar('Descrição do produto é obrigatória!');
      return;
    }

    final newProduct = ProdutoModel(
      nome: _productNameController.text,
      precoCompra: _productPurchasePriceController.numberValue ?? 0,
      precoVenda: _productSalePriceController.numberValue ?? 0,
      quantidade: _productQuantityController.numberValue?.toInt() ?? 0,
      descricao: _productDescriptionController.text,
      categoria: _productCategory,
      imagem: _productImageController.text,
      ativo: _productActive,
      emPromocao: _productOnSale,
      desconto: _discountValue,
    );

    Navigator.pop(context, newProduct);
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent,
        content: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastrando Produto',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: buildProductForm(),
      ),
      backgroundColor: Colors.deepPurple[100],
    );
  }

  Widget buildProductForm() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Informações do Produto',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFieldWidget(
                controller: _productNameController,
                labelText: 'Nome do produto',
                hintText: 'Informe o nome do produto',
                icon: const Icon(Icons.label)),
            const SizedBox(height: 12),
            TextFieldWidget(
              controller: _productPurchasePriceController,
              labelText: 'Preço de compra',
              hintText: 'Informe o preço de compra',
              icon: const Icon(Icons.attach_money),
              keyboard: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextFieldWidget(
              controller: _productSalePriceController,
              labelText: 'Preço de venda',
              hintText: 'Informe o preço de venda',
              icon: const Icon(Icons.money),
              keyboard: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextFieldWidget(
              controller: _productQuantityController,
              labelText: 'Quantidade em estoque',
              hintText: 'Informe a quantidade em estoque',
              icon: const Icon(Icons.inventory),
              keyboard: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextFieldWidget(
              controller: _productDescriptionController,
              labelText: 'Descrição',
              hintText: 'Informe a descrição do produto',
              maxLines: 5,
              icon: const Icon(Icons.description),
            ),
            const SizedBox(height: 12),
            InputDecorator(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Categoria',
                prefixIcon: const Icon(Icons.category),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFB0BEC5)),
                  borderRadius: BorderRadius.circular(15),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.indigoAccent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _productCategory,
                  isExpanded: true,
                  items: ['Eletrônicos', 'Roupas', 'Calçados', 'Alimentos']
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _productCategory = value!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFieldWidget(
              controller: _productImageController,
              labelText: 'URL da imagem',
              hintText: 'Informe a imagem do produto',
              maxLines: 1,
              icon: const Icon(Icons.image),
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              title: const Text('Produto Ativo'),
              value: _productActive,
              onChanged: (value) {
                setState(() {
                  _productActive = value!;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Produto em Promoção'),
              value: _productOnSale,
              onChanged: (value) {
                setState(() {
                  _productOnSale = value;
                });
              },
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Desconto (%)'),
                Slider(
                  value: _discountValue,
                  min: 0,
                  max: 90,
                  divisions: 20,
                  label: '${_discountValue.round()}%',
                  onChanged: (value) {
                    setState(() {
                      _discountValue = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _cadastraProduto,
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text(
                'Cadastrar Produto',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context, null),
              icon: const Icon(Icons.cancel, color: Colors.white),
              label: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboard,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboard,
      maxLines: maxLines,
    );
  }
}
