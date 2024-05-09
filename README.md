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

Antes de empezar a codear, te quiero dar algunos conceptos que aplicamos en este proyecto:
1. **ARQUITECTURA LIMPIA: Fundamentos y Aplicaciones**

   La arquitectura limpia, es un enfoque metodológico que se basa en una serie de principios y prácticas destinadas a minimizar la complejidad, maximizar la modularidad y facilitar la comprensión del código.

   Uno de los principios fundamentales de la arquitectura limpia es la separación de responsabilidades. Esto implica dividir el sistema en componentes independientes, cada uno responsable de una tarea específica. Al mantener las responsabilidades claramente definidas, se facilita la modificación y el mantenimiento del sistema sin afectar otras partes.
      
   Otro aspecto importante es la jerarquía de abstracciones. Este principio sugiere organizar el sistema en capas (Domain, Data, Display/UI), donde cada capa ofrece un nivel de abstracción superior al anterior. Esto permite construir sistemas flexibles, donde los detalles de implementación están encapsulados en capas inferiores y las decisiones de alto nivel se toman en capas superiores. Esto hace que el código sea más adaptable a los cambios tecnológicos y más fácil de probar siendo ideal para el testing.
      
   En resumen, la arquitectura limpia es un enfoque metodológico que busca crear sistemas de software robustos, mantenibles y escalables mediante la aplicación de principios como la separación de responsabilidades, la jerarquía de abstracciones, la independencia de frameworks y herramientas, y la testabilidad. Se busca construir sistemas que sean más fáciles de entender, modificar y mantener a lo largo del tiempo ( mas información [aquí](https://nescalro.medium.com/entendiendo-a-la-arquitectura-limpia-7877ad3a0a47) ).

2. **INYECCIÓN DE DEPENDENCIAS: Facilitando la Modularidad**

   La inyección de dependencias (DI, por sus siglas en inglés) es un patrón de diseño fundamental en la implementación de la arquitectura limpia. Este enfoque promueve la separación de las dependencias de un componente, permitiendo una mayor modularidad y testabilidad en el código.

   Se utiliza para desacoplar los componentes del sistema, facilitando su intercambio y reutilización. En lugar de que un componente instancie directamente sus dependencias, estas se proporcionan desde el exterior, lo que permite cambiar las implementaciones de las dependencias sin modificar el componente principal.

   Promueve la inversión del control (IoC), otro principio importante en la arquitectura limpia. En lugar de que un componente controle la creación y gestión de sus dependencias, estas se pasan como parámetros o se proporcionan a través de constructores, métodos de configuración o contenedores de inyección de dependencias ( más información [aquí](https://www.campusmvp.es/recursos/post/que-es-la-inyeccion-de-dependencias-y-como-funciona.aspx) ).

3. **PROVIDER: Gestor de Estado**
   
   Los gestores de estado en Flutter son herramientas que permiten manejar de manera eficiente y efectiva la información y la lógica de la aplicación, asegurando un rendimiento óptimo y una experiencia de usuario fluida.

   Uno de los gestores de estado más utilizados en Flutter es Provider. Este gestor de estado es simple pero poderoso, permitiendo la propagación eficiente de datos a través de la jerarquía de widgets sin necesidad de reconstruir la interfaz de usuario completa. Utilizando el patrón de InheritedWidget de Flutter, Provider ofrece un enfoque sencillo para compartir datos entre widgets y gestionar su estado de manera efectiva.

   Podemos destacar:
   - Gestión del Estado: Permite gestionar eficientemente el estado de la aplicación, incluyendo la información y la lógica de la misma. Esto asegura que la aplicación mantenga un estado coherente y             actualizado en todo momento.
   - Comunicación entre Widgets: Facilitan la comunicación entre diferentes widgets de la aplicación, permitiendo pasar datos de manera eficiente a través de la jerarquía de widgets sin necesidad de             reconstruir la interfaz de usuario completa.
   - Modularidad y Mantenibilidad: Promueven la modularidad y la mantenibilidad del código al separar la lógica de negocio de la interfaz de usuario. Esto hace que el código sea más fácil de entender,          mantener y modificar a medida que evoluciona la aplicación.
   - Rendimiento Optimizado: Ayudan a optimizar el rendimiento de la aplicación al reducir la necesidad de reconstruir widgets innecesariamente. Esto se logra mediante la actualización selectiva de widgets     solo cuando sea necesario, en lugar de reconstruir toda la interfaz de usuario.
   - Previsibilidad y Depuración: Ofrecen un enfoque predecible y consistente para gestionar el estado de la aplicación, lo que facilita la depuración y el mantenimiento del código. Esto es especialmente       útil en aplicaciones grandes y complejas donde el control del estado es crucial.
   - Separación de Responsabilidades: Ayudan a separar las responsabilidades dentro de la aplicación, permitiendo que cada componente se enfoque en una tarea específica. Esto mejora la claridad y la            organización del código, facilitando su comprensión y mantenimiento a largo plazo. ( más información [aquí](https://docs.flutter.dev/ui/widgets) ).

4. **WIDGETS EN FLUTTER: Bloques de Construcción de Interfaces de Usuario Interactivas**

   En el desarrollo de aplicaciones móviles con Flutter, los widgets son los bloques de construcción fundamentales que componen la interfaz de usuario y definen su apariencia y comportamiento. Desde botones y campos de texto hasta diseños completos, cada elemento visual en una aplicación Flutter es un widget.

   Podemos destacar:
   - Elementos Visuales y de Interfaz de Usuario: Los widgets en Flutter representan tanto elementos visuales como funcionales de la interfaz de usuario. Pueden ser simples, como un texto estático              (Text('Hola')) o un icono (Icon(Icons.add)), o complejos, como un formulario de entrada de datos(TextFormField(...)) o una lista desplazable(ListView(...)).
   - Composición Jerárquica: Los widgets se organizan en una estructura jerárquica, donde los widgets más simples se combinan para formar widgets más complejos. Esta composición jerárquica permite construir    interfaces de usuario complejas y dinámicas a partir de elementos más simples y reutilizables.
   - Inmutabilidad y Estado: En Flutter, los widgets son inmutables, lo que significa que una vez creados, no pueden cambiar. Sin embargo, los widgets pueden tener estado interno, que puede cambiar durante     el ciclo de vida de la aplicación. Esto permite crear interfaces de usuario interactivas y dinámicas que responden a la entrada del usuario y a eventos externos.
   - Widgets Nativos y Personalizados: Flutter proporciona una amplia variedad de widgets predefinidos que cubren una amplia gama de casos de uso comunes. Además, los desarrolladores también pueden crear       sus propios widgets personalizados para adaptarse a las necesidades específicas de su aplicación ( más información [aquí](https://docs.flutter.dev/ui/widgets) ).

5. **FUTURES Y PROGRAMACIÓN ASÍNCRONA: Gestión Asíncrona de Operaciones Futuras**
   
   Los Futures en Dart son una herramienta fundamental para gestionar operaciones asíncronas y valores que pueden estar disponibles en el futuro. Estos objetos representan el resultado de una operación asíncrona que aún no ha finalizado, permitiendo que el programa continúe ejecutándose mientras espera la finalización de la operación.

   - Operaciones Asíncronas: Los Futures permiten realizar operaciones que pueden llevar tiempo y se resolveran en un "Futuro", como la carga de datos desde la red o la lectura/escritura de archivos, sin bloquear el hilo principal de ejecución del programa. Posee un método de espera llamado "await" que le indica al código, dentro de una función, esperar a que un Future sea resuelto. 
   - Gestión de Resultados: Los Futures representan el resultado de una operación asíncrona, que puede ser un valor concreto o un error. Esto permite a los desarrolladores manejar de manera efectiva los resultados de las operaciones asíncronas y tomar acciones apropiadas en función de los resultados obtenidos.
   - Encadenamiento de Futures: Los Futures en Dart admiten el encadenamiento, lo que permite combinar múltiples operaciones asíncronas de manera efectiva. Esto es útil para casos de uso como la secuencialización de operaciones asíncronas o la ejecución de operaciones en paralelo y la combinación de sus resultados.
   - Gestión de Errores: Los Futures proporcionan una forma de manejar errores y excepciones que pueden ocurrir durante la ejecución de una operación asíncrona. Esto garantiza que las aplicaciones puedan manejar de manera efectiva situaciones como la pérdida de conexión de red o la falla en la lectura/escritura de archivos.
   - Notificación de Finalización: Los Futures permiten que los clientes se registren para ser notificados cuando la operación asíncrona se complete, ya sea con éxito o con error. Esto facilita la implementación de lógica de control que responda al resultado de la operación asíncrona de manera apropiada ( más información [aquí](https://dart.dev/codelabs/async-await) ).

8. **WRAPPER: Técnica para para encapsular datos para trabajarlos de una manera mas conveniente**

   En el proyecto de Flutter, usamos un **wrapper** personalizado llamado **DataResult**, con el fin de encapsular las peticiones que venian desde fuentes externas como Firebase o la API de pókemon. ¿Y esto para qué?. Bueno, principalmente para manejar cualquier tipo de información que venga de estas fuentes externas, ya sea sobre el éxito de la operación, cualquier mensaje relacionado y los datos devueltos por la petición. Es una forma de estructurar y manejar los resultados de manera uniforme en una aplicación.
   
   ```dart
   class DataResult<T> {
     final bool success;
     final String message;
     final T ? data;
   
     DataResult({
       required this.success,
       required this.message,
       required this.data,
     });
   }
   ```
   Como puedes ver, nos devuelve un Booleano relacionado a la operación si fue exitosa, un mensaje para los detalles de la operación, y un **data** de tipo **[Generico (T)](https://caneallestacursos.com/home/genericos-en-dart/)**, que en caso de ser exitosa la operación nos devuelve el dato que necesitamos.

8. **NAVEGACIÓN ENTRE PANTALLAS: Go Router**
 
   La navegación en Flutter se refiere al proceso de moverse entre diferentes pantallas o vistas dentro de una aplicación. Permite a los usuarios interactuar con la aplicación de manera intuitiva, navegando hacia adelante y hacia atrás entre diferentes pantallas mediante gestos de deslizamiento o mediante la selección de elementos de la interfaz de usuario, como botones o elementos de lista.
   
   El enrutamiento en Flutter se basa en el concepto de rutas, donde cada pantalla o vista en la aplicación está asociada con una ruta única. Los desarrolladores pueden definir y gestionar estas rutas utilizando diversas técnicas, como el enrutador de Flutter incorporado, la navegación basada en widgets, o paquetes de enrutamiento de terceros como "Go Router".
   
   Go router es un paquete de navegación y enrutamiento para Flutter que utiliza la API Router para navegar entre diferentes pantallas. Se puede definir patrones de URL, navegar con URLs, con deep links, entre otras características, daremos ejemplos practicos mas adelante pero puedes obtener más información [aquí](https://medium.com/@jaimetellezb/flutter-go-router-83f6542f7f12) sobre Go Router y ver el paque en [Pub Dev](https://pub.dev/packages/go_router).

9. **PAQUETES Y DEPENDENCIAS:**
 
   Un paquete puede contener cualquier cosa, desde widgets personalizados hasta utilidades de manejo de estado, servicios de red, temas de diseño, entre otros. Los paquetes están diseñados para facilitar la reutilización de código y promover mejores prácticas de desarrollo, permitiendo a los desarrolladores aprovechar el trabajo de otros y acelerar el proceso de desarrollo de sus propias aplicaciones.
    
   Se pueden agregar paquetes a sus proyectos de Flutter especificando las dependencias correspondientes en el archivo pubspec.yaml de nuestra aplicación. Tambien pueden ser agregados por comandos en la terminal del editor de codigo.

   **En nuestro caso asi lucirian las dependencias/paquetes de nuestro proyecto:**
```dart
dependencies:
  flutter:
    sdk: flutter
  #ofrece un widget de notificacion pre-establecido aunque adaptable
  another_flushbar: ^1.12.30

  #paquetes de firebase
  firebase_auth: ^4.19.4
  firebase_core: ^2.30.1

  #permite leer archivos svg no soportados nativamente
  flutter_svg_provider: ^1.0.7

  #permite gestionar la injeccion de dependencias  
  get_it: ^7.7.0

  #paquete de navegacion  
  go_router: ^14.0.2

  #permite gestionar las peteciones http  
  http: ^1.2.1

  #gestiona el renderizado de archivos lottie.json  
  lottie: ^3.1.0
  
  #gestor de estado  
  provider: ^6.1.2
```
### **1. Archivo Main**
Este es el archivo es la entrada y desde donde se ejecuta la app.

```dart
void main() async { //lo convertimos en asincrono (async)
  WidgetsFlutterBinding.ensureInitialized();
  //future que inicializa la configuracion de firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //se inicializa el contenedor de dependencias
  DependencyInjection.configure();

  //metodo que ejecuta la app
  runApp(
    //instancia de Provider siendo padre de la app para poder accederse por todo el contexto a las instacias
    MultiProvider(
      //creacion de los providers que van a usarse
      providers: [
        ChangeNotifierProvider(
          create: (_) => SignInProvider(
            logInUseCase: DependencyInjection.getIt.get<
                LogInUseCase>(), //se utiliza la DI para acceder a las instancias de los casos de uso
            signUpUseCase: DependencyInjection.getIt.get<SignUpUseCase>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DependencyInjection.getIt.get<
              GameProvider>(), //se puede crear la instancia del provider en el mismo contendor de DI
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      //MaterialApp.router permite colocar la configuracion de goRouter
      child: MaterialApp.router(
        //configuracion de goRouter
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
```
### **2. Modulo de autenticación**

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

### **3. Modulo del Juego**

Empezamos creando esta clase que representa la estructura principal de la pantalla de juego de la aplicación.
  
```dart
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          //boton de log out
          IconButton(
              onPressed: () {
                if (context.read<GameProvider>().isLoading) return;
                context.read<SignInProvider>().logOut();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.red.shade700,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        centerTitle: true,
        //propiedad que permite un widget en el appbar, Image.asset() renderiza la imagen desde los assets
        title: Image.asset(
          AppAssets.pokemonLogo,
          height: 50,
        ),
      ),
      body: GameScreenBody(
        gameProvider: context.watch(),
      ),
    );
  }
}
```
   - Esta clase utiliza un Scaffold como estructura principal de la pantalla.
   - La barra superior se crea con el AppBar() que es un widget que tiene atributos como el title, actions, backgroundColor, shape entre otros para personalizarlo.
   - El contenido de la pantalla se define en la clase GameScreenBody, a la cual se le pasa el proveedor del juego como argumento.

```dart
class GameScreenBody extends StatelessWidget {
  //propiedad requerida
  final GameProvider gameProvider;
  const GameScreenBody({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    //stack permite la superposicion de componentes
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: ScreenSize.width,
          height: ScreenSize.height,
          child: Column(
            children: [
              //widget que permite agregar espacio a un widget en sus ejes X y Y
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  '¿Quién es ese Pokémon?\n${gameProvider.roundCounter}/10',//interpolacion de string
                  style: TextStyle(
                      fontSize: ScreenSize.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow.shade700),
                  textAlign: TextAlign.center,
                ),
              ),
            //funcion que retorna el widget que contiene la seccion de la imagen
              pokemonImage(gameProvider),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenSize.absoluteHeight * 0.035,
                  ),
                  child: Text(
                  //evaluacion logica segun para eligir el texto segun la respuesta dada
                    gameProvider.isShowingPokemon
                        ? gameProvider.isCorrectAnswer
                            ? 'Respuesta correcta!'     
                            : 'Upsss... El Pokémon era ${gameProvider.hidenPokemon?.name}' //interpolacion de string
                        : '',
                    style: TextStyle(
                      fontSize: ScreenSize.width * 0.042,
                      color: gameProvider.isCorrectAnswer
                          ? Colors.green.shade600
                          : Colors.red.shade600,
                    ),
                  ),
                ),
              ),
              //widget que contiene la seccion de la opciones
              PokemonOptions(
                gameProvider: gameProvider,
              ),
              //puede utilizarse widgets para dar espacio entre widgets
              SizedBox(
                height: ScreenSize.absoluteHeight * 0.035,
              ),
              TextButton(
                //propiedades del boton
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.red.shade600,
                  ),
                  foregroundColor: const MaterialStatePropertyAll(
                    Colors.white,
                  ),
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(
                      vertical: ScreenSize.width * 0.035,
                      horizontal: gameProvider.roundCounter == 10 &&
                              gameProvider.isShowingPokemon
                          ? ScreenSize.width * 0.20
                          : ScreenSize.width * 0.23,
                    ),
                  ),
                ),
                onPressed: () {
                  //si cumple la condicion, carga la siguiente ronda
                  if (gameProvider.roundCounter == 10 &&
                      !gameProvider.isNewGame) return;
                  gameProvider.loadNextRound();
                },
                child: Text(
                  //evaluacion logica segun para eligir el texto segun la ronda actual
                  gameProvider.roundCounter == 10 &&
                          gameProvider.isShowingPokemon
                      ? 'NUEVO JUEGO'
                      : 'CONTINUAR',
                  style: TextStyle(
                    fontSize: ScreenSize.width * 0.04,
                  ),
                ),
              )
            ],
          ),
        ),
        //animacion de carga
        if (gameProvider.isLoading)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Transform.scale(
              scale: 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppAssets.loadingLottie,
                  Text(
                    'Cargando...',
                    style: TextStyle(fontSize: ScreenSize.width * 0.055),
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }
}
```
Como hace un rato, explicaremos los componentes principales de esta clase, puedes consultarlos tambien el enlace de la documentacion de Flutter.

   - Esta clase retorna un Stack que permite superponer componentes; en este caso se superpone la animación de carga si se cumple la condición. El widget de base después del Stack es un Column que organiza los widgets en columna, en este caso el título, imagen, opciones y botón de acción.
   - Los componentes que corresponden a la imagen y las opciones se crearon como un método y una clase aparte para desestructurar el componente, evitando su crecimiento excesivo, manteniendo la legibilidad y orden.

```dart
SizedBox pokemonImage(GameProvider gameProvider) {
  return SizedBox(
    height: ScreenSize.absoluteHeight * 0.35,
    width: ScreenSize.width,
    child: Stack(
      alignment: Alignment.center,
      children: [
        //fondo circular azul del componente
        CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          radius: ScreenSize.absoluteHeight * 0.15,
        ),
        //permited modificar el color e iluminacion de una imagen
        ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.black,
              //segun la evalucion logica la imagen toma sus colores u oscurese
              gameProvider.isShowingPokemon ? BlendMode.dst : BlendMode.srcIn),
          child: Image(
            height: ScreenSize.absoluteHeight * 0.25,
            //el paquete Svg renderiza la imagen que se obtiene desde la url
            image: Svg(
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/${gameProvider.imageId}.svg',//se envia el id del pokemon
              source: SvgSource.network,
            ),
          ),
        ),
        //posiciona el elemento en un lugar especifico del Stack
        Positioned(
          right: ScreenSize.width * 0.15,
          bottom: 0,
          child: Image.asset(
            AppAssets.pokemonTitle,
            height: ScreenSize.absoluteHeight * 0.15,
          ),
        ),
      ],
    ),
  );
}
```
 - Esta función retorna un Stack que permite superponer las imágenes.


```dart
class PokemonOptions extends StatelessWidget {
  //parametro requerido
  final GameProvider gameProvider;
  const PokemonOptions({super.key, required this.gameProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.15),
      child: Column(
        //metodo que genenera una lista(iteracion) pueden ser widgets
        children: List.generate(
          gameProvider.pokemons.length,
          (index) => responseOption(context, gameProvider.pokemons[index]),
        ),
      ),
    );
  }

  //metodo que devuelve el widget que construye cada opcion, pide context y el pokemon por parametro
  Widget responseOption(BuildContext context, PokemonModel pokemon) {
    //widget que permite que otro widget adquiera algun comportamiento segun los gestos...
    return GestureDetector(
      onTap: () {
        //llamado al GameProvider par verificar la opcion selecionada
        context.read<GameProvider>().checkAnswer(context, pokemon);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: ScreenSize.absoluteHeight * 0.01),
        padding: EdgeInsets.symmetric(
            horizontal: ScreenSize.width * 0.005,
            vertical: ScreenSize.absoluteHeight * 0.002),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: gameProvider.selectedPokemon?.id == pokemon.id
                ? Colors.amber
                : Colors.grey.shade300,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          color: gameProvider.isShowingPokemon
              ? gameProvider.hidenPokemon?.id == pokemon.id
                  ? Colors.green.shade50
                  : Colors.red.shade50
              : Colors.white24,
        ),
        //contruye widgets en horizontal
        child: Row(
          children: [
            Icon(
              Icons.arrow_circle_right,
              color: Colors.yellow.shade700,
              size: ScreenSize.absoluteHeight * 0.04,
            ),
            SizedBox(
              width: ScreenSize.width * 0.5,
              child: Text(
                pokemon.name,
                style: TextStyle(
                  fontSize: ScreenSize.width * 0.04,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```
