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

## 3. Empezar a programar la aplicación

Antes de empezar a codear, te quiero dar algunos conceptos que aplicamos en este proyecto {INSERTAR COCEPTOS DE ARQUITECTURA LIMPIA, INYECCIÓN DE DEPENDENCIAS, PROVIDER, WIDGETS, GO ROUTER, FUTURE, DATARESULT WRAPPER ENTRE OTROS...}


### **1. Modulo de autenticación**

Junto al servicio de autenticación de Firebase, se implementó el Login y el Registro en la misma pantalla. Empezamos creando esta clase que representa la estructura principal de la pantalla de autenticación de la aplicación.

```dart
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SignInScreenBody(
          signInProvider: context.watch(),
        ),
      ),
    );
  }
}

```
- Esta clase utiliza un Scaffold como estructura principal de la pantalla.
- Dentro del body del Scaffold, hay un SingleChildScrollView que permite desplazar el contenido si es necesario.
- La pantalla de inicio de sesión y de registro se define en la clase SignInScreenBody, a la cual se le pasa el proveedor de inicio de sesión como argumento.
     


```dart
class SignInScreenBody extends StatelessWidget {
  final SignInProvider signInProvider;
  const SignInScreenBody({super.key, required this.signInProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.height,
      padding: const EdgeInsets.symmetric(horizontal: 40).copyWith(
        top: ScreenSize.height * 0.05,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red.shade400,
              Colors.red.shade500,
              Colors.red.shade700
            ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.bigPokeBall,
            height: 150,
          ),
          const Text(
            'Inicio',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: signInProvider.emailController,
            decoration: InputDecoration(
              hintText: 'Correo',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
          const SizedBox(height: 20),
          //
          TextFormField(
            controller: signInProvider.passwordController,
            decoration: InputDecoration(
              hintText: 'Contraseña',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
            obscureText: true,
          ),
          SizedBox(height: ScreenSize.absoluteHeight * 0.05),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await context.read<SignInProvider>().validateLogIn(context);
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: signInProvider.isLoggingIn ? 13 : 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromARGB(255, 143, 21, 21)),
              child: signInProvider.isLoggingIn
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Ingresar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "¿No existe aún esa cuenta? Registrala",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenSize.width * 0.034,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                )
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await context.read<SignInProvider>().validateSignUp(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    vertical: signInProvider.isCheckingIn ? 12 : 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color.fromARGB(255, 143, 21, 21),
              ),
              child: signInProvider.isCheckingIn
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Registrar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
```
Sé que puede ser confuso pero te voy a detallar brevemente algunos de los **Widgets** más importantes que se usaron aca. Igualmente eres libre de consultar la [documentación de Flutter](https://docs.flutter.dev/).

- Container: Define la estructura y diseño de la pantalla, con un gradiente de colores como fondo.
- Column: Organiza verticalmente los elementos de la pantalla, como la imagen, el texto y los campos de entrada.
- Image.asset: Muestra una imagen local, como un logo o icono.
- Text: Muestra texto con formato, como el título "Inicio" y la pregunta de registro.
- TextFormField: Permite al usuario ingresar datos, como el correo y la contraseña.
- ElevatedButton: Botones para iniciar sesión y registrarse, con indicadores visuales de progreso.
- CircularProgressIndicator: Indica que se está realizando una tarea en segundo plano.
- Row: Organiza horizontalmente el texto y el icono de la pregunta de registro.
- Icon: Muestra un icono gráfico, como una flecha hacia abajo.

No es necesario de que te los aprendas de memoria, con la practica ya irás desarrollando tu capacidad de integrar los diferentes Widgets de **Flutter** para formar una UI atractiva y eficaz. Lo que quiero que entiendas es cómo se interactua la entrada y salida (E/S) de datos en Flutter, dado que es un pilar fundamental en el desarrollo de software.

1. **Se capturan los datos**
- Obtenemos los datos como el **email** y la **contraseña** a tráves de **TextFormField**. Este widget permite al usuario ingresar datos, como el correo y la contraseña. Cuando el usuario escribe en estos campos, la entrada de texto se guarda en los controladores de texto (signInProvider.emailController y signInProvider.passwordController). Estos controladores son proporcionados por el proveedor SignInProvider, que es el que maneja la lógica relacionada con la validación y el almacenamiento de los datos de inicio de sesión.
2. **Se envían los datos al provider**
- A tráves de **ElevatedButton** que permite al usuario interactuar con la aplicación, como iniciar sesión o registrarse. Cuando el usuario presiona uno de estos botones, se activa el evento onPressed, que normalmente ejecuta una función, en este caso, las funciones validateLogIn y validateSignUp del proveedor SignInProvider. Estas funciones manejan la lógica para validar los datos ingresados por el usuario y realizar acciones como iniciar sesión o registrar una nueva cuenta.
3. **Validación y envío**
- Las funciones **validateEmail** y **validatePassword** en el **SignInProvider** se utilizan para validar el formato del correo electrónico y la longitud de la contraseña antes de intentar iniciar sesión o registrar una nueva cuenta. Si alguna de estas validaciones falla, se muestra una notificación al usuario. En caso de ser correcto, sigue el flujo de la app.

**SigInProvider:**
```dart
class SignInProvider with ChangeNotifier {
  final LogInUseCase logInUseCase;
  final SignUpUseCase signUpUseCase;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoggingIn = false;
  bool isCheckingIn = false;

  SignInProvider({required this.logInUseCase, required this.signUpUseCase});

  Future<DataResult<UserCredential>> signIn(
      String email, String password) async {
    return await logInUseCase.call(email, password);
  }

  Future<DataResult<UserCredential>> signUp(
      String email, String password) async {
    return await signUpUseCase.call(email, password);
  }

  bool validateEmail() {
    if (emailController.text.trim().isEmpty ||
        !AppFunctions.emailRegExp.hasMatch(emailController.text.trim())) {
      //NOTIFICAR
      return false;
    }
    return true;
  }

  bool validatePassword() {
    if (passwordController.text.trim().isEmpty ||
        passwordController.text.length < 6) {
      //NOTIFICAR
      return false;
    }
    return true;
  }

  Future<void> validateLogIn(BuildContext context) async {
    if (isLoggingIn) return;
    isLoggingIn = true;
    notifyListeners();

    if (!validateEmail() || !validatePassword()) {
      InAppNotification.invalidEmailAndPassword(context: context);
      return;
    }
    await signIn(emailController.text, passwordController.text).then((result) {
      if (!result.success) {
        //notificar
        isLoggingIn = false;
        notifyListeners();
        InAppNotification.serverFailure(
            context: context, message: result.message);
        return;
      }
      emailController.clear();
      passwordController.clear();
      context.read<GameProvider>().initGame();
      InAppNotification.successfulSignUp(context: context);
      //Navegar a la siguiente ruta
      appRouter.go("/game");
      isLoggingIn = false;
    });
  }

  Future<void> validateSignUp(BuildContext context) async {
    if (isCheckingIn) return;
    isCheckingIn = true;
    notifyListeners();

    if (!validateEmail() || !validatePassword()) {
      InAppNotification.invalidEmailAndPassword(context: context);
      return;
    }
    await signUp(emailController.text.trim(), passwordController.text.trim())
        .then((result) {
      if (!result.success) {
        isCheckingIn = false;
        notifyListeners();
        //notificar
        InAppNotification.serverFailure(
            context: context, message: result.message);
        return;
      }
      emailController.clear();
      passwordController.clear();
      //Navegar a la siguiente ruta
      context.read<GameProvider>().initGame();
      appRouter.go("/game");
      isCheckingIn = false;
    });
  }

  Future<void> checkAuthenticated(BuildContext context) async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    if (FirebaseAuth.instance.currentUser != null) {
      Future.microtask(() {
        context.read<GameProvider>().initGame();
        appRouter.go("/game");
      });
    } else {
      appRouter.go("/signIn");
    }
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
    appRouter.go("/signIn");
  }
}
```
4. **Flujo de la aplicación**
- Antes de entrar en detalle al flujo de datos tanto en la Entrada y Salida que maneja la aplicación, se necesita que no te saltes el apartado de **Arquitectura limpia** e **Inyección de dependencias**
- Luego del provider, los datos pasa por un flujo en base a la **arquitectura limpia** que estamos implementando. Empieza por el **caso de uso** que representan las diferentes funcionalidades de la aplicación.

```dart
class LogInUseCase {
  //Code
  final SignInRepository signInRepository;

  LogInUseCase({required this.signInRepository});

  Future<DataResult<UserCredential>> call(String email, String password) {
    return signInRepository.signIn(email, password);
  }
}
```

```dart
class SignUpUseCase {
  //Code
  final SignInRepository signInRepository;

  SignUpUseCase({required this.signInRepository});

  Future<DataResult<UserCredential>> call(String email, String password) {
    return signInRepository.signUp(email, password);
  }
}
```
- Como ves en los casos de uso se inyecta una clase abstracta **SignInRepository**, que es la que nos define los métodos que la capa de lógica de negocio puede utilizar para acceder y manipular datos. Este sigue un patrón de diseño conocido como [**Repository**](https://codewithandrea.com/articles/flutter-repository-pattern/****), que cuenta con dos partes:

**Interfaz del repository**
La que define los metodos a seguir.

```dart
abstract class SignInRepository {
  Future<DataResult<UserCredential>> signIn(String email, String password);
  Future<DataResult<UserCredential>> signUp(String email, String password);
}
```
**Implementación del repository**
Proporciona la implementación concreta de los métodos definidos en la interfaz de repositorio. 

```dart
class SignInRepositoryImpl extends SignInRepository {

  final SignInDatasource datasource;

  SignInRepositoryImpl({required this.datasource});

  @override
  Future<DataResult<UserCredential>> signIn(String email, String password) {
    return datasource.signIn(email, password);
  }
  
  @override
  Future<DataResult<UserCredential>> signUp(String email, String password) {
    return datasource.signUp(email, password);
  }
}
```
- Como puedes ver la implementación del repository, también inyecta una última clase, que es el **Service**, el encargado de hacer la conexión y transferencia de datos con apps externas, como un backend, bases de datos, apis terceras y otros servicios en la nube como **Firebase** o **Supabase**.

**Service**
```dart
abstract class SignInDatasource {
  //abstract Functions
  Future<DataResult<UserCredential>> signIn(String email, String password);
  Future<DataResult<UserCredential>> signUp(String email, String password);
}

class SignInDatasourceImpl extends SignInDatasource {
  @override
  Future<DataResult<UserCredential>> signIn(
      String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return DataResult(
          success: true,
          message: "Ingresaste a la cuenta correctamente",
          data: credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return DataResult(
            success: false,
            message: "No user found for that email",
            data: null);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return DataResult(
            success: false,
            message: "Wrong password provided for that user.",
            data: null);
      }
      print(e);
      return DataResult(success: false, message: e.message!, data: null);
    }
  }

  @override
  Future<DataResult<UserCredential>> signUp(
      String email, String password) async {
    try {

      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return DataResult(
          success: true,
          message: "Cuenta creada correctamente. Ingresaste a la cuenta correctamente",
          data: credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return DataResult(
            success: false,
            message: "The password provided is too weak.",
            data: null);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return DataResult(
            success: false,
            message: "The account already exists for that email.",
            data: null);
      }
      return DataResult(success: false, message: e.message!, data: null);
    }
  }
}

```

- Si ya seguiste este flujo, podrás ver que los metódos usados en las pantallas, terminan aca, sin antes obviamente devolver el tipo de dato esperado en la UI, para su posterior manipulación. 
