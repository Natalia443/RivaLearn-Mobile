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
      subtitle: 'textos de dominio publico en diversos idiomas',
      icon: Icons.book,
      link: '/default_texts'),
  MenuItem(
      title: 'Diccionario',
      subtitle: 'Busqueda de palabras',
      icon: Icons.menu_book,
      link: '/dictionary'),
];
