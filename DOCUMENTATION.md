# FLUJO DE INFORMACIÓN

Las `vistas`, `pantallas` y los `widgets` interactúan con los `providers`, estos se conectan a los `repositorios` que, a su vez, llaman a los `datasources` para obtener los datos.

---

---

---

# CONCEPTOS IMPORTANTES DE LA ARQUITECTURA

## Entities / Entidades

Objetos que representan datos importantes y que no cambian en diferentes partes de la aplicación.

## Datasources / Orígenes de Datos

Son las fuentes de donde la aplicación obtiene los datos, como bases de datos o APIs. La aplicación no necesita saber de dónde vienen los datos, solo que llegan.

- **Abstractos**: Definen las reglas generales que todas las implementaciones deben seguir.
- **Implementaciones**: Aquí es donde se escribe el código específico para obtener los datos, como hacer una llamada a una API.

## Repositories / Repositorios

Se encargan de llamar a los datasources para obtener los datos. Son flexibles para que si necesitamos cambiar algo, no afecte a toda la aplicación.

- **Abstractos**: Son como planos que definen cómo deben funcionar los repositorios.
- **Implementaciones**: Son las versiones específicas que siguen esos planos para trabajar con los datos.

## Provider / Gestor de Estado

Actúa como intermediario entre la interfaz de usuario y los repositorios. También maneja cómo se ven los cambios en la pantalla.

---

---

---

# INFORMACIÓN DE LOS DIRECTORIOS Y CLASES

## CONFIG: Configuración general de la aplicación

- **constants**: Contiene las variables de entorno, como configuraciones importantes que pueden cambiar según el ambiente (producción, desarrollo).
  - `environment.dart`: Aquí están las variables de entorno del archivo `.env`.
- **helpers**: Incluye funciones de ayuda, como convertir números o fechas.
  - `formats.dart`: Tiene funciones para convertir números decimales usando una librería específica.
- **router**: Maneja cómo la aplicación navega entre diferentes pantallas.
  - `app_router.dart`: Aquí se definen las rutas (o caminos) para navegar dentro de la aplicación.
- **theme**: Define el aspecto visual de la aplicación.
  - `app_theme.dart`: Contiene los colores, fuentes, y estilos de la aplicación.
- `config.dart`: Archivo de barril que contiene todas las exportaciones de este directorio.

## DOMAIN: Define las reglas y estructura de los datos

- **datasources**: Establece las reglas para las fuentes de datos. Aquí los datasources no obtienen la información, solo definen las reglas.
  - `actors_datasource.dart`: Reglas para la implementación del datasource de actores.
  - `isar_datasource.dart`: Reglas para la implementación del datasource de Isar Database.
  - `movies_datasource.dart`: Reglas para la implementación del datasource de películas.
- **entities**: Define las clases que representan los datos principales, como actores o películas.
  - `actor.dart`: Estructura para manejar la información de los actores.
  - `movie.dart`: Estructura para manejar la información de las películas.
  - `movie.g.dart`: Archivo generado automáticamente, para más información leer `README.md`.
  - `video.dart`: Estructura para manejar la información de los videos.
- **repositories**: Establece las reglas para los repositorios. Aquí los repositorios no se conectan con los datasources, solo definen las reglas.
  - `actors_repository.dart`: Reglas para la implementación del repositorio de actores.
  - `isar_repository.dart`: Reglas para la implementación del repositorio de Isar Database.
  - `movies_repository.dart`: Reglas para la implementación del repositorio de películas.
- `domain.dart`: Archivo de barril que contiene todas las exportaciones de este directorio.

## INFRASTRUCTURE: Implementación de las funciones para obtener los datos

- **datasources**: Aquí está ubicado el código que conecta con las APIs o las bases de datos.
  - `actor_datasource_impl.dart`: Código que obtiene los actores desde una API con peticiones HTTP.
  - `isar_datasource_impl.dart`: Código que maneja los datos de Isar Database, una base de datos local.
  - `movie_datasource_impl.dart`: Código que obtiene las películas desde una API con peticiones HTTP.
- **mappers**: Transforman los datos obtenidos de las APIs en el formato que necesita la aplicación.
  - `actor_mapper.dart`: Convierte datos de actores de la API al formato usado por la aplicación.
  - `movie_mapper.dart`: Convierte datos de películas de la API al formato usado por la aplicación.
  - `video_mapper.dart`: Convierte datos de videos de la API al formato usado por la aplicación.
- **models**: Representan cómo se ven los datos que vienen de las APIs, facilitando su uso en la aplicación.
  - **tmdb**: Modelos específicos de la API de TheMovieDB (TMDB).
    - `credits_response.dart`: Representación de los créditos de una película individual obtenida de la API de TMDB.
    - `details_response.dart`: Representación detallada de una película individual obtenida de la API de TMDB.
    - `movie_response.dart`: Representación de una película individual obtenida de la API de TMDB.
    - `movies_response.dart`: Representación de una lista de películas obtenidas de la API de TMDB.
    - `videos_response.dart`: Representación de los videos asociados a una película obtenidos de la API de TMDB.
- **repositories**: Estas clases son las que se implementan directamente en la capa de presentación para obtener y manejar los datos.
  - `actor_repository_impl.dart`: Repositorio que se conecta a los datasource de los actores.
  - `isar_repository_impl.dart`: Repositorio que se conecta a los datasource de Isar Database.
  - `movie_repository_impl.dart`: Repositorio que se conecta a los datasource de las películas.
- `infrastructure.dart`: Archivo de barril que contiene todas las exportaciones de este directorio.

## PRESENTATION: Parte visual y su conexión con los datos

- **delegates**: Maneja la búsqueda dentro de la aplicación.
  - `search_movies_delegate.dart`: Código para buscar películas.
- **providers**: Enlace entre la infraestructura y la presentación.
  - **actors**: Gestión de la información de los actores.
    - `actors_provider.dart`: Obtiene y maneja la lista de actores por película.
    - `actors_repository_provider.dart`: Conecta con el repositorio de actores usando Riverpod.
  - **isar**: Gestión de la información de Isar Database.
    - `isar_favorite_movies_provider.dart`: Maneja la carga de páginas de películas favoritas y su inserción y eliminación de favoritos.
    - `isar_repository_provider.dart`: Conecta con el repositorio de Isar Database usando Riverpod.
  - **loaders**: Maneja los estados de carga, si ya están cargados los datos o no.
    - `screen_loader_provider.dart`: Verifica si las listas y diapositivas de películas están cargadas.
  - **movies**: Gestión de la información de las películas.
    - `movies_details_provider.dart`: Maneja los detalles de una película específica.
    - `movies_provider.dart`: Maneja y actualiza las listas de películas.
    - `movies_repository_provider.dart`: Conecta con el repositorio de películas usando Riverpod.
    - `movies_slideshow_provider.dart`: Maneja el pase de diapositivas con las películas en cartelera.
  - **search**: Gestión de la funcionalidad de búsqueda de películas con la interfaz.
    - `search_movies_provider.dart`: Maneja la búsqueda de películas, almacenando la consulta y los resultados.
- **screens**: Pantallas de la aplicación.
  - **movies**: Pantallas relacionadas con las películas.
    - `home_screen.dart`: Pantalla principal que muestra las vistas.
    - `movie_screen.dart`: Pantalla que muestra los detalles de una película específica.
- **views**: Vistas específicas de las pantallas.
  - **movies**: Vistas relacionadas con las películas.
    - `favorites_view.dart`: Vista de las películas favoritas.
    - `home_view.dart`: Vista de la pantalla de inicio.
    - `popular_view.dart`: Vista de las películas populares.
- **widgets**: Componentes visuales reutilizables.
  - **actors**: Widgets específicos para los actores.
    - `actors_by_movie.dart`: Widget para mostrar la lista de actores de una película individual.
  - **movies**: Widgets específicos para las pantallas de películas.
    - `movie_masonry.dart`: Widget para mostrar la estructura de las películas en las vistas favoritas y populares.
    - `movie_poster_link.dart`: Widget utilizado por MovieMasonry para redirigir a la pantalla individual de la película.
    - `movie_rating.dart`: Widget para mostrar las valoraciones de una película individual.
    - `movie_video.dart`: Widget para mostrar el video de una película individual.
    - `movies_listview.dart`: Widget para mostrar las listas de películas.
    - `movies_similar.dart`: Widget para mostrar las películas similares a una película individual.
    - `movies_slideshow.dart`: Widget para mostrar un pase de diapositivas de las películas.
  - **shared**: Widgets que se usan en toda la aplicación.
    - `custom_appbar.dart`: Barra superior personalizada de la aplicación.
    - `custom_navigationbar.dart`: Barra de navegación personalizada de la aplicación.
    - `custom_screen_loader.dart`: Indicador inicial de carga a pantalla completa.
- `presentation.dart`: Archivo de barril que contiene todas las exportaciones de este directorio.
