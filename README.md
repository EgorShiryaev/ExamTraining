# ExamTraining

Мобильное приложение для хранения информации об экзаменах и задачах.

Мобильное приложение было разработанно в рамках Учебной практики.

Apk файл можно скачать [тут](https://github.com/EgorShiryaev/ExamTraining/releases).

## Начало работы

Перед запуском приложения необходимо установить все программное обеспечение перечисленное в разделе "Необходимое ПО". 

Только после того как у вас установлено всё ПО, вы можете переходить к разделу "Запуск приложения".

### Необходимое ПО

- [flutter 2.10.4](https://docs.flutter.dev/development/tools/sdk/releases)
- [Xcode](https://apps.apple.com/ru/app/xcode/id497799835?mt=12)
- [Android Studio](https://developer.android.com/studio)
- [Visual Studio Code](https://code.visualstudio.com/)

После того как скачается flutter, следуйте этим [инструкциям](https://docs.flutter.dev/get-started/install).

Для настройки редактора кода, следуйте этим [инструкциям](https://docs.flutter.dev/get-started/editor?tab=vscode).

### Запуск приложения

Откройте проект в редакторе кода. Запустите терминал в папке проекта. Затем установите все необходимые пакеты командой:

```
flutter pub get
```

После успешной загрузки пакетов запустите эмулятор и напишите команду в терминал:

```
flutter run
```

Подробнее о запуске приложения flutter можно узнать [тут](https://docs.flutter.dev/get-started/test-drive?tab=vscode).

## Разработка

Базой данных является [Firebase Cloud Firestore](https://firebase.google.com/docs/firestore).

Сервисом авторизации - [Firebase Authentication](https://firebase.google.com/docs/auth).

## Скрины

![StartPage](https://user-images.githubusercontent.com/80877621/196911232-4f8e5c8a-2777-4960-92f7-0399a1f4fff4.png)
![LoginPage](https://user-images.githubusercontent.com/80877621/196911224-cebf0531-cb96-4928-8835-f4298f079a56.png)

![ExamsPage](https://user-images.githubusercontent.com/80877621/196911219-655b254f-00c9-4463-9ef8-606f60ad0a67.png)
![AddExamPage](https://user-images.githubusercontent.com/80877621/196911206-6fd9b4a4-2b79-4d0f-9678-60676b0ca56f.png)

![EditExamPage](https://user-images.githubusercontent.com/80877621/196911213-f270c883-d4b0-4def-b8ad-ea3534175e09.png)
![EditExamTicketsPage](https://user-images.githubusercontent.com/80877621/196911215-354bc019-9a68-4b88-8e53-9152b953e106.png)

![ExamTicketsPage](https://user-images.githubusercontent.com/80877621/196911222-b76ff9d9-ffb4-4a15-a66c-8da4d8f0388d.png)
![TasksPage](https://user-images.githubusercontent.com/80877621/196911239-438e9aca-0a9f-4b6d-985b-c0b96f5cfa19.png)

![AddTaskPage](https://user-images.githubusercontent.com/80877621/196911209-fdcb6d5a-2552-489c-89c7-6aecf11a5f18.png)
![EditTaskPage](https://user-images.githubusercontent.com/80877621/196911217-473bcf68-5808-464f-8cf9-37ed3505ca0d.png)

![TaskInfoPage](https://user-images.githubusercontent.com/80877621/196911235-3dee49b7-130d-4db6-a4f9-0701df6b70ea.png)
![ProfilePage](https://user-images.githubusercontent.com/80877621/196911229-8a23db45-3f86-43b7-aa5d-a0bc561593b5.png)

![ProfileOptionsPage](https://user-images.githubusercontent.com/80877621/196911226-5c9cfdf1-1362-4151-9f98-793039e978c9.png)
