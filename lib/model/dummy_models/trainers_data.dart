import '../../res/app_images.dart';

class TrainersData {
  final String image;
  final String title;
  final String subtitles;

  TrainersData(this.image, this.title, this.subtitles);
}

List<TrainersData> trainersData = [
  TrainersData(AppImages.beginnerPet, 'Training for beginner pets',
      'Lorem ipsum dolor sit amet consectetur. Sit nisi eget sit urna tortor ve'),
  TrainersData(AppImages.intermidiatePet, 'Training for intermediate pets',
      'Lorem ipsum dolor sit amet consectetur. Sit nisi eget sit urna tortor ve'),
  TrainersData(AppImages.proPet, 'Training for pro pets',
      'Lorem ipsum dolor sit amet consectetur. Sit nisi eget sit urna tortor ve'),
  TrainersData(AppImages.lovedPet, 'Training for tough love pets',
      'Lorem ipsum dolor sit amet consectetur. Sit nisi eget sit urna tortor ve')
];
