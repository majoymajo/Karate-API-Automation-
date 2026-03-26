# 🥋 AutomationExercise — Karate API Test Suite

Suite de pruebas de integración automatizadas para la [API pública de AutomationExercise](https://automationexercise.com/api_list), desarrollada con **Karate DSL** y **JUnit 5**.

## 📋 Descripción

Este proyecto valida los **14 endpoints** de la API de AutomationExercise mediante pruebas automatizadas que cubren los cuatro métodos HTTP principales: `GET`, `POST`, `PUT` y `DELETE`. Las pruebas incluyen tanto escenarios positivos (flujo feliz) como negativos (validación de errores y métodos no soportados).

---

## 🛠️ Prerrequisitos

| Herramienta | Versión mínima | Instalación |
|-------------|----------------|-------------|
| **Java JDK** | 17+ | [Descargar JDK 17](https://adoptium.net/) |
| **Apache Maven** | 3.8+ | [Descargar Maven](https://maven.apache.org/download.cgi) |
| **Git** | 2.x | [Descargar Git](https://git-scm.com/) |

> **Nota:** Verifica tu instalación ejecutando:
> ```bash
> java -version   # Debe mostrar 17 o superior
> mvn -version     # Debe mostrar 3.8 o superior
> ```

---

## 🚀 Instalación

```bash
# 1. Clonar el repositorio
git clone <url-del-repositorio>
cd karate-automation-exercise

# 2. Instalar dependencias (Maven descarga automáticamente las dependencias)
mvn clean compile -DskipTests
```

---

## ▶️ Ejecución de Pruebas

### Ejecutar todas las pruebas

```bash
mvn test
```

### Ejecutar por archivo de feature (CLI Overrides)

Para que Maven no se confunda con los caracteres especiales en Windows (PowerShell/CMD), **encapsula toda la propiedad del sistema entre comillas**:

```bash
# Solo pruebas de productos (Sin el tag @API-N)
mvn test "-Dkarate.options=classpath:automationexercise/products.feature"

# Solo pruebas de cuenta
mvn test "-Dkarate.options=classpath:automationexercise/account.feature"

# Solo pruebas de login
mvn test "-Dkarate.options=classpath:automationexercise/login.feature"

# Solo pruebas de detalle de usuario
mvn test "-Dkarate.options=classpath:automationexercise/user_detail.feature"
```

### Ejecutar por método HTTP o Tags personalizados

```bash
# Ejecutar solo un tag específico (Recomendado)
mvn test "-Dkarate.options=--tags @GET"

# Combinar tags (Todos los @POST que NO sean @negative)
mvn test "-Dkarate.options=--tags @POST --tags ~@negative"
```

### Ejecutar escenarios negativos

```bash
mvn test "-Dkarate.options=--tags @negative"
```

---

## 📊 Reportes

Después de cada ejecución (sea total o parcial), los reportes se actualizan en:

```
target/karate-reports/karate-summary.html
```

Abre el archivo `karate-summary.html` en un navegador para ver el reporte visual con el detalle de cada escenario.

---

## 📁 Estructura del Proyecto

```
karate-automation-exercise/
├── pom.xml                          # Configuración Maven (dependencias, plugins)
├── build.gradle                     # Configuración Gradle (alternativa)
├── settings.gradle                  # Nombre del proyecto Gradle
├── run_tests.bat                    # Script de ejecución para Windows
├── README.md                        # Este archivo
└── src/
    └── test/
        └── java/
            ├── karate-config.js     # Configuración global de Karate (baseUrl, timeouts, SSL)
            └── automationexercise/
                ├── AutomationExerciseTest.java   # Runner JUnit 5 para todos los features
                ├── products.feature              # APIs 1-6: Productos y Marcas
                ├── account.feature               # APIs 11, 13, 12: Crear, Actualizar, Eliminar cuenta
                ├── login.feature                 # APIs 7-10: Verificación de login
                └── user_detail.feature           # API 14: Detalle de usuario por email
```

---

## 🗺️ Cobertura de APIs

| API | Endpoint | Método | Tipo | Feature | Tags |
|-----|----------|--------|------|---------|------|
| 1 | `/api/productsList` | GET | ✅ Positivo | `products.feature` | `@GET @API-1` |
| 2 | `/api/productsList` | POST | ⚠️ Negativo (405) | `products.feature` | `@POST @API-2 @negative` |
| 3 | `/api/brandsList` | GET | ✅ Positivo | `products.feature` | `@GET @API-3` |
| 4 | `/api/brandsList` | PUT | ⚠️ Negativo (405) | `products.feature` | `@PUT @API-4 @negative` |
| 5 | `/api/searchProduct` | POST | ✅ Positivo | `products.feature` | `@POST @API-5` |
| 6 | `/api/searchProduct` | POST | ⚠️ Negativo (400) | `products.feature` | `@POST @API-6 @negative` |
| 7 | `/api/verifyLogin` | POST | ✅ Positivo | `login.feature` | `@POST @API-7` |
| 8 | `/api/verifyLogin` | POST | ⚠️ Negativo (400) | `login.feature` | `@POST @API-8 @negative` |
| 9 | `/api/verifyLogin` | DELETE | ⚠️ Negativo (405) | `login.feature` | `@DELETE @API-9 @negative` |
| 10 | `/api/verifyLogin` | POST | ⚠️ Negativo (404) | `login.feature` | `@POST @API-10 @negative` |
| 11 | `/api/createAccount` | POST | ✅ Positivo | `account.feature` | `@POST @API-11` |
| 12 | `/api/deleteAccount` | DELETE | ✅ Positivo | `account.feature` | `@DELETE @API-12` |
| 13 | `/api/updateAccount` | PUT | ✅ Positivo | `account.feature` | `@PUT @API-13` |
| 14 | `/api/getUserDetailByEmail` | GET | ✅ Positivo | `user_detail.feature` | `@GET @API-14` |

**Cobertura total: 14/14 endpoints (100%)**

---

## ⚙️ Configuración

La configuración global se encuentra en [`karate-config.js`](src/test/java/karate-config.js):

| Propiedad | Valor | Descripción |
|-----------|-------|-------------|
| `baseUrl` | `https://automationexercise.com` | URL base de la API |
| `ssl` | `true` | Habilita soporte HTTPS |
| `connectTimeout` | `10000` ms | Timeout de conexión |
| `readTimeout` | `10000` ms | Timeout de lectura |

---

## 🧰 Stack Tecnológico

| Tecnología | Versión | Propósito |
|------------|---------|-----------|
| **Karate DSL** | 1.5.0 | Framework de pruebas de API (BDD) |
| **JUnit 5** | — | Plataforma de ejecución de pruebas |
| **Java** | 17 | Lenguaje base |
| **Maven** | 3.8+ | Gestión de dependencias y build |
| **Gradle** | 7+ | Build alternativo |

---

## 📝 Notas Importantes

- Las pruebas de `account.feature` crean usuarios temporales con emails únicos (basados en `System.currentTimeMillis()`) para evitar conflictos entre ejecuciones.
- Los escenarios de `login.feature` y `user_detail.feature` incluyen pasos de *setup* (crear cuenta) y *teardown* (eliminar cuenta) para mantener datos limpios.
- La API de AutomationExercise retorna siempre HTTP `200` a nivel de transporte; el código de respuesta real se encuentra dentro del JSON (`responseCode`).
