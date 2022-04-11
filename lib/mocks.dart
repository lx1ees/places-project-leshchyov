import 'package:places/constants/app_assets.dart';
import 'package:places/constants/app_strings.dart';
import 'package:places/domain/category_filter_entity.dart';
import 'package:places/domain/location_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_category.dart';

List<Sight> sightsMock = [
  Sight(
    name: 'Астраханский кремль',
    point: const LocationPoint(lat: 46.34916573351107, lon: 48.03225584602448),
    url:
        'https://media-cdn.tripadvisor.com/media/photo-s/06/a5/5e/a4/caption.jpg',
    details:
        'Целостный ансамбль памятников оборонного зодчества, культовой и гражданской архитектуры.',
    category: categoriesMock.findById(id: AppStrings.particularPlaceCategoryId),
  ),
  Sight(
    name: 'Памятник Петру I',
    point: const LocationPoint(lat: 46.347543009464154, lon: 48.0161004460226),
    url: 'https://smorodina.com/uploads/image/image/63839/DSC01020_small.jpg',
    details:
        'Энергично шагающая фигура царя и одновременно смотрящая в сторону Волги. Памятник выполнен из бронзы и установлен на постаменте из розового гранита в виде указателя сторон света, на лучах которого установлены четыре кованных якоря и буквы морского компаса, соответствующие сторонам света. Общая высота памятника с постаментом 9 м, его дополняет кованый свиток с выдержкой из указа об образовании Астраханской губернии, который возложен на подножие постамента.',
    category: categoriesMock.findById(id: AppStrings.particularPlaceCategoryId),
  ),
  Sight(
    name: 'Городская набережная',
    point: const LocationPoint(lat: 46.35408370923373, lon: 48.02939603968672),
    url:
        'https://prozhektor.info/wp-content/uploads/2020/05/EBCZsSbW4AEfLft.jpg',
    details:
        'Городская набережная Астрахани в нынешнем виде появилась в результате реконструкции 2007-2009 годов в предверии празднования 450-летия города на деньги корпорации «Газпром». Сейчас на набережной много туристических объектов для фотографий.',
    category: categoriesMock.findById(id: AppStrings.particularPlaceCategoryId),
  ),
  Sight(
    name: 'Музыкальный фонтан',
    point: const LocationPoint(lat: 46.35274991858566, lon: 48.02711255213182),
    url:
        'https://vetert.ru/rossiya/astrakhan/sights/140-muzykalnyj-fontan/03.png',
    details:
        'Одна из главных достопримечательностей набережной реки Волга является светомузыкальный фонтан «Петровский», построенный в 2009 году. Он был назван в честь императора Петра I после проведения среди горожан специального конкурса. Фонтан окружен балюстрадой из небольших фонтанов. Диаметр его составляет 8 м, высота - 3,5 м. У фонтана есть несколько уровней, из которых во время светомузыкального представления в такт с музыкой танцуют цветные струи воды. Очень красивое зрелище!',
    category: categoriesMock.findById(id: AppStrings.particularPlaceCategoryId),
  ),
  Sight(
    name: 'Астраханский государственный театр Оперы и Балета',
    point:
        const LocationPoint(lat: 46.360495591636514, lon: 48.044221555826134),
    url: 'https://amuzteatr.ru/wp-content/uploads/2016/11/teatr-opera.jpg',
    details:
        'Астраханский государственный театр оперы и балета построен в 2011 году в "псевдорусском" стиле с элементами стиля модерн. Первый сезон открыл симфонический оркестр Мариинского театра под управлением Валерия Гергиева.Концертный зал вмещает до 1,2 тыс. зрителей, общая площадь театра – 52 тыс. квадратных метров. При проектировании концертного зала проводились со специалистами парижской "Гранд опера" и петербургского Мариинского театра. Специалисты отмечают непревзойденную акустику Астраханского государственного театра оперы и балета.',
    category: categoriesMock.findById(id: AppStrings.museumCategoryId),
  ),
  Sight(
    name: 'Усадьба М. А. Шелехова',
    point: const LocationPoint(lat: 46.35303348430326, lon: 48.04749808281461),
    url:
        'https://ic.pics.livejournal.com/shella_la/54713443/246178/246178_900.jpg',
    details:
        'Дом был построен в 1880-е годы и владела им некая Скорнякова, а собственностью рыбопромышленника М.А. Шелехова он стал в 1904г. После революции и по сей день здание занимает туберкулёзный диспансер. Считается, что сам Шелехов завещал дом мед.учреждению в память о дочери, умершей от этой болезни.',
    category: categoriesMock.findById(id: AppStrings.museumCategoryId),
  ),
  Sight(
    name: 'Дом купца Тетюшинова Г.В.',
    point: const LocationPoint(lat: 46.35500666438446, lon: 48.04372892883719),
    url: 'https://prousadbi.ru/wp-content/uploads/2014/03/113c2c15557d.jpg',
    details:
        'Музейно-культурный центр "Дом купца Тетюшинова" расположился в резном деревянном тереме по ул. Коммунистической. Это единственный образец деревянного зодчества XIX века, сохранившийся во всем Нижнем Поволжье.',
    category: categoriesMock.findById(id: AppStrings.museumCategoryId),
  ),
  Sight(
    name: 'Сквер Гейдара Алиева',
    point: const LocationPoint(lat: 46.343267805146695, lon: 48.02028376932002),
    url:
        'https://sun9-70.userapi.com/sun9-55/impf/c844617/v844617665/686ca/eYwIG12YQCI.jpg?size=807x538&quality=96&sign=080c2e80c51b5f95a063db7e0fd8bbd5&type=album',
    details:
        'Сквер был создан вокруг установленного в 2010 году памятника первому президенту Азербайджана Гейдару Алиеву.',
    category: categoriesMock.findById(id: AppStrings.parkCategoryId),
  ),
];

const List<SightCategory> categoriesMock = [
  SightCategory(
    id: AppStrings.hotelCategoryId,
    name: AppStrings.hotelCategoryName,
  ),
  SightCategory(
    id: AppStrings.restaurantCategoryId,
    name: AppStrings.restaurantCategoryName,
  ),
  SightCategory(
    id: AppStrings.particularPlaceCategoryId,
    name: AppStrings.particularPlaceCategoryName,
  ),
  SightCategory(
    id: AppStrings.parkCategoryId,
    name: AppStrings.parkCategoryName,
  ),
  SightCategory(
    id: AppStrings.museumCategoryId,
    name: AppStrings.museumCategoryName,
  ),
  SightCategory(
    id: AppStrings.cafeCategoryId,
    name: AppStrings.cafeCategoryName,
  ),
];

List<CategoryFilterEntity> categoryFiltersMock = [
  CategoryFilterEntity(
    iconPath: AppAssets.hotelIcon,
    sightCategory: categoriesMock.findById(id: AppStrings.hotelCategoryId),
  ),
  CategoryFilterEntity(
    iconPath: AppAssets.restaurantIcon,
    sightCategory: categoriesMock.findById(id: AppStrings.restaurantCategoryId),
  ),
  CategoryFilterEntity(
    iconPath: AppAssets.particularPlaceIcon,
    sightCategory:
        categoriesMock.findById(id: AppStrings.particularPlaceCategoryId),
  ),
  CategoryFilterEntity(
    iconPath: AppAssets.parkIcon,
    sightCategory: categoriesMock.findById(id: AppStrings.parkCategoryId),
  ),
  CategoryFilterEntity(
    iconPath: AppAssets.museumIcon,
    sightCategory: categoriesMock.findById(id: AppStrings.museumCategoryId),
  ),
  CategoryFilterEntity(
    iconPath: AppAssets.cafeIcon,
    sightCategory: categoriesMock.findById(id: AppStrings.cafeCategoryId),
  ),
];
