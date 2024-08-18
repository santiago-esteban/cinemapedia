# FLUJO DE INFORMACIÓN

Las `vistas`, `pantallas` y los `widgets` interactúan con los `providers`, estos se conectan a los `repositorios` que, a su vez, llaman a los `datasources` para obtener los datos.

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

- **datasources**: Establece las reglas para las fuentes de datos. Aquí no se obtiene directamente la información, solo se definen las reglas.
  - `actors_datasource.dart`: Reglas para obtener datos de actores.
  - `movies_datasource.dart`: Reglas para obtener datos de películas.
- **entities**: Define las clases que representan los datos principales, como actores o películas.
  - `actor.dart`: Estructura para manejar la información de los actores.
  - `movie.dart`: Estructura para manejar la información de las películas.
- **repositories**: Conecta los repositorios con las fuentes de datos.
  - `actors_repository.dart`: Usa el datasource de actores para obtener la información.
  - `movies_repository.dart`: Usa el datasource de películas para obtener la información.

## INFRASTRUCTURE: Implementación de las funciones para obtener los datos

- **datasources**: Aquí es donde se escribe el código para conectar con APIs o bases de datos.
  - `actor_datasource_impl.dart`: Código que obtiene los actores desde una API.
  - `movie_datasource_impl.dart`: Código que obtiene las películas en cartelera desde una API.
- **mappers**: Transforman los datos obtenidos de las APIs en el formato que necesita la aplicación.
  - `actor_mapper.dart`: Convierte datos de actores de la API al formato usado por la aplicación.
  - `movie_mapper.dart`: Convierte datos de películas de la API al formato usado por la aplicación.
- **models**: Representan cómo se ven los datos que vienen de las APIs, facilitando su uso en la aplicación.
  - **moviedb**: Modelos específicos de la API de TheMovieDB (TMDB).
    - `credits_response.dart`: Estructura para manejar los créditos de una película (actores y equipo técnico).
    - `movie_details.dart`: Representación detallada de una película.
    - `movie_moviedb.dart`: Representación de una película obtenida de la API de TMDB.
    - `moviedb_response.dart`: Estructura para manejar la respuesta de la API cuando se obtienen películas.

## PRESENTATION: Parte visual y su conexión con los datos

- **delegates**: Maneja la búsqueda dentro de la aplicación.

  - `search_movies_delegate.dart`: Código para buscar películas.

- **providers**: Enlace entre la infraestructura (donde se obtienen los datos) y la presentación (lo que ve el usuario).

  - **actors**: Gestión de la información de los actores.
    - `actors_provider.dart`: Obtiene y maneja la lista de actores por película.
    - `actors_repository_provider.dart`: Conecta con el repositorio de actores usando Riverpod.
  - **loaders**: Maneja los estados de carga (si se están cargando los datos o no).
    - `screen_loader_provider.dart`: Verifica si las listas de películas están cargadas.
  - **movies**: Gestión de la información de las películas.
    - `movies_details_provider.dart`: Maneja los detalles de una película específica.
    - `movies_provider.dart`: Maneja y actualiza la lista de películas en cartelera.
    - `movies_repository_provider.dart`: Conecta con el repositorio de películas usando Riverpod.
    - `movies_slideshow_provider.dart`: Maneja el pase de diapositivas con las películas en cartelera.
  - **search**: Conecta la funcionalidad de búsqueda con la interfaz.
    - `search_movies_provider.dart`: Maneja la búsqueda de películas, almacenando la consulta y los resultados.

- **screens**: Pantallas de la aplicación.

  - **movies**: Pantallas relacionadas con las películas.
    - `home_screen.dart`: Pantalla principal que muestra las películas.
    - `movie_screen.dart`: Pantalla que muestra los detalles de una película específica.

- **views**: Vistas específicas de las pantallas.
  - **movies**: Vistas relacionadas con las películas.
    - `categories_view.dart`: Vista de las categorías de películas.
    - `favorites_view.dart`: Vista de las películas favoritas.
    - `home_view.dart`: Vista de la pantalla de inicio.
- **widgets**: Componentes visuales reutilizables.
  - **movies**: Widgets específicos para las pantallas de películas.
    - `movies_listview.dart`: Widget para mostrar la lista de películas en cartelera.
    - `movies_slideshow.dart`: Widget para mostrar un pase de diapositivas de las películas.
  - **shared**: Widgets que se usan en toda la aplicación.
    - `custom_appbar.dart`: Barra superior personalizada de la aplicación.
    - `custom_navigation_bar.dart`: Barra de navegación personalizada.
    - `full_screen_loader.dart`: Indicador de carga a pantalla completa.
