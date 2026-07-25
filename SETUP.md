# 📋 SECOP Alertas — Setup Guide

> Monitoreo automático de contratación pública colombiana → WhatsApp

---

## Arquitectura

```
datos.gov.co (Socrata API) ──cada 30min──▶ n8n ──filtro keywords──▶ Evolution API ──▶ WhatsApp
                                                  │
                                            Supabase (historial)
```

---

## Paso 1: Configurar Supabase (historial de contratos)

Crear tabla para evitar enviar la misma licitación 2 veces:

```sql
CREATE TABLE secop_alertas (
  id SERIAL PRIMARY KEY,
  id_contrato TEXT UNIQUE NOT NULL,
  proceso_compra TEXT,
  entidad TEXT,
  descripcion TEXT,
  valor_contrato NUMERIC,
  fecha_firma DATE,
  departamento TEXT,
  ciudad TEXT,
  enviado_en TIMESTAMP DEFAULT NOW()
);
```

## Paso 2: Obtener API Key de Evolution

1. http://148.230.90.171:8096/manager → instancia `flujodigital`
2. Copiar API Key

## Paso 3: Importar workflow en n8n

1. http://148.230.90.171:5678
2. Importar `001-secop-whatsapp.json`
3. Reemplazar `{{EVO_API_KEY}}` con la API key real
4. Editar las KEYWORDS en el nodo "Filtrar por Keywords" según el nicho del cliente
5. Activar workflow ⚡

## Paso 4: Keywords por sector

### Eléctrico
```
eléctric, electric, energía, iluminación, subestación, transformador,
redes, cableado, medidores, paneles solares, fotovoltaic, RETIE, NTC 2050,
montaje eléctrico, mantenimiento eléctrico
```

### Construcción
```
obras civiles, construcción, adecuación, infraestructura, vías, paviment,
alcantarillado, edificio, remodelación, urbanismo
```

### Consultoría
```
consultoría, interventoría, diseño, estudio, asesoría, estructuración,
formulación, diagnóstico, supervisión
```

### Tecnología
```
software, desarrollo, soporte, TI, digital, sistemas, cloud, datos,
ciberseguridad, transformación digital, página web, hosting
```

---

## Fuente de datos

- **API:** Socrata Open Data (datos.gov.co)
- **Dataset:** `jbjy-vk9h` — SECOP Contratos
- **Endpoint:** `https://www.datos.gov.co/resource/jbjy-vk9h.json`
- **Frecuencia:** Se actualiza diariamente
- **Campos:** entidad, descripción, valor, fecha, departamento, modalidad, etc.
