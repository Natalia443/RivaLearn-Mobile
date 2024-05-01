import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String link;

  const MenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.link,
  });
}

const List<MenuItem> menuItems = [
  MenuItem(
      title: 'Textos Predeterminados',
      subtitle: 'Textos de dominio público en diversos idiomas',
      icon: Icons.book,
      link: '/default_texts'),
  MenuItem(
      title: 'Diccionario',
      subtitle: 'Búsqueda de palabras',
      icon: Icons.menu_book,
      link: '/dictionary'),
  MenuItem(
      title: 'Lector PDF',
      subtitle: 'Subí tu propio texto.',
      icon: Icons.bookmark_add,
      link: '/pdfviewer'),
  MenuItem(
      title: 'Decks',
      subtitle: 'Crea tus decks',
      icon: Icons.add_box_outlined,
      link: '/decks'),
];
