# CLAUDE.md — sql/

Files in `sql/` follow the pattern:

```
YYYYMMDDNNNNNN_description.sql
```

Example: `20260321000001_neighborhoods.sql`

The leading date + sequence number ensures migrations apply in the correct order. The initial schema is `01_shops.sql` (legacy name, predates the convention).
