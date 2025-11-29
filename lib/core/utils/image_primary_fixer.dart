import 'package:drift/drift.dart';
import '../database/database.dart';

/// Utility to fix existing property images by setting the first image as primary
class ImagePrimaryFixer {
  final AppDatabase database;

  ImagePrimaryFixer(this.database);

  /// Fix all properties to have their first image marked as primary
  Future<void> fixPropertyImages() async {
    print('DEBUG: Starting image primary fix...');

    // Get all properties
    final properties = await database.select(database.properties).get();
    print('DEBUG: Found ${properties.length} properties');

    int fixedCount = 0;
    for (final property in properties) {
      // Get all images for this property, ordered by display order
      final images = await (database.select(database.propertyImages)
            ..where((tbl) => tbl.propertyId.equals(property.id))
            ..orderBy([(tbl) => OrderingTerm(expression: tbl.displayOrder)]))
          .get();

      if (images.isEmpty) {
        print('DEBUG: Property ${property.id} has no images');
        continue;
      }

      print('DEBUG: Property ${property.id} has ${images.length} images');

      // Check if any image is already marked as primary
      final hasPrimary = images.any((img) => img.isPrimary);
      print('DEBUG: Property ${property.id} hasPrimary: $hasPrimary');

      if (!hasPrimary && images.isNotEmpty) {
        // Mark the first image as primary
        await (database.update(database.propertyImages)
              ..where((tbl) => tbl.id.equals(images.first.id)))
            .write(
          PropertyImagesCompanion(
            isPrimary: Value(true),
          ),
        );
        fixedCount++;
        print(
            'DEBUG: Marked first image as primary for property ${property.id}');
      }
    }

    print('DEBUG: Fixed $fixedCount properties');
  }
}
