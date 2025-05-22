class ProdutoModel {
  String nome;
  double precoCompra;
  double precoVenda;
  int quantidade;
  String descricao;
  String categoria;
  String? imagem;
  bool ativo;
  bool emPromocao;
  double desconto;

  ProdutoModel({
    required this.nome,
    required this.precoCompra,
    required this.precoVenda,
    required this.quantidade,
    required this.descricao,
    required this.categoria,
    required this.imagem,
    required this.ativo,
    required this.emPromocao,
    required this.desconto,
  });

  // ✅ Converte para Map (para salvar na lista ou banco)
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'preco_compra': precoCompra,
      'preco_venda': precoVenda,
      'quantidade': quantidade,
      'descricao': descricao,
      'categoria': categoria,
      'imagem': imagem,
      'ativo': ativo,
      'em_promocao': emPromocao,
      'desconto': desconto,
    };
  }

  // ✅ Cria um Produto a partir de um Map
  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      nome: map['nome'] ?? '',
      precoCompra: (map['preco_compra'] ?? 0).toDouble(),
      precoVenda: (map['preco_venda'] ?? 0).toDouble(),
      quantidade: (map['quantidade'] ?? 0).toInt(),
      descricao: map['descricao'] ?? '',
      categoria: map['categoria'] ?? '',
      imagem: map['imagem'],
      ativo: map['ativo'] ?? false,
      emPromocao: map['em_promocao'] ?? false,
      desconto: (map['desconto'] ?? 0).toDouble(),
    );
  }
}
