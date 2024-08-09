import 'package:flutter/material.dart';
import 'package:foods/models/food_details_model.dart';
import 'package:foods/widgets/food_item_traits.dart';
import 'package:transparent_image/transparent_image.dart';

class FoodItem extends StatelessWidget {
  const FoodItem(
      {super.key, required this.foodItem, required this.selectedItem});

  final void Function() selectedItem;
  final FoodDetailsModel foodItem;
  String get getComplexityText {
    return foodItem.complexity.name[0].toUpperCase() +
        foodItem.complexity.name.substring(1);
  }

  String get getAffordabilityText {
    return foodItem.affordability.name[0].toUpperCase() +
        foodItem.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: selectedItem,
        splashColor:
            Theme.of(context).appBarTheme.foregroundColor!.withOpacity(0.3),
        child: Stack(
          children: [
            Hero(
              tag: foodItem.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(
                  foodItem.imageURL,
                ),
                fit: BoxFit.cover,
                height: 210,
                width: double.infinity,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 20,
                ),
                color: const Color.fromARGB(167, 0, 0, 0),
                child: Column(
                  children: [
                    Text(
                      foodItem.foodTitle,
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).appBarTheme.foregroundColor,
                      ),
                      overflow: TextOverflow
                          .ellipsis, //It helps us to working with the long text more then 2 lines.. it simply add ... if the text is long.
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FoodItemTraits(
                          icon: Icons.schedule,
                          label: '${foodItem.duration} min',
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        FoodItemTraits(
                          icon: Icons.work,
                          label: getComplexityText,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        FoodItemTraits(
                          icon: Icons.attach_money,
                          label: getAffordabilityText,
                        ),
                      ],
                    )
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
