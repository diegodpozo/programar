# AGENTS.md — ProgramAR

Sitio estático (landing + FAQ + Mecánica + Precios) publicado en GitHub Pages. Sin backend, sin base de datos.

## Arquitectura modular (NO romper)

- **Fuente de verdad**: `src/pages/*.html` (head + contenido por página) y `src/templates/header.html` + `src/templates/footer.html`.
- **La raíz** (`index.html`, `faq.html`, `mecanica.html`, `precios.html`) contiene archivos **GENERADOS**. No se editan a mano.
- `build.ps1` ensambla cada página: head del `.pages` + plantilla de header + contenido + plantilla de footer.
- **Después de tocar `src/pages/` o `src/templates/`: ejecutar SIEMPRE `pwsh build.ps1`**, commitear también los archivos generados y verificar el deploy.

## Header y footer: ÚNICOS

- El header y el footer son **idénticos en todas las páginas** por definición (una sola fuente). Nunca agregar contenido específico de una página aquí.
- Para cambiar algo del header/footer (links, contacto, logos): editar la plantilla, correr el build, listo.

## Semántica HTML (obligatorio)

- **PROHIBIDO usar `<div>`**. No se introducen divs nuevos y los existentes se convierten.
- Usar `<section>` para contenedores/secciones y `<article>` para tarjetas autónomas (cards, steps, pcards, contact-item). Usar `<nav>`, `<header>`, `<footer>`, `<main>` semánticos cuando corresponda.

## JS compartido

- Todo el comportamiento (hamburguesa + header contraído) vive en `nav.js`, incluido con `<script src="nav.js" defer></script>`. No duplicar scripts inline en las páginas.

## Estilos y caché

- `styles.css` es el único CSS. Usar las variables `--bg`, `--grad`, `--card`, `--accent`, `--muted`, `--radius`.
- **Tras cambiar `styles.css`: subir el querystring de cache-busting** (`?v=N`) en el `<link rel="stylesheet">` de todas las páginas en `src/pages/`.

## Reglas de contenido

- Textos siempre en plural ("Armamos", "Escribinos"). Nunca mencionar "Diego Pozo".
- Contacto fijo: WhatsApp `https://wa.me/5491162648300`, mail `programarok@gmail.com`.
- Precios en USD con el asterisco de pie ("los valores no contienen IVA"). Lista de precios vigente:
  - Landing page: USD 400–900 según la implementación
  - Sitio web a medida: USD 3000 (sin límite de páginas)
  - Mantenimiento mensual: USD 150/mes
  - Análisis SEO: USD 200
  - Plan 1: USD 600 (15 días) · Plan 2: USD 1500 (90 días) · Plan 3: USD 900 alta + USD 150/mes
- Al agregar/renombrar una página: actualizar `sitemap.xml`, `robots.txt` (si aplica), `llms.txt` y `llms-full.txt`.

## Deploy

- Push a `main` → GitHub Pages. Esperar 40–90 s y verificar con `Invoke-WebRequest` (código 200 + contenido).