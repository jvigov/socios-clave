-- Socios Clave · base de datos (pega todo en Supabase → SQL Editor → Run)
-- 1) Tablas
create table if not exists public.socios (
  id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
create table if not exists public.retos (
  id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
create table if not exists public.dinamicas (
  id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
create table if not exists public.eventos (
  id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
create table if not exists public.mesas (
  id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- 2) Acceso: la app abre directo con el link (sin usuario ni contraseña)
alter table public.socios enable row level security;
drop policy if exists "equipo_socios" on public.socios;
create policy "equipo_socios" on public.socios for all to anon, authenticated using (true) with check (true);
alter table public.retos enable row level security;
drop policy if exists "equipo_retos" on public.retos;
create policy "equipo_retos" on public.retos for all to anon, authenticated using (true) with check (true);
alter table public.dinamicas enable row level security;
drop policy if exists "equipo_dinamicas" on public.dinamicas;
create policy "equipo_dinamicas" on public.dinamicas for all to anon, authenticated using (true) with check (true);
alter table public.eventos enable row level security;
drop policy if exists "equipo_eventos" on public.eventos;
create policy "equipo_eventos" on public.eventos for all to anon, authenticated using (true) with check (true);
alter table public.mesas enable row level security;
drop policy if exists "equipo_mesas" on public.mesas;
create policy "equipo_mesas" on public.mesas for all to anon, authenticated using (true) with check (true);

-- 3) Tiempo real: cambios de un líder aparecen al instante en el celular de los otros
do $$ begin alter publication supabase_realtime add table public.socios; exception when duplicate_object then null; end $$;
do $$ begin alter publication supabase_realtime add table public.retos; exception when duplicate_object then null; end $$;
do $$ begin alter publication supabase_realtime add table public.dinamicas; exception when duplicate_object then null; end $$;
do $$ begin alter publication supabase_realtime add table public.eventos; exception when duplicate_object then null; end $$;
do $$ begin alter publication supabase_realtime add table public.mesas; exception when duplicate_object then null; end $$;

-- 4) Tus datos actuales (copiados de la versión de prueba)
insert into public.socios (id, data) values ('l2lvascyl596', $json${"codigo": "3465214", "conducta": 2, "creado": 1790884828122, "creadoPor": "Johnatan", "duplicacion": 1, "fechaAfiliacion": "2026-09-28", "habilidad": "presentar", "hist": [], "lider": "Gino", "liderazgo": 1, "lideres": 0, "lideresFecha": "2026-10-01", "nombre": "Digna", "notas": [], "objetivo": "", "pais": "PE", "patrocinadorId": null, "ruta": {"evento": "2026-10-01", "foto": "2026-09-28", "grupos": "2026-09-28", "induccion": "2026-10-01", "perfil": null, "plan": "2026-10-01", "venta": "2026-10-01"}, "telefono": "42524424", "tipo": 3}$json$::jsonb) on conflict (id) do nothing;
insert into public.socios (id, data) values ('pmcg4fqlwbaj', $json${"codigo": "8565", "creado": 1790863514155, "creadoPor": "Johnatan", "etapas": {"afilio": "2026-10-01", "capacita": null, "connect": "2026-10-01", "evento": "2026-10-01", "inauguracion": "2026-10-01", "induccion": "2026-10-01", "plan": "2026-10-01", "venta": "2026-10-01"}, "fechaAfiliacion": "2026-10-01", "habilidad": "prospectar", "lider": "Johnatan", "nombre": "Alonso", "notas": [], "pais": "Colombia", "presentaciones": [], "relacion": "fria", "ruta": {"foto": "2026-10-01", "grupos": "2026-10-01", "lideres5": null, "objetivo": "2026-10-01"}, "tipo": 3, "tipoHist": [{"a": 2, "fecha": "2026-10-01", "por": "Johnatan"}, {"a": 3, "de": 2, "fecha": "2026-10-01", "por": "Johnatan"}]}$json$::jsonb) on conflict (id) do nothing;
