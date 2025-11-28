# Ansible Role: ClickHouse

## Описание

Развертывание Clickhouse

## Требования

- Rocky Linux 8/9
- Ansible 2.1+

## Переменные

```yaml
clickhouse_version: "stable"
clickhouse_http_port: 8123
clickhouse_database: "logs"
clickhouse_table: "vector_logs"
```

## Использование

```yaml
- hosts: clickhouse
  roles:
    - clickhouse
```

## Пример

```yaml
- hosts: databases
  vars:
    clickhouse_database: "app_logs"
    clickhouse_table: "nginx_logs"
  roles:
    - clickhouse
```

## Лицензия

MIT
