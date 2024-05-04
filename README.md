# Explorando el mundo de Flutter: Creando una Aplicación de Pokémon con Firebase

En la intersección de la pasión por Pokémon y el desarrollo de aplicaciones móviles, Flutter emerge como una herramienta poderosa para dar vida a nuestras ideas. En este artículo, nos adentraremos en el fascinante universo de **Flutter, un framework multiplataforma de código abierto creado por Google, mientras exploramos los fundamentos de su uso para el desarrollo de aplicaciones móviles.**

A lo largo de esta guía, aprenderemos a construir una aplicación móvil que se conecta a la PokeAPI para obtener información sobre nuestros queridos Pokémon, y además implementaremos un sistema de inicio de sesión utilizando Firebase Authentication de Google. Desde la instalación de Flutter hasta la implementación de funciones avanzadas, este viaje nos llevará a través de los aspectos básicos de desarrollo de aplicaciones con Flutter, proporcionando una base sólida para proyectos futuros.

## 1. Instalación de Flutter

Para esta ocasión vamos a instalar Flutter dentro de Windows. Pero puedes seguir el paso a paso de la instalación en tu SO desde la [documentación de Flutter](https://docs.flutter.dev/get-started/install)


### Requisitos Previos
- Asegúrate de tener al menos 4 GB de espacio libre en disco y 8 GB de RAM en tu computadora.
- Se requiere Windows 7 o posterior (64 bits).

### Pasos

1. **Descargar el SDK de Flutter:**
   - Visita el [sitio web oficial de Flutter](https://docs.flutter.dev/get-started/install/windows/mobile?tab=download) y descarga la última versión del SDK de Flutter para Windows.

2. **Extraer el SDK de Flutter:**
   - Encuentra la ubicación donde descargaste el SDK de Flutter.
   - Extrae el archivo zip en una ubicación fácilmente accesible en tu computadora, como `C:\src\flutter`.

3. **Agregar Flutter al PATH del sistema:**
   - Abre el menú de inicio y busca "Variables de entorno" y selecciona "Editar variables de entorno del sistema".
   - Haz clic en "Variables de entorno".
   - En la sección "Variables del sistema", busca y selecciona la variable "Path" y haz clic en "Editar".
   - Haz clic en "Nuevo" y agrega la ruta donde extrajiste el SDK de Flutter. Por ejemplo, `C:\src\flutter\bin`.
   - Guarda los cambios y cierra todas las ventanas.

4. **Instalar el plugin de Flutter para el editor de código (opcional):**
   - Si estás utilizando Visual Studio Code, puedes instalar la extensión Flutter desde el Marketplace.
   - Abre Visual Studio Code, ve a la pestaña de extensiones y busca "Flutter". Instala la extensión proporcionada por Dart Code.

5. **Verificar la instalación de Flutter:**
   - Abre una nueva terminal (PowerShell o CMD) y ejecuta el comando `flutter doctor`.
   - Este comando verificará la instalación de Flutter y te proporcionará orientación sobre cualquier configuración adicional que puedas necesitar. *Si tienes algún problema con la configuración, siempre puedes buscar en la documentación o googlear el problema*.

6. **Actualizar Flutter y Dart (opcional):**
   - Puedes ejecutar el comando `flutter upgrade` para actualizar Flutter a la última versión disponible.
   - También puedes ejecutar el comando `flutter pub global activate dart_style` para asegurarte de tener la última versión de Dart Style, que es útil para formatear el código Dart.

¡Listo! Has completado la instalación de Flutter en tu sistema Windows. Ahora estás listo para comenzar a desarrollar aplicaciones móviles con Flutter.

## 2. Configuración de Firebase con Flutter

Antes de configurar Firebase, te explico brevemente que es. Firebase es una plataforma de desarrollo de aplicaciones móviles y web creada por Google que proporciona una variedad de herramientas y servicios para ayudarte a construir aplicaciones móviles de alta calidad, escalables y con características avanzadas sin tener que preocuparte por la infraestructura subyacente. Es ideal tanto para desarrolladores principiantes como para expertos que desean crear aplicaciones potentes de forma rápida y sencilla. Entre sus servicios se destacan, autenticación de usuarios, base de datos en tiempo real, almacenamiento en la nube, notificaciones push, análisis de datos, funciones en la nube y capacidades de aprendizaje automático.
Pero en este ejemplo solo usaremos la autenticación de usuarios.

### Pasos

1. **Creación de proyecto en Firebase:**
   - Vas a **[Firebase](https://firebase.google.com)** e ingresas con tu cuenta de Google.
   - Le das a **comenzar** y completa las indicaciones para crear tu primer proyeco en **Firebase**. Es súper sencillo.
2. **Instalación de Firebase CLI:**
   - Para usar algunas dependencias que nos ayudan a conectar Flutter con Firebase necesitamos su CLI.
   - Se puede descargar con **[npm](https://nodejs.org/en)** con el siguiente comando, o a través de un binario (mas información [aquí](https://firebase.google.com/docs/cli?hl=es)):
     
     ```shell
     npm install -g firebase-tools
     ```
   - Puede verificar la instalación iniciando sesión en Firebase con su cuenta de Google ejecutando el siguiente comando:
      
     ```shell
     firebase login
     ```
   - Pruebe que la CLI esté instalada correctamente enumerando sus proyectos de Firebase. Ejecute el siguiente comando:

     ```shell
     firebase projects:list
     ```
   - Si todo esta correcto, puedes pasar al siguiente paso.
3. **Inicialización de FlutterFire**
   - FlutterFire es un conjunto de plugins de Flutter que permiten a las aplicaciones de Flutter utilizar los servicios de Firebase.
   - Como primer paso debes instalar el plugin firebase_core, que es responsable de conectar tu aplicación a Firebase. Instala el plugin ejecutando el siguiente comando desde la **raíz del proyecto:**

     ```shell
     flutter pub add firebase_core
     ```
   - Instalar FlutterFire CLI:
     
     ```shell
     # Install the CLI if not already done so
      dart pub global activate flutterfire_cli
     ```
   - Luego crear la configuración del proyecto Firebase dentro del proyecto. Esto generará un archivo "firebase_options.dart" que contendrá todas las opciones necesarias para la inicialización.
     ```shell
     # Run the `configure` command, select a Firebase project and platforms
     flutterfire configure
     ```
4. **Configuración en el proyecto**
   - Primero ve a tu archivo main.dart dentro de lib/.
   - A continuación hay que proporcionar las opciones generadas al método initializeApp. Dado que esta es una operación asíncrona, la función principal puede ser modificada para asegurar que la inicialización se ha completado antes de ejecutar la aplicación. Primero importa el plugin firebase_core y el archivo generado firebase_options.dart:

     ```dart
     import 'package:firebase_core/firebase_core.dart';
     import 'firebase_options.dart';
     ```
   - A continuación, dentro de la función principal, asegúrate de que WidgetsFlutterBinding está inicializado y luego inicializa Firebase:

      ```dart
      void main() async {
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        runApp(MyApp());
      }
     ```
   - Listo. Ya puedes usar los servicios de Firebase dentro de tu app en Flutter!

      
   
     




