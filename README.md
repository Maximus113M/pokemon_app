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
