```
<img src="https://github.com/MudriyIlya/MemeGenerator/blob/main/Pics/project_map.png" width="480" />
```

# Meme Generator

### Итоговый проект для "Сбер Школы iOS"

Выбрал тему приложения с созданием мемчиков.

### Экраны

**В приложении реализовано 5 экранов:** 

**Библиотека мемов** - тут хранятся созданные мемы (в файловой системе).

**Предпросмотр** - тут можно посмотреть мем, удалить мем из библиотеки или сохранить его в фото галерею.

**Настройки** - тут можно сменить тему на черную.

**Выбор шаблона** - Шаблоны приходят с сервера написаного на VAPOR и расположенного на Heroku.

**Экран редактирования** - На данном экране можно добавить текст или фото к шаблону мема.   

<img src="https://github.com/MudriyIlya/MemeGenerator/blob/main/Pics/edit.gif" width="240" />

---

### Использование сети

Для получения данных из сети интернет был написан свой backend на VAPOR'е на языке Swift.

---

### Хранение данных

Если нет сети интернет, то из Core Data достаются последние загруженные данные, а для хранения темы приложения используется UserDefaults.   

---

Для контроля качества стиля кода был использован SwiftLint

---

# Что должно быть в приложении

- [x] Использовать **Core Data** для хранения моделей данных
- [x] Использовать **KeyChain/UserDefaults** для пользовательских настроек
- [x] Использование **Swift styleguides** (**Google styleguides**)
- [x] Не использовать сторонние библиотеки (**кроме snapshot-тестов**)
- [x] Использовать сеть
- [x] Отображение медиа (аудио, видео, изображения) из сети
- [x] Минимальное количество экранов: **3**
- [x] Обязательно использовать **UINavigationController/TabBarController**
- [x] Deployment Target: **iOS 13**
- [ ] Покрытие модульными тестами **10%** и более
- [x] Хотя бы один **UI-тест** через **page object**
- [x] Хотя бы один **snapshot тест** (разрешается использовать внешнюю библиотеку)
- [x] Использование Архитектурных подходов и шаблонов проектирования
- [x] Верстка UI в коде
- [x] Обязательно использовать **UITableView/UICollectionView**
- [ ] Кастомные анимации
- [x] Swiftlint
- [ ] Системы аналитики и анализа крэшей  ( **с использованием сторонних зависимостей** )
