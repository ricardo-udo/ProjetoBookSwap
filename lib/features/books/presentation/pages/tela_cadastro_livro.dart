import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:book_swap/features/books/data/models/book.dart';
import 'package:provider/provider.dart';
import 'package:book_swap/providers/auth_provider.dart';
import 'package:book_swap/providers/book_provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class TelaCadastroLivro extends StatefulWidget {
  const TelaCadastroLivro({super.key});

  @override
  State<TelaCadastroLivro> createState() => _TelaCadastroLivroState();
}

class _TelaCadastroLivroState extends State<TelaCadastroLivro> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _pagesController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _synopsisController = TextEditingController();
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  String? _selectedGenre;
  String? _selectedCondition;
  String? _selectedAvailability;

  final List<String> _genres = [
    'Ficção',
    'Fantasia',
    'Distopia',
    'Romance',
    'Mistério',
    'Infantil',
    'Autoajuda',
    'História',
    'Técnico',
    'Poesia',
  ];

  final List<String> _conditions = [
    'Novo',
    'Praticamente novo',
    'Bom estado',
    'Estado regular',
    'Uso intenso',
  ];

  final List<String> _availabilities = [
    'Disponível',
    'Em negociação',
    'Não disponível',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _yearController.dispose();
    _pagesController.dispose();
    _publisherController.dispose();
    _synopsisController.dispose();
    super.dispose();
  }

  Future<void> _handleRegisterBook() async {
    // Valida o formulário antes de prosseguir
    if (!_formKey.currentState!.validate()) return;

    try {
      final user = context.read<AuthProvider>().user;

      final newBook = Book(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        author: _authorController.text.trim(),
        genre: _selectedGenre ?? '',
        year: int.tryParse(_yearController.text) ?? 0,
        pages: int.tryParse(_pagesController.text) ?? 0,
        synopsis: _synopsisController.text.trim(),
        imagePath: _selectedImage?.path ?? '',
        ownerId: user?.id ?? 'anonymous',
        ownerName: user?.name ?? 'Usuário',
        status: 'available',
        ownerAvatar: user?.avatar ?? '',
        publisher: _publisherController.text.trim(),
      );

      await context.read<BookProvider>().addBook(newBook);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Livro cadastrado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      context.go('/livros');
    } catch (e) {
      debugPrint('Erro ao cadastrar livro: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao cadastrar livro: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/livros'),
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text(
          'Adicionar Livro',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF4F7DF3),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDFE8FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.menu_book,
                        size: 32,
                        color: Color(0xFF4F7DF3),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Adicione um livro para troca',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Preencha as informações do livro que deseja disponibilizar.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _buildSectionTitle('Informações básicas'),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _titleController,
                  label: 'Título do livro *',
                  hint: 'Digite o título completo do livro',
                  icon: Icons.book_outlined,
                  required: true,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _authorController,
                  label: 'Autor *',
                  hint: 'Digite o nome do autor',
                  icon: Icons.person_outline,
                  required: true,
                ),
                const SizedBox(height: 16),
                _buildDropdown(
                  label: 'Gênero *',
                  hint: 'Selecione o gênero do livro',
                  value: _selectedGenre,
                  items: _genres,
                  onChanged: (value) =>
                      setState(() => _selectedGenre = value),
                  icon: Icons.local_offer_outlined,
                  required: true,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _yearController,
                        label: 'Ano de publicação',
                        hint: 'Ex: 2020',
                        icon: Icons.calendar_today_outlined,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        controller: _pagesController,
                        label: 'Número de páginas',
                        hint: 'Ex: 256',
                        icon: Icons.description_outlined,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _publisherController,
                  label: 'Editora',
                  hint: 'Digite a editora do livro (opcional)',
                  icon: Icons.business_outlined,
                ),
                const SizedBox(height: 28),
                _buildSectionTitle('Descrição'),
                const SizedBox(height: 16),
                _buildTextAreaField(
                  controller: _synopsisController,
                  label: 'Sinopse do livro *',
                  hint: 'Conte um pouco sobre o livro...',
                  maxLines: 6,
                  maxLength: 500,
                  icon: Icons.description_outlined,
                ),
                const SizedBox(height: 28),
                _buildSectionTitle('Imagem do livro'),
                const SizedBox(height: 16),
                _buildImageUploadArea(),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        label: 'Condição *',
                        hint: 'Selecione a condição',
                        value: _selectedCondition,
                        items: _conditions,
                        onChanged: (value) =>
                            setState(() => _selectedCondition = value),
                        icon: Icons.shield_outlined,
                        required: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDropdown(
                        label: 'Disponibilidade *',
                        hint: 'Selecione',
                        value: _selectedAvailability,
                        items: _availabilities,
                        onChanged: (value) =>
                            setState(() => _selectedAvailability = value),
                        icon: Icons.check_circle_outline,
                        required: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'A condição ajuda outros usuários a entenderem o estado do livro.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _handleRegisterBook,
                    icon: const Icon(Icons.add_box_outlined, size: 20),
                    label: const Text('Cadastrar Livro'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D3A7A),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2D3A7A),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool required = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: required
          ? (value) =>
              (value == null || value.trim().isEmpty) ? 'Campo obrigatório' : null
          : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF9CA3AF)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  Widget _buildTextAreaField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required int maxLines,
    required int maxLength,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Digite a sinopse do livro';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Icon(icon, color: const Color(0xFF9CA3AF)),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required IconData icon,
    bool required = false,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint),
      validator: required
          ? (v) => (v == null || v.isEmpty) ? 'Campo obrigatório' : null
          : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF9CA3AF)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(value: item, child: Text(item));
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildImageUploadArea() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF4F7DF3), width: 2),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: _selectedImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _selectedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    size: 48,
                    color: Color(0xFF4F7DF3),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Adicionar imagem do livro',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4F7DF3),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Toque para selecionar uma imagem',
                    style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
      ),
    );
  }
}
