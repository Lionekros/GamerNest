# Gamer Nest

## Índice
1. [Introducción](#introducción)
2. [Objetivo](#objetivo)
3. [Instalación](#instalación)
   1. [Instalación de XAMPP](#instalación-de-xampp)
   2. [Configuración de la Base de Datos](#configuración-de-la-base-de-datos)
   3. [Instalación de Visual Studio Community 2022](#instalación-de-visual-studio-community-2022)
4. [Ejecución](#ejecución)

---

## Introducción

Gamer Nest es un proyecto que permite a los jugadores conectarse e interactuar entre sí. Este README proporciona instrucciones sobre cómo configurar el entorno de desarrollo para este proyecto.

---

## Objetivo

El objetivo principal de la página es la creación de un sitio web especializado en mostrar noticias sobre el mundo de los videojuegos.

### General

Los usuarios podrán acceder a noticias sobre videojuegos y tendrán la opción de añadir esos videojuegos a favoritos. Esto les permitirá filtrar las noticias y mostrar solo aquellas relacionadas con los juegos que tienen en su lista de favoritos.

La aplicación también contará con un panel de administración que permitirá el control total de los datos de la página, incluyendo operaciones de CRUD (Crear, ver, actualizar y eliminar) sobre la mayoría de los datos del sitio.

Además, habrá un tipo de usuario llamado Autor, que tendrá su propio panel de administración. A diferencia del administrador, el autor solo tendrá acceso a los datos necesarios para su trabajo y creaciones.

### Control de Autores

Los administradores tendrán la capacidad de otorgar permisos de publicación a los autores. Esto les permitirá publicar sus reportajes directamente sin necesidad de intervención de un administrador. Los autores sin este privilegio deberán esperar a que un administrador publique su reportaje.

### Idiomas

La aplicación tendrá como idioma principal el inglés para llegar al mayor público posible. No obstante, se permitirá la adición de más idiomas a la aplicación.

---

## Instalación

Antes de comenzar, asegúrate de tener instalado el siguiente software en tu sistema:

- [XAMPP](https://www.apachefriends.org/es/index.html)
- [Visual Studio Community 2022](https://visualstudio.microsoft.com/es/vs/community/)

### Instalación de XAMPP

1. Descarga la última versión de XAMPP desde el [sitio web oficial](https://www.apachefriends.org/es/index.html).
2. Ejecuta el archivo de instalación de XAMPP y sigue las instrucciones del asistente de instalación.
3. Durante la instalación, elige los componentes que deseas instalar. Asegúrate de seleccionar Apache, MySQL y PHP.
4. Una vez finalizada la instalación, inicia el Panel de Control de XAMPP y activa Apache y MySQL.

### Configuración de la Base de Datos

1. Abre un navegador web e ingresa en http://localhost/phpmyadmin.
2. Esto te llevará a la interfaz de PHPMyAdmin. Ingresa el usuario y contraseña (Normalmente, root y sin contraseña).
3. Haz clic en "Nuevo", a la izquierda de la página.
4. En el campo "Crear base de datos", ingresa el nombre "gamer_nest" y haz clic en el botón "Crear".
5. Ahora, en la barra de navegación lateral izquierda, selecciona la base de datos "gamer_nest" que acabas de crear.
   Nota: Esta guía asume que estás utilizando Windows 10 o una versión superior.
6. Dentro de la base de datos, busca la opción "Importar" en la parte superior de la página.
7. Haz clic en el botón "Examinar" y selecciona el archivo de script de la carpeta DB del proyecto.

### Instalación de Visual Studio Community 2022

1. Accede al [sitio web oficial de Visual Studio Community 2022](https://visualstudio.microsoft.com/es/vs/community/) y descarga el instalador.
2. Ejecuta el archivo de instalación y sigue las instrucciones del asistente.
3. Durante la instalación, asegúrate de seleccionar las opciones y componentes necesarios para el desarrollo web, como ASP.NET, herramientas web y cualquier otro componente que desees utilizar.
4. Una vez finalizada la instalación, inicia Visual Studio Community 2022.

---

## Ejecución

Para ejecutar el proyecto, deberás abrir la solución (`GamerNest.sl`) que se encuentra en la raíz de la carpeta GamerNest.
Una vez abierto, arriba del todo veremos el símbolo de play.
Clica en el desplegable y, dónde pone Web Browser, selecciona tu navegador (Se recomienda el uso de Google Chrome).
Una vez hecho esto, pulsa al play y el proyecto arrancará.
