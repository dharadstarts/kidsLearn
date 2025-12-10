class SleepCategory {
  final String title;
  final List<SleepItemModel> items;

  SleepCategory({
    required this.title,
    required this.items,
  });
}

class SleepItemModel {
  final String title;
  final String bgImage;
  final String audioFile;

  SleepItemModel({
    required this.title,
    required this.bgImage,
    required this.audioFile,

  });
}

final List<SleepCategory> categories = [
  SleepCategory(
    title: "Nature",
    items: [
      SleepItemModel(
        title: "Cloud",
        bgImage: "assets/images/sleep/ic_cloud.png",
        audioFile: 'cloud_sound.mp3'
      ),
      SleepItemModel(
        title: "Tree",
        bgImage: "assets/images/sleep/ic_tree.png",
        audioFile: 'tree_sound.mp3'
      ),
      SleepItemModel(
        title: "Water wave",
        bgImage: "assets/images/sleep/ic_water_wave.png",
        audioFile: 'waterwaves_sound.mp3'
      ),
      SleepItemModel(
        title: "Wind",
        bgImage: "assets/images/sleep/ic_wind.png",
        audioFile: 'wind_sound.mp3'
      ),
      SleepItemModel(
        title: "Waterfall",
        bgImage: "assets/images/sleep/ic_waterfall.png",
        audioFile: 'waterfall_sound.mp3'
      ),
      SleepItemModel(
        title: "Moon",
        bgImage: "assets/images/sleep/ic_moon.png",
        audioFile: 'moon_sound.mp3'
      ),
      SleepItemModel(
        title: "Fire",
        bgImage: "assets/images/sleep/ic_fire.png",
        audioFile: 'fire_sound.mp3'
      ),
      SleepItemModel(
        title: "Heart",
        bgImage: "assets/images/sleep/ic_heart.png",
        audioFile: 'heartbeat_sound.mp3'
      ),

    ],
  ),

  SleepCategory(
    title: "Transport",
    items: [
      SleepItemModel(
        title: "Car",
        bgImage: "assets/images/sleep/ic_car.png",
        audioFile: 'car_sound.mp3'
      ),
      SleepItemModel(
        title: "Bus",
        bgImage: "assets/images/sleep/ic_bus.png",
        audioFile: 'bus_sound.mp3'
      ),
      SleepItemModel(
        title: "Train",
        bgImage: "assets/images/sleep/ic_train.png",
        audioFile: 'train_sound.mp3'
      ),
      SleepItemModel(
        title: "Plane",
        bgImage: "assets/images/sleep/ic_plane.png",
        audioFile: 'plane_sound.mp3'
      ),
    ],
  ),

  SleepCategory(
    title: "Household",
    items: [
      SleepItemModel(
        title: "Washing machine",
        bgImage: "assets/images/sleep/ic_washing_machine.png",
        audioFile: 'washingmachine_sound.mp3'
      ),
      SleepItemModel(
        title: "Vaccum",
        bgImage: "assets/images/sleep/ic_vaccum.png",
        audioFile: 'vacume_sound.mp3'
      ),
      SleepItemModel(
        title: "Watch",
        bgImage: "assets/images/sleep/ic_watch.png",
        audioFile: 'watch_sound.mp3'
      ),
      SleepItemModel(
        title: "Radio",
        bgImage: "assets/images/sleep/ic_radio.png",
        audioFile: 'radio_sound.mp3'
      ),
      SleepItemModel(
        title: "Hair dryer",
        bgImage: "assets/images/sleep/ic_hair_dryer.png",
        audioFile: 'hairdeyer_sound.mp3'
      ),
      SleepItemModel(
        title: "Table fan",
        bgImage: "assets/images/sleep/ic_table_fan.png",
        audioFile: 'tablefan_sound.mp3'
      ),
      SleepItemModel(
        title: "Shower",
        bgImage: "assets/images/sleep/ic_shower.png",
        audioFile: 'shower_sound.mp3'
      ),
    ],
  ),

  SleepCategory(
    title: "Animals",
    items: [
      SleepItemModel(
        title: "Cat",
        bgImage: "assets/images/sleep/ic_cat.png",
        audioFile: 'cat_sound.mp3'
      ),
      SleepItemModel(
        title: "Dog",
        bgImage: "assets/images/sleep/ic_dog.png",
        audioFile: 'dog_sound.mp3'
      ),
      SleepItemModel(
        title: "Elephant",
        bgImage: "assets/images/sleep/ic_elephant.png",
        audioFile: 'elephant_sound.mp3'
      ),
      SleepItemModel(
        title: "Sparrow",
        bgImage: "assets/images/sleep/ic_sparrow.png",
        audioFile: 'sparrow_sound.mp3'
      ),
      SleepItemModel(
        title: "Crow",
        bgImage: "assets/images/sleep/ic_crow.png",
        audioFile: 'crow_sound.mp3'
      ),
      SleepItemModel(
        title: "Horse",
        bgImage: "assets/images/sleep/ic_horse.png",
        audioFile: 'horse_sound.mp3'
      ),
      SleepItemModel(
        title: "Cow",
        bgImage: "assets/images/sleep/ic_cow.png",
        audioFile: 'cow_sound.mp3'
      ),
    ],
  ),
];
