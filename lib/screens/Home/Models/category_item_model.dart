enum CategoryId { alphabets, numbers, animals, birds, bodyParts, colors, shapes, vegetables }

class CategoryItemsList {
  final CategoryId id;
  final String title;
  final String iconAsset;

  const CategoryItemsList({
    required this.id,
    required this.title,
    required this.iconAsset,
  });
}

class CategoryItem {
  final String label;
  final String imageAsset;

  CategoryItem({
    required this.label,
    required this.imageAsset,
  });
}
