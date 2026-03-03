import 'package:flutter/material.dart';
import 'package:namecard/models/namecard.dart';

class NamecardDetailsScreen extends StatelessWidget {
  final Namecard card;

  const NamecardDetailsScreen({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            Text(
              card.name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            if (card.title != null && card.title!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  card.title!,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            const SizedBox(height: 32),
            const Divider(),
            if (card.email != null && card.email!.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                subtitle: Text(card.email!),
                onTap: () {
                  // To be implemented: launch email client
                },
              ),
            if (card.github != null && card.github!.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.code),
                title: const Text('GitHub'),
                subtitle: Text(card.github!),
                onTap: () {
                  // To be implemented: launch url
                },
              ),
            if (card.linkedin != null && card.linkedin!.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.link),
                title: const Text('LinkedIn'),
                subtitle: Text(card.linkedin!),
                onTap: () {
                  // To be implemented: launch url
                },
              ),
            if (card.webpage != null && card.webpage!.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Webpage'),
                subtitle: Text(card.webpage!),
                onTap: () {
                  // To be implemented: launch url
                },
              ),
            if (card.bio != null && card.bio!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Bio', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 8),
                      Text(card.bio!),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
