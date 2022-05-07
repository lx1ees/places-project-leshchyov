import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/model/location_point.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/model/place_type.dart';
import 'package:places/domain/model/place_type_filter_entity.dart';

List<Place> placesMock = [
  Place(
    name: 'Астраханский кремль',
    point: const LocationPoint(lat: 46.34916573351107, lon: 48.03225584602448),
    urls: const [
      'http://ic.pics.livejournal.com/astkraeved/50753361/113492/113492_original.jpg',
      'http://ic.pics.livejournal.com/astkraeved/50753361/113492/113492_original.jpg',
      'http://ic.pics.livejournal.com/astkraeved/50753361/113492/113492_original.jpg',
    ],
    description:
        'Целостный ансамбль памятников оборонного зодчества, культовой и гражданской архитектуры.',
    placeType: placeTypesMock.findById(id: AppStrings.templeTypeId),
  ),
  Place(
    name: 'Памятник Петру I',
    point: const LocationPoint(lat: 46.347543009464154, lon: 48.0161004460226),
    urls: const [
      'https://smorodina.com/uploads/image/image/63839/DSC01020_small.jpg',
      'https://smorodina.com/uploads/image/image/63839/DSC01020_small.jpg',
      'https://smorodina.com/uploads/image/image/63839/DSC01020_small.jpg',
      'https://smorodina.com/uploads/image/image/63839/DSC01020_small.jpg',
    ],
    description:
        'Энергично шагающая фигура царя и одновременно смотрящая в сторону Волги. Памятник выполнен из бронзы и установлен на постаменте из розового гранита в виде указателя сторон света, на лучах которого установлены четыре кованных якоря и буквы морского компаса, соответствующие сторонам света. Общая высота памятника с постаментом 9 м, его дополняет кованый свиток с выдержкой из указа об образовании Астраханской губернии, который возложен на подножие постамента.',
    placeType: placeTypesMock.findById(id: AppStrings.templeTypeId),
  ),
  Place(
    name: 'Городская набережная',
    point: const LocationPoint(lat: 46.35408370923373, lon: 48.02939603968672),
    urls: const [
      'https://prozhektor.info/wp-content/uploads/2020/05/EBCZsSbW4AEfLft.jpg',
      'https://prozhektor.info/wp-content/uploads/2020/05/EBCZsSbW4AEfLft.jpg',
    ],
    description:
        'Городская набережная Астрахани в нынешнем виде появилась в результате реконструкции 2007-2009 годов в предверии празднования 450-летия города на деньги корпорации «Газпром». Сейчас на набережной много туристических объектов для фотографий.',
    placeType: placeTypesMock.findById(id: AppStrings.templeTypeId),
  ),
  Place(
    name: 'Музыкальный фонтан',
    point: const LocationPoint(lat: 46.35274991858566, lon: 48.02711255213182),
    urls: const [
      'https://vetert.ru/rossiya/astrakhan/sights/140-muzykalnyj-fontan/03.png',
      'https://vetert.ru/rossiya/astrakhan/sights/140-muzykalnyj-fontan/03.png',
      'https://vetert.ru/rossiya/astrakhan/sights/140-muzykalnyj-fontan/03.png',
    ],
    description:
        'Одна из главных достопримечательностей набережной реки Волга является светомузыкальный фонтан «Петровский», построенный в 2009 году. Он был назван в честь императора Петра I после проведения среди горожан специального конкурса. Фонтан окружен балюстрадой из небольших фонтанов. Диаметр его составляет 8 м, высота - 3,5 м. У фонтана есть несколько уровней, из которых во время светомузыкального представления в такт с музыкой танцуют цветные струи воды. Очень красивое зрелище!',
    placeType: placeTypesMock.findById(id: AppStrings.templeTypeId),
  ),
  Place(
    name: 'Астраханский государственный театр Оперы и Балета',
    point:
        const LocationPoint(lat: 46.360495591636514, lon: 48.044221555826134),
    urls: const [
      'https://amuzteatr.ru/wp-content/uploads/2016/11/teatr-opera.jpg',
      'https://amuzteatr.ru/wp-content/uploads/2016/11/teatr-opera.jpg',
      'https://amuzteatr.ru/wp-content/uploads/2016/11/teatr-opera.jpg',
      'https://amuzteatr.ru/wp-content/uploads/2016/11/teatr-opera.jpg',
      'https://amuzteatr.ru/wp-content/uploads/2016/11/teatr-opera.jpg',
    ],
    description:
        'Астраханский государственный театр оперы и балета построен в 2011 году в "псевдорусском" стиле с элементами стиля модерн. Первый сезон открыл симфонический оркестр Мариинского театра под управлением Валерия Гергиева.Концертный зал вмещает до 1,2 тыс. зрителей, общая площадь театра – 52 тыс. квадратных метров. При проектировании концертного зала проводились со специалистами парижской "Гранд опера" и петербургского Мариинского театра. Специалисты отмечают непревзойденную акустику Астраханского государственного театра оперы и балета. Астраханский государственный театр оперы и балета построен в 2011 году в "псевдорусском" стиле с элементами стиля модерн. Первый сезон открыл симфонический оркестр Мариинского театра под управлением Валерия Гергиева.Концертный зал вмещает до 1,2 тыс. зрителей, общая площадь театра – 52 тыс. квадратных метров. При проектировании концертного зала проводились со специалистами парижской "Гранд опера" и петербургского Мариинского театра. Специалисты отмечают непревзойденную акустику Астраханского государственного театра оперы и балета. Астраханский государственный театр оперы и балета построен в 2011 году в "псевдорусском" стиле с элементами стиля модерн. Первый сезон открыл симфонический оркестр Мариинского театра под управлением Валерия Гергиева.Концертный зал вмещает до 1,2 тыс. зрителей, общая площадь театра – 52 тыс. квадратных метров. При проектировании концертного зала проводились со специалистами парижской "Гранд опера" и петербургского Мариинского театра. Специалисты отмечают непревзойденную акустику Астраханского государственного театра оперы и балета.',
    placeType: placeTypesMock.findById(id: AppStrings.museumTypeId),
  ),
  Place(
    name: 'Усадьба М. А. Шелехова',
    point: const LocationPoint(lat: 46.35303348430326, lon: 48.04749808281461),
    urls: const [
      'https://ic.pics.livejournal.com/shella_la/54713443/246178/246178_900.jpg',
      'https://ic.pics.livejournal.com/shella_la/54713443/246178/246178_900.jpg',
      'https://ic.pics.livejournal.com/shella_la/54713443/246178/246178_900.jpg',
    ],
    description:
        'Дом был построен в 1880-е годы и владела им некая Скорнякова, а собственностью рыбопромышленника М.А. Шелехова он стал в 1904г. После революции и по сей день здание занимает туберкулёзный диспансер. Считается, что сам Шелехов завещал дом мед.учреждению в память о дочери, умершей от этой болезни.',
    placeType: placeTypesMock.findById(id: AppStrings.museumTypeId),
  ),
  Place(
    name: 'Дом купца Тетюшинова Г.В.',
    point: const LocationPoint(lat: 46.35500666438446, lon: 48.04372892883719),
    urls: const [
      'https://prousadbi.ru/wp-content/uploads/2014/03/113c2c15557d.jpg',
    ],
    description:
        'Музейно-культурный центр "Дом купца Тетюшинова" расположился в резном деревянном тереме по ул. Коммунистической. Это единственный образец деревянного зодчества XIX века, сохранившийся во всем Нижнем Поволжье.',
    placeType: placeTypesMock.findById(id: AppStrings.museumTypeId),
  ),
  Place(
    name: 'Сквер Гейдара Алиева',
    point: const LocationPoint(lat: 46.343267805146695, lon: 48.02028376932002),
    urls: const [
      'https://sun9-70.userapi.com/sun9-55/impf/c844617/v844617665/686ca/eYwIG12YQCI.jpg?size=807x538&quality=96&sign=080c2e80c51b5f95a063db7e0fd8bbd5&type=album',
    ],
    description:
        'Сквер был создан вокруг установленного в 2010 году памятника первому президенту Азербайджана Гейдару Алиеву.',
    placeType: placeTypesMock.findById(id: AppStrings.parkTypeId),
  ),
];

final List<Place> toVisitPlaces = [...placesMock.take(3)];
final List<Place> visitedPlaces = [...placesMock.reversed.take(3)];

const List<PlaceType> placeTypesMock = [
  PlaceType(
    id: AppStrings.hotelTypeId,
    name: AppStrings.hotelPlaceTypeName,
  ),
  PlaceType(
    id: AppStrings.restaurantTypeId,
    name: AppStrings.restaurantPlaceTypeName,
  ),
  PlaceType(
    id: AppStrings.templeTypeId,
    name: AppStrings.templePlaceTypeName,
  ),
  PlaceType(
    id: AppStrings.parkTypeId,
    name: AppStrings.parkPlaceTypeName,
  ),
  PlaceType(
    id: AppStrings.museumTypeId,
    name: AppStrings.museumPlaceTypeName,
  ),
  PlaceType(
    id: AppStrings.cafeTypeId,
    name: AppStrings.cafePlaceTypeName,
  ),
];

List<PlaceTypeFilterEntity> placeTypeFiltersMock = [
  PlaceTypeFilterEntity(
    iconPath: AppAssets.hotelIcon,
    placeType: placeTypesMock.findById(id: AppStrings.hotelTypeId),
  ),
  PlaceTypeFilterEntity(
    iconPath: AppAssets.restaurantIcon,
    placeType: placeTypesMock.findById(id: AppStrings.restaurantTypeId),
  ),
  PlaceTypeFilterEntity(
    iconPath: AppAssets.particularPlaceIcon,
    placeType:
        placeTypesMock.findById(id: AppStrings.templeTypeId),
  ),
  PlaceTypeFilterEntity(
    iconPath: AppAssets.parkIcon,
    placeType: placeTypesMock.findById(id: AppStrings.parkTypeId),
  ),
  PlaceTypeFilterEntity(
    iconPath: AppAssets.museumIcon,
    placeType: placeTypesMock.findById(id: AppStrings.museumTypeId),
  ),
  PlaceTypeFilterEntity(
    iconPath: AppAssets.cafeIcon,
    placeType: placeTypesMock.findById(id: AppStrings.cafeTypeId),
  ),
];
