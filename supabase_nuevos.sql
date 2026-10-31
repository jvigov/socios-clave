-- Socios Clave · bandeja de NUEVOS SOCIOS traídos desde offix por el script de la PC.
-- SOLO crea una tabla nueva. No modifica socios, retos, dinamicas, eventos ni mesas.
create table if not exists public.socios_nuevos (
  codigo            text primary key,     -- Código Fuxion del socio
  oficina           text,                 -- Oficina patrocinadora (quien registra el caso)
  ini               text,                 -- Iniciales del titular (JV, GJ…)
  nombre            text,
  semana_afiliacion text,                 -- "43 - 2026"
  estado_offix      text,                 -- ACTIVO / INACTIVO en Afiliaciones
  pv_semana         numeric,
  rango             text,
  mi_estado         jsonb not null default '{}'::jsonb,   -- Activo, rango, QV personal/total, descuento
  ficha             text,                 -- Captura "Mi estado" (imagen PNG en base64)
  telefono          text,                 -- Lo pegas cuando soporte responde el caso
  pais              text,
  genero            text,                 -- socia | socio (corregible en la app)
  estado            text not null default 'pendiente',   -- pendiente | agregado | descartado
  atendido_at       timestamptz,
  socio_id          text,                 -- Socio creado en Socios Clave
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now()
);
alter table public.socios_nuevos enable row level security;
drop policy if exists "nuevos leer" on public.socios_nuevos;
drop policy if exists "nuevos insertar" on public.socios_nuevos;
drop policy if exists "nuevos actualizar" on public.socios_nuevos;
-- Igual que el resto de la app (abre con el link), pero SIN permiso de borrar.
create policy "nuevos leer"       on public.socios_nuevos for select to anon, authenticated using (true);
create policy "nuevos insertar"   on public.socios_nuevos for insert to anon, authenticated with check (true);
create policy "nuevos actualizar" on public.socios_nuevos for update to anon, authenticated using (true) with check (true);
