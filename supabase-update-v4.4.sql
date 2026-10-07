-- Registro Pirulo v4.4 — soporte para varios lugares en una sola visita/gira
-- Mantiene los datos existentes y migra el lugar anterior a la nueva lista.

alter table public.historial_giras
  add column if not exists place_ids bigint[];

update public.historial_giras
set place_ids = case
  when place_id is not null then array[place_id]
  else '{}'::bigint[]
end
where place_ids is null;

alter table public.historial_giras
  alter column place_ids set default '{}'::bigint[];

-- Mantener permisos actuales para usuarios autenticados.
revoke all on table public.historial_giras from anon;
grant select, insert, update, delete on table public.historial_giras to authenticated;
grant usage, select on sequence public.historial_giras_id_seq to authenticated;
