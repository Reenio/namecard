import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namecard/providers/storage_provider.dart';
import 'package:namecard/models/namecard.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _titleController;
  late TextEditingController _emailController;
  late TextEditingController _githubController;
  late TextEditingController _linkedinController;
  late TextEditingController _webpageController;
  late TextEditingController _bioController;

  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _titleController = TextEditingController();
    _emailController = TextEditingController();
    _githubController = TextEditingController();
    _linkedinController = TextEditingController();
    _webpageController = TextEditingController();
    _bioController = TextEditingController();
  }

  void _initFieldsOptions(Namecard myCard) {
    if (_initialized) return;
    _nameController.text = myCard.name;
    _titleController.text = myCard.title ?? '';
    _emailController.text = myCard.email ?? '';
    _githubController.text = myCard.github ?? '';
    _linkedinController.text = myCard.linkedin ?? '';
    _webpageController.text = myCard.webpage ?? '';
    _bioController.text = myCard.bio ?? '';
    _initialized = true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _emailController.dispose();
    _githubController.dispose();
    _linkedinController.dispose();
    _webpageController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _saveProfile(Namecard myCard) async {
    if (_formKey.currentState!.validate()) {
      myCard.name = _nameController.text;
      myCard.title = _titleController.text;
      myCard.email = _emailController.text;
      myCard.github = _githubController.text;
      myCard.linkedin = _linkedinController.text;
      myCard.webpage = _webpageController.text;
      myCard.bio = _bioController.text;

      await ref.read(storageServiceProvider).updateMyNamecard(myCard);
      ref.invalidate(myNamecardProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile saved successfully!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final myCardAsync = ref.watch(myNamecardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Namecard', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: myCardAsync.when(
        data: (myCard) {
          if (myCard == null) return const Center(child: Text('No profile found.'));
          
          _initFieldsOptions(myCard);

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const Text(
                  'Fill out the details you want to share with others.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name *', 
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Name is required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title / Role', 
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.work),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email', 
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _githubController,
                  decoration: InputDecoration(
                    labelText: 'GitHub Username', 
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.code),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _linkedinController,
                  decoration: InputDecoration(
                    labelText: 'LinkedIn URL', 
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.link),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _webpageController,
                  decoration: InputDecoration(
                    labelText: 'Webpage URL', 
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.language),
                  ),
                  keyboardType: TextInputType.url,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _bioController,
                  decoration: InputDecoration(
                    labelText: 'Bio', 
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.info),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () => _saveProfile(myCard),
                  icon: const Icon(Icons.save),
                  label: const Text('Save Profile', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
