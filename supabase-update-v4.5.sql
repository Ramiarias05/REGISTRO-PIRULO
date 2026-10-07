-- Registro Pirulo v4.5: campos estructurados por tipo de registro
alter table public.registros
  add column if not exists details jsonb not null default '{}'::jsonb;

create index if not exists registros_details_gin_idx
  on public.registros using gin (details);
